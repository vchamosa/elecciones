###
# Análisis del reparto de escaños
#
# Estudio de las diferencias en la distribución de escaños en el 
# Congreso de los Diputados de España siguiendo distintos sistemas
# electorales, usando las elecciones de Noviembre de 2019 como
# caso práctico.
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


## Load in data
path1 = "C:/Users/MASTER/Documents/R/datoselectorales/"

candidaturas <- read.delim(paste0(path1, "03021911.dat"), header=FALSE)
cod_mun <- read.delim(paste0(path1, "05021911.dat"), header=FALSE) #códigos municipales
votos_mun <- read.delim(paste0(path1, "06021911.dat"), header=FALSE, sep) #votos por municipio
cod_prov <- read.delim(paste0(path1, "07021911.dat"), header=FALSE) #códigos de CCAA y provincias
votos_prov <- read.delim(paste0(path1, "08021911.dat"), header=FALSE, sep) #votos en ámbitos superiores al municipio (CCAA y provincias)


## Format it into something coherent


