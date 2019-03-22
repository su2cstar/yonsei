install.packages("igraph")
install.packages("sna")
install.packages("network")
install.packages("intergraph")

library(intergraph)
library(sna)
library(igraph)
library(network)

## 사용자 지정 노드를 사용한 네트워크
#wd지정
setwd('C:/Users/ahn92/Dropbox/Sources/ODS/2018321084_HW2/graphml')

g_ky <-read.graph("g_ky.graphml", format = "graphml")
g_ha <-read.graph("g_ha.graphml", format = "graphml")
g_do <-read.graph("g_do.graphml", format = "graphml")
g_ch <-read.graph("g_ch.graphml", format = "graphml")
g_ky1 <- asNetwork(g_ky)
g_ha1 <- asNetwork(g_ha)
g_do1 <- asNetwork(g_do)
g_ch1 <- asNetwork(g_ch)
gcor(g_ky1, g_ha1)
gcor(g_ky1, g_ch1)
gcor(g_ky1, g_do1)
gcor(g_ha1, g_ch1)
gcor(g_ha1, g_do1)
gcor(g_ch1, g_do1)
