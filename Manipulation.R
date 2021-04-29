rm(list = ls())
cat("\014")
library(data.table)
library(tidyverse)

setwd("~/Ensino/PER/2020_II/MAF172/AulaR/AulaManipulacao")
url <- c("http://www.portaltransparencia.gov.br/download-de-dados/transferencias/202101",
         "http://www.portaltransparencia.gov.br/download-de-dados/transferencias/202102",
         "http://www.portaltransparencia.gov.br/download-de-dados/transferencias/202103")

names = c("202101_Transferencias.zip",
          "202102_Transferencias.zip",
          "202103_Transferencias.zip")

for (i in 1:length(url)){
  download.file(url[i], destfile =  names[i], method='curl')
}
jan2021 <- unzip('202101_Transferencias.zip',
                       files = c("202101_Transferencias.csv"))
Fev2021 <- unzip('202102_Transferencias.zip',
                 files = c("202102_Transferencias.csv"))
Mar2021 <- unzip('202103_Transferencias.zip',
                 files = c("202103_Transferencias.csv"))
###################

jan2021 <- fread("202101_Transferencias.csv", encoding = "Latin-1")

jan2021 %>% filter(`NOME FAVORECIDO`=="MUNICIPIO DE FLORESTAL") %>% 
  ggplot(aes(`NOME AÇÃO`, `VALOR TRANSFERIDO`)) + 
  geom_col() + 
  theme(axis.text.x = element_text(angle = 5, vjust = 0.5, hjust=1))

df <- jan2021 %>% 
  filter(`NOME FAVORECIDO`=="MUNICIPIO DE FLORESTAL") %>% 
  select(`NOME AÇÃO`, `VALOR TRANSFERIDO`)
df[1,1] <- "FUNDEB"
df[2,1] <- "FPM"
df[3,1] <- "CIDE-Comb"
df[4,1] <- "ITR"
df[5,1] <- "PPG"
df[6,1] <- "PNAE"
df %>% 
  ggplot(aes(`NOME AÇÃO`, `VALOR TRANSFERIDO`)) + 
  geom_col() + 
  theme(axis.text.x = element_text(angle = 5, vjust = 0.5, hjust=1)) + 
  scale_y_continuous(labels = function(x) paste0(x, "R$"))
