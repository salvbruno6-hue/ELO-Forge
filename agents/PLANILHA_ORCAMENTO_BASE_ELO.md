# PLANILHA DE ORÇAMENTO BASE ELO

## 1. Finalidade

Este arquivo define a base operacional de orçamento utilizada pelo ELO após a **Análise de Solicitação (SO)**.

A base deve ser tratada como **template mestre + regras de preenchimento + taxonomia comercial de referência**.

O objetivo é permitir que o Especialista de Orçamento:

1. analise a SO e seus documentos;
2. identifique o escopo comercial e técnico;
3. classifique produtos pela taxonomia oficial disponível;
4. separe produto padrão de excedentes/customizações;
5. organize serviços, materiais e mão de obra;
6. escolha as regras de VENDA ou LOCAÇÃO;
7. somente então preencha o orçamento mediante comando explícito.

---

## 2. Regra de acionamento

A **Análise de Solicitação** não preenche automaticamente o orçamento.

O orçamento é preenchido quando houver comando explícito do usuário, por exemplo:

`Preencher Planilha de Orçamento com base na análise.`

ou equivalente inequívoco.

Quando esse comando ocorrer, o especialista deve utilizar o resultado consolidado da análise e preencher somente informações sustentadas pelos documentos, pelas diretrizes do ELO ou por decisões/premissas explicitamente registradas.

---

## 3. Princípio de rastreabilidade

Toda informação usada no orçamento deve ser classificável como uma destas categorias:

- **DOCUMENTO** — informação explicitamente presente na SO/anexo/documento;
- **ANÁLISE** — conclusão técnica/comercial derivada dos documentos;
- **PREMISSA** — hipótese adotada para permitir o orçamento;
- **DECISÃO ARBITRADA** — decisão interna validada e registrada pelo ELO;
- **PENDÊNCIA** — informação não definida que impede conclusão segura.

Não transformar uma inferência em requisito documental.

Não inventar preço, quantidade, prazo, serviço, material, modelo ou responsabilidade.

---

# 4. ESTRUTURA DO ORÇAMENTO

## 4.1 Identificação

Campos:

- Tipo de negociação: VENDA ou LOCAÇÃO;
- Solicitação de Orçamento;
- Cliente;
- Local;
- Elaborado por;
- Revisão;
- Data;
- Revisado por;
- Folha;
- E-mail.

---

# 5. 1.0 COMERCIAL

A seção 1.0 é composta por **famílias comerciais**. Ela não deve ser interpretada como dez linhas genéricas independentes.

| Item-base | Produto | Taxonomia de referência |
|---|---|---|
| 1.1 | MODULAR | MLT.M |
| 1.2 | CONTEINER | MLT.C |
| 1.3 | ACESSÓRIOS | MLT.E |
| 1.4 | AR_CONDICIONADO | MLT.A |
| 1.5 | MOBILIÁRIO | MLT.B |
| 1.6 a 1.10 | Reserva | usar somente quando necessário |

### 5.1 Regra de seleção da taxonomia

O especialista deve seguir:

`necessidade da SO → família comercial → taxonomia compatível → quantidade → orçamento`

Exemplo:

`Escritório 20 pés com suíte → MODULAR → MLT.M02 → quantidade da SO`

A taxonomia deve ser usada quando houver correspondência suficiente entre o requisito da solicitação e a descrição cadastrada.

Se não houver correspondência segura, não forçar a classificação. Registrar pendência, premissa ou excedente conforme a análise.

---

# 6. TAXONOMIAS COMERCIAIS

## 6.1 MODULAR — MLT.M

- MLT.M01_Módulo Habitacional 20pés Amplo
- MLT.M02_Módulo Habitacional 20pés Escritório Suíte
- MLT.M03_Módulo Habitacional 10pés Escritório Suíte
- MLT.M04_Módulo Habitacional 20pés Bilheteria
- MLT.M05_Módulo Habitacional 20pés Sanitário Coletivo
- MLT.M06_Módulo Habitacional 20pés Sanitário Ele e Ela
- MLT.M07_Módulo Habitacional 20pés Sanitário Ele&ela PNE
- MLT.M08_Módulo Habitacional 10pés Sanitário PNE
- MLT.M09_Módulo Habitacional 20pés Sanitário 7 Chuveiros
- MLT.M10_Módulo Habitacional 10pés Amplo
- MLT.M11_Módulo Habitacional 20pés Escada Vai-e-vem
- MLT.M12_Módulo Habitacional 20pés Stand
- MLT.M13_Módulo Habitacional 20pés Stand Suíte
- MLT.M14_Módulo Habitacional 20pés Sanitário 7 Vasos
- MLT.M15_Módulo Habitacional 20pés Sanitário 9 Mictórios
- MLT.M16_Contêiner Escritório Modular Fixo 20 pés
- MLT.M17_Contêiner Suíte modular fixo 20 pés
- MLT.M18_Módulo Habitacional 10pés Bilheteria
- MLT.M19_Módulo Habitacional 15pés Amplo
- MLT.M20_Módulo Bipartido
- MLT.M21_Módulo Habitacional 10pés Sanitário 3 Vasos
- MLT.M22_Base Modular
- MLT.M23_Módulo Habitacional 20pés Sanitário Ele e Ela com chuveiro
- MLT.M24_Módulo Habitacional 20Pés Sanitário Ele e Ela + PNE
- MLT.M25_Módulo Habitacional 8pés Sanitário PNE
- MLT.M26_Módulo Habitacional 20Pés Sanitário 5 cabines + PNE
- MLT.M27_Módulo Amoxarifado 20Pés

## 6.2 CONTEINER — MLT.C

- MLT.C01_Contêiner Almoxarifado 20 pés simples
- MLT.C02_Contêiner Almoxarifado 40 pés simples
- MLT.C03_Contêiner Cantina 20 pés
- MLT.C04_Contêiner Depósito 10 pés
- MLT.C05_Contêiner Depósito 20 pés (AZUL)
- MLT.C06_Contêiner Depósito 20 pés
- MLT.C07_Contêiner Depósito 40 pés HC (AZUL)
- MLT.C08_Contêiner Depósito 40 pés HC
- MLT.C09_Contêiner Escritório 10 pés Forrado
- MLT.C10_Contêiner Escritório 20 pés Forrado
- MLT.C11_Contêiner Escritório 40 pés Forrado
- MLT.C12_Contêiner Escritório 10 pés Simples
- MLT.C13_Contêiner Escritório 20 pés Simples
- MLT.C14_Contêiner Escritório 40 pés Simples
- MLT.C15_Contêiner Frigorífico 20 pés
- MLT.C16_Contêiner Frigorífico 10 pés
- MLT.C17_Contêiner Open Top 20 pés com Lona
- MLT.C18_Contêiner Open Top 40 pés com Lona
- MLT.C19_Contêiner Bilheteria 20 pés
- MLT.C20_Contêiner Sanitário 20 pés 7 Chuveiros
- MLT.C21_Contêiner Sanitário 20 pés 7 Vasos
- MLT.C22_Contêiner Sanitário 20 pés Coletivo Cabinado
- MLT.C23_Contêiner Sanitário 20 pés Ele e Ela
- MLT.C24_Contêiner Suíte Forrada 10 pés
- MLT.C25_Contêiner Suíte Forrada 20 pés
- MLT.C26_Contêiner Suíte Forrada 40 pés
- MLT.C27_Contêiner Suíte Simples 10 pés
- MLT.C28_Contêiner Suíte Simples 20 pés
- MLT.C29_Contêiner Suíte Simples 40 pés
- MLT.C31_Contêiner Depósito Conair 20 pés

## 6.3 ACESSÓRIOS / EQUIPAMENTOS — MLT.E

Usar a taxonomia MLT.E como referência para equipamentos e acessórios fornecidos no catálogo do ELO.

A lista cadastrada na base de treinamento inclui, entre outros:

- MLT.E01_ESCADA METÁLICA PADRÃO 3,0M ALTURA
- MLT.E02_CAIXA DE DEJETOS 5.000L (2,5 x 6,0)
- MLT.E03_TELHADO METÁLICO M²
- MLT.E04_Passarela Metálica m²
- MLT.E05_Guarda-corpo m²
- MLT.E06_ESLINGA P/ CONTÊINER OFFSHORE 20PÉS DRY 25TON
- MLT.E07_ESLINGA P/ CONTÊINER OFFSHORE 10PÉS DRY 12,5TON
- MLT.E08_ESCADA METÁLICA PADRÃO 1,2M C/ CAVALETE
- MLT.E09_CAIXA DE DEJETOS 5.000L (2,5 x 3,0)
- MLT.E10_ESLINGA P/ SKID (1,21 x 1,15 x 2,12) 1.800KG
- MLT.E11_ESLINGA P/ CESTA 8M 11,2TON
- MLT.E12_ESLINGA P/ CONTÊINER OFFSHORE 2M DRY 10,5TON
- MLT.E13_ESLINGA P/ CESTA 12M 13,85TON
- MLT.E14_ESLINGA P/ CESTA 10M 13TON
- MLT.E15_ESLINGA P/ CESTA 14M 16,2TON
- MLT.E16_ESLINGA P/ CESTA 21M 17,56TON
- MLT.E17_ESLINGA P/ CESTA 18M 17,1TON
- MLT.E18_ESLINGA P/ CESTA 4M 4,6TON
- MLT.E19_ESLINGA P/ CESTA 2,6M 4,2TON
- MLT.E20_ESLINGA P/ CAIXA (1,00 x 1,00 x 1,00) 2,55TON
- MLT.E21_GALPÃO PIPE SHOP 80M²
- MLT.E23_ESLINGA P/ OPEN TOP CORAÇÃO DE MÃE 6X4X4 31,5TON
- MLT.E24_ESLINGA P/ CESTA 2,95M 6,5TON
- MLT.E25_ESCADA METÁLICA PADRÃO 0,55M

## 6.4 AR-CONDICIONADO — MLT.A

Usar a família MLT.A para os equipamentos de climatização disponíveis na base.

Regra: selecionar o equipamento de acordo com a necessidade identificada na SO e na análise técnica; não inferir capacidade sem sustentação.

Referências fornecidas para a base:

- Ar Condicionado de Janela 12.000Btu's
- MLT.A02_Ar Condicionado de Janela 18.000Btu's
- MLT.A02_Ar Condicionado de Janela 21.000Btu's
- MLT.A02_Ar Condicionado de Janela 10.000Btu's
- MLT.A02_Evaporadora split 12.000Btu's
- MLT.A02_Condensadora split 12.000Btu's

## 6.5 MOBILIÁRIO — MLT.B

Usar a família MLT.B para os itens de mobiliário disponíveis na base.

Referências fornecidas para a base:

- MLT.B01_Beliche sem colchão
- MLT.B01_Colchão solteiro
- MLT.B01_MESA (1,20M x 0,68CM x 0,73CM)
- MLT.B01_CADEIRA GIRATÓRIA COM BRAÇO
- MLT.B01_CADEIRA GIRATÓRIA SEM BRAÇO
- MLT.B01_ARMÁRIO (0,99M x 0,85M x 0,40M) 2 PORTAS C/ CHAVE
- MLT.B01_MESA REDONDA (1,20 X 0,75cm)
- MLT.B01_CADEIRA FIXA SEM BRAÇO
- MLT.B01_BALCÃO DE ATENDIMENTO (2,79M X 0,98M X 0,51M)
- MLT.B01_FRIGOBAR

---

# 7. 2.0 COMPOSIÇÃO

## 7.1 Serviço

Usar esta seção para serviços que não sejam o produto comercial principal ou que devam ser separados para composição de custo.

Exemplos de natureza:

- montagem;
- instalação;
- transporte quando tratado como serviço;
- mobilização/desmobilização;
- içamento;
- interligações;
- testes;
- comissionamento;
- serviços especiais.

Cada item deve possuir descrição, unidade, quantidade, valor unitário e valor parcial quando disponíveis.

## 7.2 Material

Usar esta seção para materiais adicionais associados ao escopo, especialmente quando não fizerem parte do produto comercial padrão.

A inclusão deve ser sustentada por documento, análise técnica, premissa registrada ou decisão arbitrada.

## 7.3 Mão de Obra Interna

Modelo padrão:

- Encarregado — referência de valor unitário: R$ 448,21;
- Profissional — referência de valor unitário: R$ 275,82;
- Ajudante — referência de valor unitário: R$ 235,92.

Os valores de referência não substituem a fonte oficial vigente quando existir tabela atualizada.

A quantidade deve considerar dias trabalhados e quantidade de colaboradores quando aplicável.

## 7.4 Mão de Obra Externa

Mesma lógica da mão de obra interna, porém separada para serviços executados por terceiros/contratados externos.

Não classificar uma atividade como mão de obra externa sem base na análise, escopo ou decisão comercial.

---

# 8. VENDA x LOCAÇÃO

## VENDA

- Natureza: venda;
- BDI padrão da planilha de referência: **96,00%**;
- Taxa de Administração: **aplicável** conforme a estrutura da planilha;
- Total geral deve seguir a regra comercial vigente.

## LOCAÇÃO

- Natureza: locação;
- BDI padrão da planilha de referência: **65,00%**;
- Taxa de Administração: **não aplicável**;
- Total geral deve seguir a regra comercial vigente.

Não confundir prazo de locação com prazo de fabricação, implantação ou mobilização.

---

# 9. REGRA PARA EXCEDENTES E CUSTOMIZAÇÕES

O produto comercial padrão deve ficar separado de modificações e complementos necessários.

Exemplo conceitual:

**Comercial:** MLT.M01 — Módulo Habitacional 20pés Amplo — quantidade solicitada.

**Composição:** materiais/serviços/mão de obra referentes a alterações, adaptações ou itens adicionais.

Se a solicitação não corresponder exatamente ao catálogo, o especialista deve:

1. identificar o modelo-base mais aderente;
2. listar as diferenças;
3. classificar como excedente/customização/pêndencia;
4. levar os custos adicionais para a composição correspondente.

Não criar um novo código de produto apenas para resolver uma configuração especial.

---

# 10. REGRA DE PREENCHIMENTO

Quando o comando de preenchimento for emitido, seguir a ordem:

1. Identificação da SO;
2. Tipo de negociação;
3. Cliente e local;
4. Produtos comerciais;
5. Taxonomias e quantidades;
6. Serviços;
7. Materiais;
8. Mão de obra interna;
9. Mão de obra externa;
10. Subtotais;
11. Taxa de Administração, quando aplicável;
12. BDI;
13. Total Geral;
14. Descrição do produto;
15. Observações;
16. Pendências relevantes para emissão do orçamento.

---

# 11. REGRA DE NÃO PREENCHIMENTO

Não preencher automaticamente valores que não tenham fonte.

Quando não houver dado suficiente:

- quantidade desconhecida → deixar pendente;
- preço desconhecido → não inventar;
- necessidade técnica incerta → classificar como A CONFIRMAR/PREMISSA;
- responsabilidade incerta → não assumir;
- produto sem correspondência segura → não forçar taxonomia.

---

# 12. PERFIL DO ESPECIALISTA DE ORÇAMENTO

O especialista deve pensar como responsável pelo resultado econômico e técnico do orçamento.

Deve perguntar:

- O que o cliente realmente precisa receber?
- Qual produto padrão atende ao requisito?
- O que está fora do padrão?
- O que é necessário para funcionar?
- O que precisa ser comprado?
- O que precisa ser fabricado?
- O que precisa ser instalado?
- Quem executa cada etapa?
- Qual logística é necessária?
- Existe engenharia envolvida?
- Existe risco de custo oculto?
- Existe risco de responsabilidade contratual?
- Existe prazo incompatível?
- Qual informação ainda precisa ser confirmada?

O especialista deve proteger o orçamento contra:

- omissões;
- dupla contagem;
- classificação incorreta;
- quantitativos incorretos;
- premissas não declaradas;
- responsabilidades assumidas sem base;
- customizações não precificadas;
- logística esquecida;
- custos de instalação não considerados;
- equipamentos obrigatórios esquecidos;
- diferenças entre venda e locação.

---

# 13. SAÍDA ESPERADA

Após o comando explícito de preenchimento, o resultado deve manter a mesma estrutura da planilha mestre e apresentar:

- dados da SO;
- família comercial;
- taxonomia selecionada;
- quantidades;
- composição;
- subtotais;
- BDI correto;
- taxa de administração quando aplicável;
- total geral;
- observações;
- pendências que impeçam ou limitem a emissão final.

O arquivo mestre não deve ser sobrescrito durante um teste. Deve ser criada uma versão preenchida derivada da base.

---

# 14. RELAÇÃO COM A DIRETRIZ ELO ANALISAR

Este arquivo é complementar à diretriz:

`agents/ELO_ANALISAR_DIRETRIZ_ESPECIALISTA_ORCAMENTO.md`

A diretriz **ELO ANALISAR** determina como o especialista analisa a SO.

Este arquivo determina como o resultado dessa análise é convertido em estrutura de orçamento.

Fluxo:

`SO/documentos → ELO ANALISAR → análise consolidada → comando de preenchimento → PLANILHA DE ORÇAMENTO`

---

# 15. GOVERNANÇA DA APRENDIZAGEM

Este arquivo é uma base de conhecimento operacional.

O ELO não deve aprender uma regra nova apenas porque ela apareceu em uma análise casual.

Novas regras de orçamento devem ser incorporadas como conhecimento institucional somente após validação/decisão arbitrada conforme a governança do ELO.

A fonte de aprendizado deve ser:

`resultado arbitrado → registro da regra → atualização controlada da base`

Não utilizar erro de uma cotação isolada como regra geral.

---

# 16. OBJETIVO DE TREINAMENTO

Ao usar este arquivo repetidamente com SOs reais e decisões arbitradas, o Especialista de Orçamento deve melhorar sua capacidade de:

- identificar o produto correto;
- classificar taxonomias;
- diferenciar padrão e customização;
- montar composição;
- detectar custos ocultos;
- separar venda e locação;
- registrar premissas;
- levantar questionamentos relevantes;
- reduzir omissões e retrabalho;
- preservar rastreabilidade.

**Regra final:** precisão documental + análise técnica + disciplina comercial + rastreabilidade.
