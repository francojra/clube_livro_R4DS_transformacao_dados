
# Clube do Livro R for Data Science --------------------------------------------------------------------------------------------------------
# Encontro 5: Transformação de dados -------------------------------------------------------------------------------------------------------
# Data: 24/06/24 ---------------------------------------------------------------------------------------------------------------------------

# Instalar pacotes -------------------------------------------------------------------------------------------------------------------------

##install.packages("tidyverse")
##install.packages("dados") # Conjunto de dados traduzidos

# Carregar pacotes -------------------------------------------------------------------------------------------------------------------------

library(tidyverse)
library(dados)

# Conhecer a base de dados -----------------------------------------------------------------------------------------------------------------

voos # Cada linha representa um voo
?voos # Ver documentação sobre os dados
glimpse(voos) # Número de linhas e colunas, tipos de variáveis

# Estrutura do dplyr -----------------------------------------------------------------------------------------------------------------------

## funcao(base_de_dados, quais_colunas_vamos_usar)
## resultado: base de dados alterada

voos # Base de dados original
filter() # Função que trabalha com linhas

## Função + base de dados + coluna + linha a ser filtrada
## O retorno é uma base de dados filtrada

filter(voos, destino == "IAH") 

## pipe: |> ou %>%

voos |>
  filter(destino == "IAH")

## Exemplo

diario_atraso_chegada <- voos |>
  filter(destino == "IAH") |>
  select(destino, ano, mes, dia, atraso_chegada) |> # Seleção de colunas
  group_by(ano, mes, dia) |> # Seleção de grupos
  summarise(                   
    media_atraso_chegada = mean(atraso_chegada, na.rm = T)) # Função para fazer resumos

## O na.rm = T é para quando existir alguma informação faltante 
## ele continuar calculando

## Quando calcula os resumos, é necessário informar um novo nome 
## para a nova base de dados

view(diario_atraso_chegada)

# Funções dplyr ---------------------------------------------------------------------------------------------------------------------------------

filter() # Filtrar linhas
distinct() # Busca valores únicos distintos
arrange() # Ordenar a base de dados
count() # Conta as linhas por grupo

# Função filter ----------------------------------------------------------------------------------------------------------------------------

## Operadores dplyr 

# == -> Igual a
# != -> Diferente de
# > -> Maior que
# < -> Menor que
# >= -> Maior e igual a
# <= -> Menor e igual a

voos |>
  filter(atraso_saida > 120) |>
  view()

voos |>
  filter(atraso_saida >= 120) |>
  view()

## Voos que partiram dia 1º de janeiro

## Operador AND: & e ,

voos |>
  filter(mes == 1 & dia == 1) |>
  view()

voos |>
  filter(mes == 1, dia == 1) |>
  view()

## Voos que partiram em janeiro ou fevereiro

## Operador OR: |

voos |>
  filter(mes == 1 | mes == 2) |>
  view()

## Voos que partiram no primeiro semestre

## Operador %in% : Filtrar conjunto de linhas

voos |>
  filter(mes %in% c(1, 3)) |>
  view()

voos |>
  filter(mes %in% c(1:6)) |>
  view()

## Operador NOT: !

voos |>
  filter(!mes %in% c(1, 2)) # Filtrar todas as linhas que os meses não sejam 1 e 2

# Erros comuns ao usar o filter ------------------------------------------------------------------------------------------------------------

## Erro comum 1

voos |>
  filter(mes = 1)

# Error in `filter()`:
# ! We detected a named
#   input.
# ℹ This usually means that
#   you've used `=` instead of
#   `==`.
# ℹ Did you mean `mes == 1`?
# Run `rlang::last_trace()` to see where the error occurred.

## Erro comum 2

voos |>
  filter(mes == 1 | 2) |>
  distinct(mes) # O distinct mostrará que não houve mudança em mês

## Correto

voos |>
  filter(mes == 1 | mes == 2) |>
  distinct(mes) 

## ou...

voos |>
  filter(mes %in% c(1, 2)) |>
  distinct(mes) 

# Função arrange ---------------------------------------------------------------------------------------------------------------------------

voos |>
  arrange(atraso_saida) |> # Ordem crescente
  view()

voos |>
  select(dia, mes, atraso_saida) |>
  arrange(dia, mes, atraso_saida) |> 
  view()

## Forma decrescente

voos |>
  select(dia, mes, atraso_saida) |>
  arrange(desc(atraso_saida)) |>
  view()

voos |>
  select(dia, mes, atraso_saida) |>
  arrange(-atraso_saida) |>
  view()

voos |>
  select(dia, mes, atraso_saida) |>
  arrange(desc(atraso_saida)) |>
  head(10)

## Quais são os 10 maiores atrasos?

voos |>
  arrange(atraso_saida) |> 
  head(10) |>
  mutate(atraso_saida_hora = atraso_saida/60) |>  # Atraso em horas
  view()

## Ordenar por ordem alfabética

voos |>
  select(ano, mes, dia, origem, atraso_saida) |>
  arrange(origem) |>
  view()

voos |>
  select(ano, mes, dia, origem, atraso_saida) |>
  arrange(origem, atraso_saida) |>
  view()

# Função distinct --------------------------------------------------------------------------------------------------------------------------

## Ajuda a achar as linhas únicas em um conjunto de dados ou grupos únicos

## A função unique() é do R base

unique(voos$origem) # Não usa mais de uma coluna como o distinct

voos |>
  distinct() # Se houver repetição, essa função deixa apenas com os valores únicos

voos |>
  distinct(origem, destino)

voos |>
  distinct(origem, destino) |>
  arrange(origem, destino)

voos |>
  distinct(origem, destino, .keep_all = TRUE) # Para visualizar todas as colunas

# Função count -----------------------------------------------------------------------------------------------------------------------------

## Para cada uma das combinações origem-destino, quantos voos sairam?

voos |>
  count(origem, destino) # Dá um resultado similar ao que tem no distinct com adição
## de uma coluna com valores de n
