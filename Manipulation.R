rm(list = ls())
cat("\014")
library(data.table)
library(tidyverse)
library(plotly)

setwd("~/Ensino/PER/2020_II/MAF172/AulaR/AulaManipulacao/Aulamanipulation")
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

felixlandia <- jan2021 %>% filter(`NOME MUNICÍPIO`=="FELIXLANDIA") %>% 
  select(-c(1:5,7:17,19,20:34))
felixlandia$MES <- "Jan"
felixlandia$ANO <- 2021
felixlandia$`VALOR TRANSFERIDO` <- as.numeric(gsub(",", ".", felixlandia$`VALOR TRANSFERIDO`))
names(felixlandia) <- c("MUN", "ACAO", "FAV", 
                        "TRANSF", "MES", "ANO")

str(felixlandia$TRANSF)

felixlandia[1,2 ] <- "FUNDEB"
felixlandia[2,2 ] <- "FPM"
felixlandia[3,2 ] <- "CIDE"
felixlandia[4,2 ] <- "ITR"
felixlandia[5,2 ] <- "PPG"
felixlandia[6,2 ] <- "RHGEE"
felixlandia[7,2 ] <- "PNAE"
felixlandia[8,2 ] <- "COVID"
felixlandia[9,2 ] <- "ASUS"
felixlandia[10,2] <- "PAPS1"
felixlandia[11,2] <- "PAPS2"
felixlandia[12,2] <- "PAPS3"
felixlandia[13,2] <- "PAPS4"
felixlandia[14,2] <- "FARMACIA"
felixlandia[15,2] <- "ISUS1"
felixlandia[16,2] <- "ISUS2"
felixlandia[17,2] <- "ISUS3"

g1 <- felixlandia %>% 
  ggplot(aes(ACAO,TRANSF, fill=ACAO))+
  geom_col()+theme(axis.text.x = element_text(angle = 5, vjust = 0.5, hjust=1))
ggplotly(g1)


#########################

florestal <- jan2021 %>% filter(`NOME MUNICÍPIO`=="FLORESTAL") %>% 
  select(-c(1:5,7:17,19,20:34))
florestal$MES <- "Jan"
florestal$ANO <- 2021
florestal$`VALOR TRANSFERIDO` <- as.numeric(gsub(",", ".", florestal$`VALOR TRANSFERIDO`))
names(florestal) <- c("MUN", "ACAO", "FAV", 
                        "TRANSF", "MES", "ANO")

str(florestal$TRANSF)

florestal[1,2 ] <- "FUNDEB"
florestal[2,2 ] <- "FPM"
florestal[3,2 ] <- "CIDE"
florestal[4,2 ] <- "ITR"
florestal[5,2 ] <- "PPG"
florestal[6,2 ] <- "PNAE"
florestal[7,2 ] <- "ASUS"
florestal[8,2 ] <- "ASUS2"
florestal[9,2 ] <- "ASUS3"
florestal[10,2] <- "FARMACIA"
florestal[11,2] <- "VSUS"
florestal[12,2] <- "VSUS2"
florestal[13,2] <- "VSUS3"


g1 <- florestal %>% 
  ggplot(aes(ACAO,TRANSF, fill=ACAO))+
  geom_col()+theme(axis.text.x = element_text(angle = 5, vjust = 0.5, hjust=1))
ggplotly(g1)
