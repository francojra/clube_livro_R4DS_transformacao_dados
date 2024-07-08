
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

## Funções

filter() # Filtrar linhas
distinct() # Busca valores únicos distintos
arrange() # Ordenar a base de dados
count() # Conta as linhas por grupo

## Operadores

# == -> Igual
# != -> Diferente
# > -> Maior
# < -> Menor
# >= -> Maior igual
# <= -> Menor igual

