library(tidyverse)
library(factoextra)
library(factoextra)
library(NbClust)
library(readxl)
library(plotly)
library(RColorBrewer)
library(ggplot2)

IscrittiAteneiItaliani<-read.csv2("http://dati.ustat.miur.it/dataset/3dd9ca7f-9cc9-4a1a-915c-e569b181dbd5/resource/32d26e28-a0b5-45f3-9152-6072164f3e63/download/iscrittixateneo.csv")


IscrittiAteneiItaliani$SommaIscritti<-IscrittiAteneiItaliani$Isc_M+IscrittiAteneiItaliani$Isc_F


IscrittiAteneiItaliani$AnnoA<-str_remove(IscrittiAteneiItaliani$AnnoA,"/.*")

IscrittiAteneiItaliani$SommaIscritti

MediaIscrittiMatrice<-aggregate(IscrittiAteneiItaliani$SommaIscritti~IscrittiAteneiItaliani$AteneoCOD, FUN = mean,data=IscrittiAteneiItaliani)



colnames(MediaIscrittiMatrice)[1] <- "Ateneo"
colnames(MediaIscrittiMatrice)[2] <- "MediaIscritti"



MediaIscritti<-data.frame(MediaIscrittiMatrice$MediaIscritti)

# Elbow method
fviz_nbclust(MediaIscritti, kmeans, method = "wss") +
  geom_vline(xintercept = 4, linetype = 2)+
  labs(subtitle = "Elbow method")

# Silhouette method
fviz_nbclust(MediaIscritti, kmeans, method = "silhouette")+
  labs(subtitle = "Silhouette method")

# Gap statistic
# nboot = 50 to keep the function speedy. 
# recommended value: nboot= 500 for your analysis.
# Use verbose = FALSE to hide computing progression.
set.seed(123)
fviz_nbclust(MediaIscritti, kmeans, nstart = 25,  method = "gap_stat", nboot = 50)+
  labs(subtitle = "Gap statistic method")

#KMEAN Clusterization

KM=kmeans(MediaIscritti,4)

#Clusters
Cluster<-KM$cluster
MediaIscrittiMatrice$cluster<-Cluster

#Centers of the clusters

Centroidi<-data.frame(KM$centers)
colnames(Centroidi)[1] <- "Centroidi Cluster"
desc=c("Grande Ateneo","Piccolo Ateneo","Medio Ateneo","Mega Ateneo")
IdCluster=c(1,2,3,4)
Centroidi$desc<-desc
Centroidi$cluster<-IdCluster


DatiPerGrafico<-merge(MediaIscrittiMatrice, Centroidi, by = "cluster")



fig<-ggplot(DatiPerGrafico) +
  aes(x = `Centroidi Cluster`, y = MediaIscritti, colour = desc, text=paste0("Ateneo = ",Ateneo)) +
  geom_point(shape = "circle open", 
             size = 1.5) +
  scale_color_brewer(palette = "RdYlBu", direction = -1) +
  coord_flip() +
  theme_light()+labs(title="Cluster of Italian Universities by mean of enrollments",color='Legenda dei cluster')+
  theme(legend.title = element_text(color = "blue",size = 10,))


ggplotly(fig)%>% config(displayModeBar = F)

