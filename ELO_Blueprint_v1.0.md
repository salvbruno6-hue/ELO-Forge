# ELO SYSTEM
## Blueprint de Arquitetura de Dados
**Documento de Referência do Projeto — v1.0**

**Versão:** 1.0  
**Status:** Em construção  
**Criado:** Maio/2026

---

## 1. Visão Geral do Projeto

O ELO System é um banco de dados operacional e analítico projetado para uma empresa fabricante de módulos habitacionais e sanitários. O sistema nasce com foco no PCP como alimentador principal de dados, evoluindo progressivamente para integrar comercial, almoxarifado, orçamentos e inteligência artificial.

### Objetivos estratégicos
- Substituir planilhas Excel do PCP por dados estruturados e rastreáveis
- Cruzar dados de fabricação, estoque e demanda para tomada de decisão
- Parametrizar orçamentos com base em dados reais de produção e excedentes
- Alimentar IA comercial com capacidade produtiva e prazos precisos
- Identificar gargalos, sazonalidade e otimizar linha de produção
- Escalar para autenticação por perfil quando a estrutura estiver consolidada

### Filosofia de construção
**Simples na estrutura, poderoso no cruzamento.** O PCP alimenta, a IA analisa, o Comercial responde. A governança nasce antes dos dados. A auditoria acompanha tudo desde o primeiro registro.

---

## 2. Arquitetura de Schemas

O banco é organizado em 8 schemas independentes, cada um com responsabilidade clara. Essa separação facilita controle de acesso, manutenção e escalabilidade futura.

| Schema | Responsabilidade | Pergunta que responde |
|---|---|---|
| `elo_catalogo` | Catálogo técnico de produtos | O QUE fabricamos? |
| `elo_pcp` | Planejamento e controle da produção | COMO e QUANDO fabricamos? |
| `elo_estoque` | Almoxarifado e pátio | O QUE temos disponível? |
| `elo_comercial` | Solicitações e orçamentos | O QUE o cliente quer? |
| `elo_analytics` | Parâmetros, KPIs e IA | O QUE os dados revelam? |
| `elo_governanca` | Regras, validações e versões | O QUE é permitido e válido? |
| `elo_auditoria` | Logs de alteração e acesso | O QUE aconteceu e quem fez? |
| `elo_auth` | Usuários, perfis e permissões | QUEM é e o que pode fazer? |

---

## 3. Detalhamento por Schema

### 3.1 `elo_governanca` — Fase 1 (construir primeiro)
Contém as regras que tornam o sistema inteligente e com memória institucional. Nasce antes de qualquer dado.

| Tabela | Finalidade | Campos-chave |
|---|---|---|
| `regras_negocio` | Regras de validação, cálculo e restrição | `dominio`, `tipo`, `severidade`, `vigencia` |
| `parametros_sistema` | Configurações editáveis sem alterar código | `chave`, `valor`, `tipo_dado` |
| `versoes_catalogo` | Snapshot histórico de qualquer registro | `entidade`, `versao`, `snapshot_json` |
| `validacoes_entrada` | Contrato de dados antes de salvar | `tabela_alvo`, `campo`, `expressao` |
| `glossario` | Vocabulário oficial do negócio | `termo`, `definicao`, `dominio` |
| `politicas_acesso` | Base para as políticas RLS futuras | `perfil`, `schema_alvo`, `operacao` |

### 3.2 `elo_auditoria` — Fase 2 (ativar junto com o primeiro dado)
Memória completa do sistema. Tudo que muda fica registrado automaticamente via trigger.

| Tabela | Finalidade | Campos-chave |
|---|---|---|
| `log_alteracoes` | Rastreia cada mudança de campo | `tabela`, `campo`, `valor_antes`, `valor_depois`, `usuario_id` |
| `log_acessos` | Registra acessos e ações por usuário | `usuario_id`, `acao`, `recurso`, `resultado` |
| `log_erros` | Captura erros do sistema | `origem`, `mensagem`, `contexto_json`, `severidade` |
| `snapshots_diarios` | Foto diária de contagens por tabela | `schema_alvo`, `tabela`, `total_registros`, `hash_conteudo` |

### 3.3 `elo_catalogo` — Fase 3 (fundação técnica)
Base de tudo. Os 27 modelos, lista mãe de materiais e kits vivem aqui. Sem catálogo, nenhum outro schema funciona.

| Tabela | Finalidade | Campos-chave |
|---|---|---|
| `modelos` | 27 modelos com atributos técnicos | `codigo`, `area_m2`, `complexidade`, `tempo_fabricacao_horas_padrao` |
| `produtos` | Lista mãe de materiais | `codigo`, `categoria`, `unidade`, `lead_time_dias`, `estoque_minimo` |
| `modelo_materiais` | BOM: quanto de cada produto por modelo | `modelo_id`, `produto_id`, `quantidade`, `unidade` |
| `kits` | Agrupamentos de produtos reutilizáveis | `codigo`, `descricao`, `categoria` |
| `modelo_kits` | Quais kits compõem cada modelo | `modelo_id`, `kit_id`, `quantidade`, `obrigatorio` |
| `restricoes_modelo` | Restrições técnicas por modelo | `modelo_id`, `tipo_restricao`, `descricao` |

### 3.4 `elo_estoque` — Fase 4
Visibilidade do pátio e almoxarifado. O PCP enxerga materiais disponíveis; o Comercial enxerga módulos prontos.

| Tabela | Finalidade | Campos-chave |
|---|---|---|
| `patios` | Locais físicos (pátio A, B, expedição) | `codigo`, `descricao`, `capacidade_maxima` |
| `estoque_modelos` | Unidades prontas por modelo no pátio | `modelo_id`, `patio_id`, `quantidade`, `status` |
| `movimentacoes` | Entrada/saída de módulos do pátio | `modelo_id`, `tipo`, `quantidade`, `data`, `origem` |
| `estoque_materiais` | Saldo atual de cada produto no almox. | `produto_id`, `quantidade_atual`, `localizacao` |
| `requisicoes` | Pedido de material do PCP ao almox. | `ordem_producao_id`, `produto_id`, `quantidade`, `status` |

### 3.5 `elo_pcp` — Fase 5 (coração operacional)
Principal alimentador de dados do sistema. Cada ordem, cada etapa e cada apontamento gera inteligência para analytics e comercial.

| Tabela | Finalidade | Campos-chave |
|---|---|---|
| `ordens_producao` | Cada módulo em fabricação | `modelo_id`, `status`, `data_inicio_prevista`, `data_fim_real` |
| `etapas_processo` | Catálogo fixo e ordenado das etapas | `codigo`, `descricao`, `ordem`, `tempo_padrao_horas` |
| `ordens_etapas` | Execução de cada etapa por ordem | `ordem_id`, `etapa_id`, `tempo_previsto`, `tempo_real`, `operador_id` |
| `apontamentos` | Registro granular de tempo por operador | `ordem_etapa_id`, `operador_id`, `inicio`, `fim`, `observacao` |
| `pausas_producao` | Motivos e duração de pausas | `ordem_id`, `motivo`, `duracao_horas` |
| `capacidade_fabril` | Slots disponíveis por período | `periodo`, `slots_disponiveis`, `slots_ocupados`, `projecao_conclusao` |

### 3.6 `elo_comercial` — Fase 6
Demanda conectada à capacidade produtiva. Cada solicitação gera automaticamente uma ordem no PCP.

| Tabela | Finalidade | Campos-chave |
|---|---|---|
| `solicitacoes` | Pedidos recebidos | `cliente`, `status`, `prazo`, `responsavel`, `prioridade` |
| `solicitacao_itens` | Modelos e quantidades por solicitação | `solicitacao_id`, `modelo_id`, `quantidade` |
| `orcamentos` | Valores e condições por solicitação | `solicitacao_id`, `valor_total`, `validade`, `status` |
| `excedentes` | Itens fora do padrão com custo adicional | `solicitacao_id`, `descricao`, `classificacao`, `valor` |

### 3.7 `elo_analytics` — Fase 7 (inteligência sobre dados reais)
Só tem substância após dados acumulados nas fases anteriores. É onde o banco começa a pensar junto com a empresa.

| Tabela | Finalidade | Campos-chave |
|---|---|---|
| `parametros_modelo` | Tempo e custo médio real por modelo | `modelo_id`, `tempo_medio_horas`, `custo_medio`, `desvio_padrao` |
| `ranking_demanda` | Modelos mais pedidos por período | `modelo_id`, `periodo`, `total_solicitado`, `posicao` |
| `sazonalidade` | Demanda histórica por modelo/mês | `modelo_id`, `mes`, `ano`, `demanda_historica` |
| `estoque_sugerido_patios` | Nível ideal de pátio calculado pela IA | `modelo_id`, `quantidade_sugerida`, `justificativa` |
| `gargalos_identificados` | Etapas com desvio frequente | `etapa_id`, `frequencia`, `impacto_horas`, `status` |
| `decisoes_ia` | Rastreabilidade das análises geradas | `contexto`, `input_json`, `output_json`, `modelo_ia` |

### 3.8 `elo_auth` — Fase 8 (implementar por último)
Autenticação e permissões. Implementar somente após estrutura consolidada e dados reais validados. Cada tabela receberá RLS baseado nos perfis definidos aqui.

| Tabela | Finalidade | Campos-chave |
|---|---|---|
| `perfis` | Papéis do sistema | `codigo`, `descricao` (ADMIN, PCP, COMERCIAL, ALMOXARIFE, IA_READER) |
| `usuarios_perfis` | Vínculo entre auth.users e perfis | `user_id` (FK auth.users), `perfil_id`, `ativo` |

---

## 4. Fluxo de Dados

Como a informação percorre o sistema do pedido ao insight:

| # | Etapa | Schema | O que acontece |
|---|---|---|---|
| 1 | Solicitação entra | `elo_comercial` | Cliente solicita modelos e prazo |
| 2 | Governança valida | `elo_governanca` | Modelo existe? Há restrições? Há capacidade? |
| 3 | Ordem criada no PCP | `elo_pcp` | Tempo previsto vem de `parametros_modelo` |
| 4 | Etapas e apontamentos | `elo_pcp` | Tempo real registrado por etapa e operador |
| 5 | Requisição ao almox. | `elo_estoque` | PCP solicita materiais da BOM do modelo |
| 6 | Módulo pronto → Pátio | `elo_estoque` | Movimentação registrada, estoque atualizado |
| 7 | Analytics atualiza | `elo_analytics` | Parâmetros reais calculados, gargalos detectados |
| 8 | Comercial responde | `elo_comercial` | Prazo e capacidade com base em dados reais |
| 9 | IA aprende e parametriza | `elo_analytics` | Sazonalidade, ranking, estoque sugerido de pátio |

---

## 5. Plano de Construção — Ordem das Fases

| Fase | Schema | O que criar | Por que nessa ordem |
|---|---|---|---|
| 1 | `elo_governanca` | `regras_negocio`, `parametros_sistema`, `validacoes_entrada`, `glossario`, `versoes_catalogo`, `politicas_acesso` | Regras antes de dados. Nenhum dado entra sem contrato. |
| 2 | `elo_auditoria` | `log_alteracoes`, `log_acessos`, `log_erros`, `snapshots_diarios` | Rastreabilidade desde o primeiro registro. |
| 3 | `elo_catalogo` | `modelos`, `produtos`, `modelo_materiais`, `kits`, `modelo_kits`, `restricoes_modelo` | Fundação técnica. Sem catálogo nada funciona. |
| 4 | `elo_estoque` | `patios`, `estoque_modelos`, `estoque_materiais`, `movimentacoes`, `requisicoes` | Visibilidade do que existe antes de fabricar. |
| 5 | `elo_pcp` | `ordens_producao`, `etapas_processo`, `ordens_etapas`, `apontamentos`, `pausas_producao`, `capacidade_fabril` | Operação alimentando dados reais. |
| 6 | `elo_comercial` | `solicitacoes`, `solicitacao_itens`, `orcamentos`, `excedentes` | Demanda conectada à capacidade produtiva. |
| 7 | `elo_analytics` | `parametros_modelo`, `ranking_demanda`, `sazonalidade`, `estoque_sugerido_patios`, `gargalos_identificados`, `decisoes_ia` | Inteligência sobre dados acumulados. |
| 8 | `elo_auth` | `perfis`, `usuarios_perfis` + RLS em todos os schemas | Segurança sobre estrutura consolidada e validada. |

---

## 6. Nuances e Decisões de Arquitetura

### Campos que todo registro deve ter

| Campo | Tipo | Finalidade |
|---|---|---|
| `id` | BIGINT ou UUID | Chave primária única |
| `created_at` | TIMESTAMPTZ | Quando foi criado |
| `updated_at` | TIMESTAMPTZ | Quando foi modificado pela última vez |
| `ativo` | BOOLEAN | Soft delete — nunca apagar, apenas desativar |

### Campos de rastreabilidade (obrigatórios nas tabelas operacionais)

| Campo | Tipo | Finalidade |
|---|---|---|
| `criado_por` | UUID (FK auth.users) | Quem inseriu o registro |
| `atualizado_por` | UUID (FK auth.users) | Quem fez a última alteração |

### Decisões importantes
- IDs numéricos (BIGINT) para tabelas de alta volumetria (apontamentos, movimentações)
- IDs UUID para entidades que serão referenciadas externamente (modelos, produtos)
- Soft delete em vez de DELETE físico — campo `ativo = false`
- Todos os campos de texto livre com tamanho sem limite (`TEXT`, não `VARCHAR`)
- Campos monetários em `NUMERIC(12,2)` — nunca `FLOAT`
- Datas sempre com timezone (`TIMESTAMPTZ`) — evita problemas de fuso horário
- `JSON`/`JSONB` para dados de contexto da IA (`decisoes_ia`, `log_erros`)

---

## 7. Análise de Segurança — Checklist para Autenticação

Critérios que devem estar atendidos antes de implementar a Fase 8 (`elo_auth`).

| Critério | Status | Observação |
|---|---|---|
| Tabelas core com dados reais validados | ⏳ Pendente | Fases 1-5 precisam estar ativas |
| Campo `criado_por` em todas as tabelas operacionais | ⏳ Pendente | Necessário para RLS funcionar |
| Perfis de acesso definidos pelo negócio | ⏳ Pendente | Quem pode ler, escrever, deletar |
| Regras de RLS documentadas em `politicas_acesso` | ⏳ Pendente | Governança define antes de implementar |
| Campos texto livre de usuário virados FK | ⏳ Pendente | `usuario_responsavel` → `auth.users.id` |
| Testes com dados reais antes de ativar RLS | ⏳ Pendente | RLS sem política bloqueia tudo |

---

## 8. Como Usar Este Documento no Projeto Claude

Este documento serve como briefing base para todas as conversas dentro do Projeto ELO no Claude.ai. Cole-o no início de qualquer novo chat para que o assistente entre imediatamente no contexto correto.

### Estrutura recomendada de chats no Projeto ELO

| Chat | Finalidade |
|---|---|
| Arquitetura e Segurança | Decisões estruturais, análise de segurança, evolução do blueprint |
| SQL — Fase 1 e 2 | Criação de `elo_governanca` e `elo_auditoria` com orientação de inserção |
| SQL — Fase 3 e 4 | Criação de `elo_catalogo` e `elo_estoque` |
| SQL — Fase 5 e 6 | Criação de `elo_pcp` e `elo_comercial` |
| SQL — Fase 7 e 8 | Criação de `elo_analytics` e `elo_auth` com RLS |
| Cenário da Empresa | Contexto de implantação, perfis de usuário, fluxos reais |
| IA Comercial | Integração da IA com `elo_analytics` e `elo_comercial` |

Ao iniciar qualquer chat do projeto, use a instrução:

> "Você está no Projeto ELO. Atue como arquiteto de dados sênior com percepção de analista de segurança. O blueprint do projeto está no documento ELO_Blueprint_v1.0.docx. Consulte-o antes de qualquer decisão."

---

**ELO System — Blueprint v1.0 — Confidencial**
