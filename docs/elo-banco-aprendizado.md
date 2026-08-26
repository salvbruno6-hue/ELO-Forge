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

## Roteamento do ELO APRENDER por assunto

Quando o usuário disser `ELO aprender`, o ELO deve primeiro identificar o assunto da aprendizagem e direcionar o registro para a memória correspondente.

```text
ELO aprender
 ↓
identificar assunto
 ├── ORÇAMENTO
 │    ↓
 │    memória de aprendizado de orçamento
 │    ↓
 │    docs/aprendizados/SO-XXX.26-CLIENTE.md no ELO-Forge
 │
 └── PLANEJAMENTO
      ↓
      memória de conhecimento de PLANEJAMENTO
      ↓
      estrutura de memória de Planejamento dentro do contexto/repositório Multiteiner
```

### Regra de roteamento

- Se `ELO aprender` estiver dentro de um assunto de **ORÇAMENTO**, o aprendizado deve seguir o caminho de orçamento e o loop de commit do `ELO-Forge`.
- Se `ELO aprender` estiver dentro de um assunto de **PLANEJAMENTO**, o aprendizado deve ser encaminhado para a **memória de conhecimento de Planejamento dentro do Multiteiner**, preservando a estrutura própria desse conhecimento.
- Não misturar aprendizado de orçamento com memória de planejamento.
- Se o assunto estiver explícito no contexto da conversa, não solicitar nova classificação ao usuário.
- Se o assunto não puder ser determinado com segurança, classificar como `PENDENTE` até haver definição.

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

## ELO APRENDER — LOOP DE COMMIT

Todo aprendizado explicitamente solicitado pelo usuário com `ELO aprender` deve seguir este caminho, respeitando primeiro o roteamento por assunto:

```text
ELO aprender
 ↓
identificar assunto
 ↓
ORÇAMENTO → caminho de aprendizado de orçamento
PLANEJAMENTO → memória de conhecimento do Planejamento / Multiteiner
 ↓
consolidar aprendizado da SO ou atividade
 ↓
classificar como decisão arbitrada
 ↓
registrar na memória correspondente
 ↓
validar se o aprendizado é reutilizável
 ↓
COMMIT no repositório correspondente
 ↓
confirmar SHA do commit, quando houver commit Git
 ↓
aprendizado disponível para futuras análises
```

### Caminho padrão de armazenamento — Orçamento

`salvbruno6-hue/ELO-Forge/docs/aprendizados/`

Padrão de arquivo:

`SO-XXX.26-NOME-CLIENTE.md`

O arquivo individual deve conter contexto, decisões arbitradas, premissas, regras de análise, resultado relevante e estado do aprendizado. Não registrar como aprendizado uma sugestão ainda não arbitrada.

### Regra de commit

Quando o usuário executar o comando conceitual `ELO aprender` seguido de `loop commit`, o ELO deve:

1. identificar se o contexto é orçamento ou planejamento;
2. direcionar para a memória correspondente;
3. recuperar o aprendizado consolidado;
4. verificar o arquivo/registro na memória correspondente;
5. criar ou atualizar o registro;
6. registrar o aprendizado no repositório correspondente;
7. retornar o SHA do commit realizado quando houver commit Git;
8. tratar o aprendizado como disponível para reutilização.

O commit é parte do loop de aprendizado e não uma etapa opcional quando o destino possui controle Git.

## Princípio arquitetural

O aprendizado deve preservar a cadeia semântica entre código, taxonomia, conceito, dimensão, aplicação, modelo, kit, material, `COD_PRODUT` e decisão. O ELO deve conversar com o banco por essas relações, e não depender apenas de similaridade textual ou conhecimento isolado do modelo.

Não criar tabelas paralelas por kit para representar composição. A arquitetura definitiva permanece:

`LISTA_MAE → KITS → KIT_ITENS → LISTA_MAE`

A camada de simulação permanece separada da camada cadastral e da camada de aprendizado de orçamento.
