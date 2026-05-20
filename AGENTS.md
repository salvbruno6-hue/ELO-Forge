# ELO Forge — AGENTS.md

## Identidade do Projeto

ELO Forge é o ambiente executor do ecossistema ELO.

O ELO governa.
O Forge constrói.
O Analytics aprende.
O Pulse monitora.
O Sentinel protege.

---

## Objetivo Principal

Transformar operação, PCP, comercial, engenharia e governança em um sistema operacional inteligente auditável.

---

## Princípios Soberanos

1. Governança antes dos dados
2. Auditoria desde o primeiro registro
3. IA aprende somente com decisões validadas
4. Nenhuma automação sem rastreabilidade
5. PCP é o alimentador soberano operacional
6. Contexto operacional vale mais que identidade nominal
7. Nunca permitir DELETE físico
8. Toda decisão automatizada deve gerar log

---

## Contextos Operacionais

### Governança
Contexto compatível:
- arquitetura
- IA
- parâmetros
- auditoria
- governança

Objetivos:
- rastreabilidade
- controle
- padronização
- escalabilidade

---

### Planejamento/Demanda
Contexto compatível:
- PCP
- capacidade
- sazonalidade
- demanda
- gargalos

Objetivos:
- previsão operacional
- redução de retrabalho
- sincronização entre demanda e produção

---

## Schemas Oficiais

- elo_governanca
- elo_auditoria
- elo_catalogo
- elo_estoque
- elo_pcp
- elo_comercial
- elo_analytics
- elo_contexto_operacional
- elo_auth

---

## Regras Técnicas

- Todo schema deve possuir rastreabilidade
- Todo registro operacional deve possuir:
  - created_at
  - updated_at
  - ativo
- Campos monetários:
  NUMERIC(12,2)
- Datas:
  TIMESTAMPTZ
- IA deve aprender apenas com dados concluídos e validados

---

## Diretriz Crítica

Se houver conflito entre:
- velocidade
- conveniência
- governança

A governança vence.
