##
#####################################
## Análisis del reparto de escaños ##
#####################################
#
## Repartidor de escaños
# 
# Este programa reparte los escaños del Congreso de los Diputados de España
# siguiendo distintos sistemas electorales y analiza las diferencias en su 
# distribución. Requiere los datos oficiales del Ministerio del Interior, 
# formateados por el programa extractor_infoelectoral.R
# 
# Victor Chamosa Pino
#
#

## Set up environment
library(dplyr)
library(data.table)
library(stringr)
library(tibble)
library(ggplot2)

options(scipen = 999)


## Load data and initiate constants
path1 = "C:/Users/MASTER/Documents/R/datoselectorales/"
candidaturas <- read.csv(paste0(path1, "candidaturas.csv"))
cod_mun <- read.csv(paste0(path1, "municipios.csv")) #códigos municipales
votos_mun <- read.csv(paste0(path1, "votos_municipio.csv")) #votos por municipio
cod_prov <- read.csv(paste0(path1, "provincias.csv")) #códigos de CCAA y provincias
votos_prov <- read.csv(paste0(path1, "votos_provincia.csv")) #votos en ámbitos superiores al municipio (CCAA y provincias)

n_escaños <- cod_prov$escanos[54]


## Reparto real


