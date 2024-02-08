##
#####################################
## Análisis del reparto de escaños ##
#####################################
#
## Extractor y formateador de datos
# 
# Este programa lee y reformatea datos electorales para facilitar su análisis.
# Las cifras y metadatos de las distintas elecciones y referendos españoles se
# pueden descargar de la página web de información electoral del Ministerio del Interior:
# https://infoelectoral.interior.gob.es/es/elecciones-celebradas/area-de-descargas/
# 
# Victor Chamosa Pino
#
#

## Set up environment
library(dplyr)
library(data.table)
library(stringr)
library(tibble)

options(scipen = 999)


## Load in data
path1 = "C:/Users/MASTER/Documents/R/datoselectorales/"

candidaturas <- read.delim(paste0(path1, "03021911.dat"), header=FALSE, numerals = "no.loss")
cod_mun <- read.delim(paste0(path1, "05021911.dat"), header=FALSE, numerals = "no.loss") #códigos municipales
votos_mun <- read.delim(paste0(path1, "06021911.dat"), header=FALSE, numerals = "no.loss") #votos por municipio
cod_prov <- read.delim(paste0(path1, "07021911.dat"), header=FALSE, numerals = "no.loss") #códigos de CCAA y provincias
votos_prov <- read.delim(paste0(path1, "08021911.dat"), header=FALSE, numerals = "no.loss") #votos en ámbitos superiores al municipio (CCAA y provincias)


## Format it into something coherent
candidaturas$V1 <- iconv(candidaturas$V1, "latin1")
cod_mun$V1 <- iconv(cod_mun$V1, "latin1")
cod_prov$V1 <- iconv(cod_prov$V1, "latin1")

for(i in 1:nrow(candidaturas)){
candidaturas$nombre[i] <- substr(candidaturas$V1[i],15,64) #nombre de la candidatura (en siglas)
candidaturas$codigo[i] <- substr(candidaturas$V1[i],9,14) #código de la candidatura
}

for(i in 1:nrow(cod_mun)){
  cod_mun$nombre[i] <- substr(cod_mun$V1[i],19,118) #nombre del municipio
  cod_mun$codigo[i] <- substr(cod_mun$V1[i],14,16) #votos válidos
  cod_mun$codigo_prov[i] <- substr(cod_mun$V1[i],12,13) #código INE de la provincia
  cod_mun$codigo_com[i] <- substr(cod_mun$V1[i],126,128) #código de la comarca
  cod_mun$votos_blanco[i] <- substr(cod_mun$V1[i],190,197) #votos en blanco
  cod_mun$votos_nul[i] <- substr(cod_mun$V1[i],198,205) #votos nulos
  cod_mun$votos_val[i] <- substr(cod_mun$V1[i],206,213) #votos válidos
}

for(i in 1:nrow(votos_mun)){
  votos_mun$codigo[i] <- substr(votos_mun$V1[i],12,14) #código INE del municipio
  votos_mun$codigo_prov[i] <- substr(votos_mun$V1[i],10,11) #código INE de la provincia
  votos_mun$codigo_cand[i] <- substr(votos_mun$V1[i],17,22) #código de la candidatura
  votos_mun$votos[i] <- substr(votos_mun$V1[i],23,30) #votos obtenidos por la candidatura
}

for(i in 1:nrow(cod_prov)){
  cod_prov$nombre[i] <- substr(cod_prov$V1[i],15,64) #nombre del ámbito territorial
  cod_prov$codigo_ca[i] <- substr(cod_prov$V1[i],10,11) #código de la comunidad autónoma
  cod_prov$codigo_prov[i] <- substr(cod_prov$V1[i],12,13) #código INE de la provincia
  cod_prov$votos_blanco[i] <- substr(cod_prov$V1[i],126,133) #votos en blanco
  cod_prov$votos_nul[i] <- substr(cod_prov$V1[i],134,141) #votos nulos
  cod_prov$votos_val[i] <- substr(cod_prov$V1[i],142,149) #votos válidos
  cod_prov$escanos[i] <- substr(cod_prov$V1[i],150,155) #número de escaños a distribuir en la provincia
}

for(i in 1:nrow(votos_prov)){
  votos_prov$codigo_ca[i] <- substr(votos_prov$V1[i],10,11) #código de la comunidad autónoma
  votos_prov$codigo_prov[i] <- substr(votos_prov$V1[i],12,13) #código INE de la provincia
  votos_prov$codigo_cand[i] <- substr(votos_prov$V1[i],15,20) #código de la candidatura
  votos_prov$votos[i] <- substr(votos_prov$V1[i],21,28) #votos obtenidos por la candidatura
  votos_prov$resultado[i] <- substr(votos_prov$V1[i],29,33) #candidatos obtenidos por la candidatura
}


## Save
write.csv(candidaturas, file=paste0(path1, "candidaturas.csv"), row.names=FALSE)
write.csv(cod_mun, file=paste0(path1, "municipios.csv"), row.names=FALSE)
write.csv(cod_prov, file=paste0(path1, "provincias.csv"), row.names=FALSE)
write.csv(votos_mun, file=paste0(path1, "votos_municipio.csv"), row.names=FALSE)
write.csv(votos_prov, file=paste0(path1, "votos_provincia.csv"), row.names=FALSE)



