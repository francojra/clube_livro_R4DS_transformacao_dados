
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

voos |>
  filter(destino == "IAH") |>
  select(destino, ano, mes, dia, atraso_chegada) # Seleção de colunas
