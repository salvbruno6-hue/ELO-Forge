create schema if not exists elo_governanca;
create schema if not exists elo_auditoria;
create schema if not exists elo_catalogo;
create schema if not exists elo_estoque;
create schema if not exists elo_pcp;
create schema if not exists elo_comercial;
create schema if not exists elo_analytics;
create schema if not exists elo_contexto_operacional;
create schema if not exists elo_auth;

create extension if not exists pgcrypto;

create or replace function elo_governanca.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create or replace function elo_governanca.prevent_physical_delete()
returns trigger
language plpgsql
as $$
begin
  raise exception 'DELETE fisico bloqueado por governanca. Use ativo = false.';
end;
$$;

create table if not exists elo_governanca.regras_negocio (
  id uuid primary key default gen_random_uuid(),
  dominio text not null,
  tipo text not null,
  codigo text not null unique,
  descricao text not null,
  expressao text,
  severidade text not null default 'media',
  vigencia_inicio timestamptz not null default now(),
  vigencia_fim timestamptz,
  ativo boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  criado_por uuid references auth.users(id) on delete set null,
  atualizado_por uuid references auth.users(id) on delete set null,
  constraint regras_negocio_severidade_check
    check (severidade in ('baixa', 'media', 'alta', 'critica'))
);

create table if not exists elo_governanca.parametros_sistema (
  id uuid primary key default gen_random_uuid(),
  chave text not null unique,
  valor text not null,
  tipo_dado text not null,
  descricao text,
  dominio text not null default 'global',
  editavel boolean not null default true,
  ativo boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  criado_por uuid references auth.users(id) on delete set null,
  atualizado_por uuid references auth.users(id) on delete set null,
  constraint parametros_sistema_tipo_dado_check
    check (tipo_dado in ('text', 'integer', 'numeric', 'boolean', 'json', 'timestamptz'))
);

create table if not exists elo_governanca.validacoes_entrada (
  id uuid primary key default gen_random_uuid(),
  schema_alvo text not null,
  tabela_alvo text not null,
  campo text not null,
  codigo text not null unique,
  expressao text not null,
  mensagem_erro text not null,
  severidade text not null default 'alta',
  ativo boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  criado_por uuid references auth.users(id) on delete set null,
  atualizado_por uuid references auth.users(id) on delete set null,
  constraint validacoes_entrada_severidade_check
    check (severidade in ('baixa', 'media', 'alta', 'critica'))
);

create table if not exists elo_governanca.glossario (
  id uuid primary key default gen_random_uuid(),
  termo text not null unique,
  definicao text not null,
  dominio text not null,
  sinonimos text[],
  exemplo_uso text,
  ativo boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  criado_por uuid references auth.users(id) on delete set null,
  atualizado_por uuid references auth.users(id) on delete set null
);

create table if not exists elo_governanca.versoes_catalogo (
  id uuid primary key default gen_random_uuid(),
  entidade text not null,
  entidade_id uuid,
  versao integer not null,
  snapshot_json jsonb not null,
  motivo text,
  ativo boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  criado_por uuid references auth.users(id) on delete set null,
  atualizado_por uuid references auth.users(id) on delete set null,
  constraint versoes_catalogo_versao_check check (versao > 0)
);

create table if not exists elo_governanca.politicas_acesso (
  id uuid primary key default gen_random_uuid(),
  perfil text not null,
  schema_alvo text not null,
  tabela_alvo text,
  operacao text not null,
  permitido boolean not null default false,
  justificativa text not null,
  ativo boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  criado_por uuid references auth.users(id) on delete set null,
  atualizado_por uuid references auth.users(id) on delete set null,
  constraint politicas_acesso_operacao_check
    check (operacao in ('select', 'insert', 'update', 'delete', 'all'))
);

create index if not exists regras_negocio_dominio_idx
  on elo_governanca.regras_negocio (dominio);

create index if not exists parametros_sistema_dominio_idx
  on elo_governanca.parametros_sistema (dominio);

create index if not exists validacoes_entrada_alvo_idx
  on elo_governanca.validacoes_entrada (schema_alvo, tabela_alvo);

create index if not exists glossario_dominio_idx
  on elo_governanca.glossario (dominio);

create index if not exists versoes_catalogo_entidade_idx
  on elo_governanca.versoes_catalogo (entidade, entidade_id);

create index if not exists politicas_acesso_alvo_idx
  on elo_governanca.politicas_acesso (perfil, schema_alvo, tabela_alvo, operacao);

do $$
declare
  table_name text;
begin
  foreach table_name in array array[
    'regras_negocio',
    'parametros_sistema',
    'validacoes_entrada',
    'glossario',
    'versoes_catalogo',
    'politicas_acesso'
  ]
  loop
    if not exists (
      select 1
      from pg_trigger
      where tgname = table_name || '_set_updated_at'
    ) then
      execute format(
        'create trigger %I before update on elo_governanca.%I for each row execute function elo_governanca.set_updated_at()',
        table_name || '_set_updated_at',
        table_name
      );
    end if;

    if not exists (
      select 1
      from pg_trigger
      where tgname = table_name || '_prevent_delete'
    ) then
      execute format(
        'create trigger %I before delete on elo_governanca.%I for each row execute function elo_governanca.prevent_physical_delete()',
        table_name || '_prevent_delete',
        table_name
      );
    end if;
  end loop;
end;
$$;

insert into elo_governanca.parametros_sistema (chave, valor, tipo_dado, descricao, dominio)
values
  ('governanca.delete_fisico_permitido', 'false', 'boolean', 'DELETE fisico permanece bloqueado por principio soberano.', 'governanca'),
  ('ia.aprendizado_apenas_validado', 'true', 'boolean', 'IA aprende somente com dados concluidos e validados.', 'analytics'),
  ('auditoria.log_decisao_automatizada', 'true', 'boolean', 'Toda decisao automatizada deve gerar log.', 'auditoria')
on conflict (chave) do nothing;

insert into elo_governanca.glossario (termo, definicao, dominio)
values
  ('Governanca', 'Camada soberana que define regras, validade, rastreabilidade e limites do sistema.', 'governanca'),
  ('Soft delete', 'Desativacao logica de registro por ativo = false, sem remocao fisica.', 'governanca'),
  ('PCP', 'Planejamento e Controle da Producao, alimentador soberano operacional do ELO.', 'pcp')
on conflict (termo) do nothing;

insert into elo_governanca.regras_negocio (dominio, tipo, codigo, descricao, expressao, severidade)
values
  ('governanca', 'restricao', 'REGRA_SEM_DELETE_FISICO', 'Nenhum registro operacional deve ser apagado fisicamente.', 'usar ativo = false', 'critica'),
  ('analytics', 'restricao', 'REGRA_IA_DADOS_VALIDADOS', 'IA aprende somente com decisoes e dados concluidos e validados.', 'status in (concluido, validado)', 'critica'),
  ('auditoria', 'obrigatoriedade', 'REGRA_LOG_DECISAO_AUTOMATIZADA', 'Toda decisao automatizada deve gerar log rastreavel.', 'log obrigatorio', 'critica')
on conflict (codigo) do nothing;

