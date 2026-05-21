# Schema `elo_governanca`

Camada soberana de regras, parametros, validacoes, glossario, versoes e politicas de acesso futuras.

## Tabelas

| Tabela | Finalidade |
|---|---|
| `regras_negocio` | Regras de validacao, restricao e calculo. |
| `parametros_sistema` | Configuracoes alteraveis sem mudanca de codigo. |
| `validacoes_entrada` | Contratos de dados antes de inserir ou alterar registros. |
| `glossario` | Vocabulario oficial do negocio. |
| `versoes_catalogo` | Snapshots historicos de entidades catalogadas. |
| `politicas_acesso` | Desenho das permissoes antes da implementacao de RLS. |

## Campos padrao

Todas as tabelas possuem:

- `id`
- `ativo`
- `created_at`
- `updated_at`
- `criado_por`
- `atualizado_por`

## Regras soberanas aplicadas

- DELETE fisico bloqueado por trigger.
- Rastreabilidade minima desde o primeiro registro.
- Parametros e regras iniciais registram os principios de governanca.

