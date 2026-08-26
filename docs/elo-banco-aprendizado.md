# ELO ↔ Banco de Dados — Diretriz de Aprendizado e Instrução

## Objetivo

O banco de dados é a fonte operacional e estrutural consultada pelo ELO. O ELO interpreta a demanda, consulta o banco, cruza conceitos, apresenta candidatos e aprende somente a partir de decisões arbitradas.

O banco não substitui o ELO. O ELO utiliza o banco para instruir, validar, rastrear e recuperar conhecimento operacional.

## Regra semântica

`modelos` representa somente a semântica do modelo (`M01`, `M02`, `M03` ...). A interpretação do modelo deve ser obtida pela relação com a taxonomia e pelos conceitos associados.

Exemplos de conceitos taxonômicos:

- `MLT.M` → módulo;
- `MLT.C` → marítimo/contêiner.

Cada conceito pode ser relacionado pelo ELO a dimensões, aplicações, estruturas, kits, materiais, processos e decisões de orçamento.

## Cadeia de conhecimento

```text
ELO
 ↓
interpretação da demanda
 ↓
TAXONOMIA
 ↓
CONCEITOS
 ↓
MODELO
 ↓
DIMENSÕES / APLICAÇÕES
 ↓
KITS
 ↓
KIT_ITENS
 ↓
LISTA_MAE
 ↓
COD_ITEM / COD_PRODUT
 ↓
ORÇAMENTO
 ↓
DECISÃO ARBITRADA
 ↓
APRENDIZADO ELO
 ↓
parâmetros reutilizáveis
```

## Regra de cadastro

A `lista_mae` é o cadastro mestre. Materiais não devem ser duplicados por kit ou aplicação. `COD_PRODUT` é a chave operacional utilizada pelo Almoxarifado para busca e rastreamento.

Kits referenciam a Lista Mãe por `kit_itens.lista_mae_id` quando houver correspondência. A descrição original do kit deve ser preservada quando não houver correspondência inequívoca.

## Regra de orçamento e aprendizado

Quando o ELO identificar uma aplicação, deve consultar a base para encontrar materiais candidatos, códigos e evidências anteriores. Exemplo: uma necessidade de reforço estrutural pode levar o ELO a consultar kits estruturais, Lista Mãe e associações de orçamento anteriores.

Sugestões do ELO não constituem aprendizado. O aprendizado nasce da decisão arbitrada pelo especialista.

Estados de decisão:

- `APROVADO`
- `REJEITADO`
- `AJUSTADO`
- `PENDENTE`

A decisão deve alimentar o histórico e, quando aplicável, atualizar a associação aprendida entre aplicação, contexto, necessidade, material e `COD_PRODUT`.

## Loop de aprendizado

```text
ORÇAMENTO
 ↓
ELO interpreta aplicação e contexto
 ↓
consulta Banco
 ↓
Lista Mãe + Taxonomia + Modelos + Dimensões + Kits + Histórico
 ↓
sugestão de materiais e COD_PRODUT
 ↓
especialista arbitra
 ↓
registro da decisão
 ↓
MERGE da associação aprendida
 ↓
confiança / ocorrências / evidência
 ↓
parâmetro reutilizável pelo ELO
```

## Princípio arquitetural

O aprendizado deve preservar a cadeia semântica entre código, taxonomia, conceito, dimensão, aplicação, modelo, kit, material, `COD_PRODUT` e decisão. O ELO deve conversar com o banco por essas relações, e não depender apenas de similaridade textual ou conhecimento isolado do modelo.

Não criar tabelas paralelas por kit para representar composição. A arquitetura definitiva permanece:

`LISTA_MAE → KITS → KIT_ITENS → LISTA_MAE`

A camada de simulação permanece separada da camada cadastral e da camada de aprendizado de orçamento.
