library(dplyr)
library(plotly)
library(ggplot2)


ProfAteneiItaliani<-read.csv2("http://dati.ustat.miur.it/dataset/a60a221d-1c0d-4abb-bc8b-2199f61c205d/resource/92f2008d-958f-4e9c-ae5c-7a3dd418cd57/download/bdg_serie_academic_staff_ambito.csv")
datiProf<-ProfAteneiItaliani %>% filter(CODICE_ATENEO=="TTTTT")

qplot(data=datiProf,x=ANNO,y=N_AcStaff)+geom_line(na.rm=TRUE)



graficoAndIng<-datiProf %>%
 filter(AREA_SD %in% "09 - Ingegneria industriale e dell'informazione") %>%
 filter(FoRD %in% 
 "02 - Engineering and technology") %>%
 ggplot() +
 aes(x = ANNO, y = N_AcStaff, colour = GENERE) +
 geom_line(size = 0.5) +
 scale_color_hue(direction = 1) +
 labs(x = "Anno di riferimento", y = "Numero di personale attivo", title = "Andamento numero del personale totale attivo in Italia", 
 subtitle = "Area SD : Ingegneria Industriale e dell'informazione", color = "Genere") +
 theme_minimal() +
 theme(plot.title = element_text(size = 15L, face = "bold", hjust = 0.5), plot.subtitle = element_text(face = "italic", 
 hjust = 0.5)) +
 facet_wrap(vars(DESC_QUALIFICA), scales = "free")


ggplotly(graficoAndIng,width = 1080, height = 720)%>% config(displayModeBar = F)
