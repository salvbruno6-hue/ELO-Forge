-- ELO FORGE
-- MIGRATION 009
create schema if not exists elo_fluxo;

create table if not exists elo_fluxo.status_kanban (
 id uuid primary key default gen_random_uuid(),
 codigo varchar(50) unique not null,
 nome varchar(100) not null,
 cor varchar(30) not null,
 ativo boolean default true,
 created_at timestamptz default now()
);

create table if not exists elo_fluxo.setores (
 id uuid primary key default gen_random_uuid(),
 codigo varchar(50) unique not null,
 nome varchar(150) not null,
 ordem_fluxo integer not null,
 ativo boolean default true,
 created_at timestamptz default now()
);

create table if not exists elo_fluxo.pedidos (
 id uuid primary key default gen_random_uuid(),
 numero_pedido varchar(100) not null,
 cliente varchar(250),
 familia varchar(150),
 modelo varchar(150),
 descricao text,
 data_abertura timestamptz default now(),
 data_prevista_entrega date,
 data_real_entrega date,
 status_geral varchar(100)
);
