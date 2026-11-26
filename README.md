# Colher de Pau

Aplicativo mobile em Flutter para descobrir receitas, pesquisar por nome, ler
ingredientes e modo de preparo e marcar favoritos. Os dados vêm da API pública
[DummyJSON Recipes](https://dummyjson.com/docs/recipes).

**Autor:** Alexander Félix Kolacz
**Curso:** Engenharia de Software, Centro Universitário Filadélfia (UniFil)

## Funcionalidades
- **Tela principal:** identidade do app, acesso à pesquisa e listagem de receitas.
  O carregamento das receitas começa na primeira abertura.
- **Listagem:** nome, tipo de refeição, tempo e avaliação, com foto. Se a imagem
  faltar ou falhar, aparece um ícone no lugar. A lista tem rolagem.
- **Pesquisa:** busca por nome no endpoint remoto. Espaços nas pontas e repetidos
  são tratados, consulta vazia ou só com espaços é recusada com mensagem clara, e
  há botões para limpar a pesquisa ou voltar à listagem.
- **Detalhes:** foto, ingredientes, modo de preparo, tempo total, porções,
  dificuldade e avaliação, com rolagem para conteúdo longo.
- **Favoritos:** adicionar e remover durante a sessão, sem duplicatas, com uma aba
  própria para consultar.
- **Carregamento:** indicador de progresso e botões desativados durante a busca.
- **Erros:** falha de rede, status diferente de 200 e JSON incompatível mostram uma
  mensagem compreensível e o botão "Tentar novamente".
- **Ausência de resultados:** telas diferentes para busca sem correspondências,
  falha de rede e favoritos vazios.
- **Navegação:** menu inferior (Explorar / Favoritos), abertura de detalhes a
  partir de qualquer lista e retorno mantendo o contexto da pesquisa.

## Requisitos atendidos
| Requisito | Onde está |
|---|---|
| RF01 Tela principal | `pagina_explorar.dart` |
| RF02 Listagem | `pagina_explorar.dart`, `widgets.dart`, `imagem_receita.dart` |
| RF03 Pesquisa | `pagina_pesquisa.dart`, `api.dart` |
| RF04 Detalhes | `pagina_detalhes.dart` |
| RF05 Favoritos | `memoria.dart`, `pagina_favoritos.dart` |
| RF06 Carregamento | `telas_estado.dart` e a variável `buscando` |
| RF07 Erros | `api.dart`, `telas_estado.dart` |
| RF08 Ausência de resultados | `pagina_pesquisa.dart`, `pagina_favoritos.dart` |
| RF09 Navegação | `main.dart`, `widgets.dart` |

## Decisões técnicas
- **Detalhes:** a receita aberta reaproveita o objeto completo que já veio na
  listagem ou na pesquisa, sem nova requisição a `/recipes/{id}`.
- **Consultas concorrentes:** a variável `buscando` impede iniciar a mesma operação
  duas vezes, e os botões de busca ficam desativados enquanto a requisição roda.
- **Carregamento inicial:** acontece uma única vez, no `initState`. As receitas
  ficam guardadas em memória, então trocar de aba não refaz a busca.
- **Favoritos:** um mapa `id -> Receita` em `memoria.dart` é a única fonte de
  verdade entre as telas. Como a chave é o id, não há duplicatas.
- **Validação da API:** o GET é assíncrono, o status é conferido e o JSON é
  validado antes de atualizar a interface. Qualquer falha vira a tela de erro.
- **Campos opcionais:** tempos ausentes aparecem como "não informado" (e não como
  0), `rating` é lido como `num`, `mealType` é tratado como lista, e as porções
  só aparecem quando o valor é utilizável.

## Tradução para português
A API DummyJSON retorna os dados em inglês. O app traduz nomes, ingredientes e
passos usando a API gratuita [MyMemory](https://mymemory.translated.net/doc/spec.php),
que tem limite de 5.000 caracteres por dia sem identificação (50.000 com e-mail no
parâmetro `de`). Tipos de refeição e dificuldade usam uma tabela fixa no código.
A pesquisa traduz o termo digitado de português para inglês antes de consultar o
endpoint remoto. Se a tradução falhar ou o limite diário acabar, o app exibe o texto
original em inglês, sem erro. As traduções são automáticas e podem ter imprecisões.

## Dependências
- Flutter SDK: (cole aqui a versão mostrada por `flutter --version`)
- Dart SDK: (cole aqui a versão mostrada pelo mesmo comando)
- Pacote [`http`](https://pub.dev/packages/http) para as requisições
- Conexão com a internet

## Como executar
1. Instale o [Flutter](https://docs.flutter.dev/get-started/install) e configure um
   emulador Android ou conecte um aparelho.
2. Clone o repositório e entre na pasta do projeto:
   ```bash
   cd atividade2_receitas
   ```
3. Baixe as dependências:
   ```bash
   flutter pub get
   ```
4. Execute o app:
   ```bash
   flutter run
   ```

O primeiro carregamento pode levar alguns segundos por causa da tradução dos nomes.

## Estrutura da pasta `lib/`
| Arquivo | Função |
|---|---|
| `main.dart` | Tema do app e menu inferior (Explorar / Favoritos) |
| `tema.dart` | Cores e estilo de títulos |
| `receita.dart` | Modelo da receita e conversão do JSON |
| `api.dart` | Requisições à API e validação da resposta |
| `traducao.dart` | Tradução inglês ↔ português |
| `memoria.dart` | Receitas carregadas e favoritos da sessão |
| `pagina_explorar.dart` | Tela inicial, carregamento, erro e listagem |
| `pagina_pesquisa.dart` | Pesquisa, resultados e ausência de resultados |
| `pagina_detalhes.dart` | Ingredientes e modo de preparo |
| `pagina_favoritos.dart` | Receitas favoritas e estado vazio |
| `widgets.dart` | Card de receita |
| `imagem_receita.dart` | Foto com alternativa quando falha |
| `telas_estado.dart` | Telas de carregando, erro e mensagem |

## Limitações
- Os favoritos ficam só em memória e se perdem ao fechar o app.
- A tradução automática depende de uma API gratuita com limite diário.
