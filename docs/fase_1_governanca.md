# Fase 1 - Governanca

## Objetivo

Criar a primeira camada soberana do ELO Forge: schemas oficiais, tabelas de governanca, rastreabilidade minima e protecao contra DELETE fisico.

## Arquivos

- `sql/001_create_schemas.sql`: cria os schemas oficiais.
- `sql/010_elo_governanca.sql`: cria tabelas, funcoes, triggers, indices e sementes de governanca.
- `supabase/migrations/20260521_001_create_elo_governanca.sql`: versao consolidada para aplicar no Supabase.

## Como aplicar no Supabase

1. Abrir o projeto correto no Supabase.
2. Ir em `SQL Editor`.
3. Criar uma nova query.
4. Copiar o conteudo de `supabase/migrations/20260521_001_create_elo_governanca.sql`.
5. Executar.

## Validacao

Depois de aplicar, conferir se existem os schemas:

```sql
select schema_name
from information_schema.schemata
where schema_name like 'elo_%'
order by schema_name;
```

Conferir as tabelas de governanca:

```sql
select table_schema, table_name
from information_schema.tables
where table_schema = 'elo_governanca'
order by table_name;
```

Conferir sementes iniciais:

```sql
select codigo, severidade
from elo_governanca.regras_negocio
order by codigo;
```

## Decisao de arquitetura

RLS ainda nao foi ativado nesta fase. A Fase 8 define perfis, politicas e testes. Ativar RLS sem politicas bloquearia o uso das tabelas.

DELETE fisico ja fica bloqueado por trigger nas tabelas de governanca. Para desativar registros, usar:

```sql
update elo_governanca.regras_negocio
set ativo = false
where codigo = 'CODIGO_DA_REGRA';
```

