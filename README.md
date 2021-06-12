## Introduzione
Questo progetto permette di analizzare e visualizzare i dati relativi alle università italiane (Open Data MIUR).
Il progetto usa R ed è riproducibile facilmente, essendo i dati e tutte le risorse disponibili online..

## Pachetti R Richiesti
Per l'esecuzione sono richiesti i seguenti pacchetti R:
- tidyverse
- factoextra
- factoextra
- NbClust
- readxl
- plotly
- RColorBrewer
- ggplot2


## Informazioni sui dati usati
I dati iniziali disponibili sul sito del MIUR (http://dati.ustat.miur.it/dataset/iscritti/resource/32d26e28-a0b5-45f3-9152-6072164f3e63) riguardano il numero di iscritti divisi per genere, anno e ateneo Italiano per il periodo 2010-2020.


## Contenuto in breve del progetto
Dopo il calcolo della media degli iscritti per ogni ateneo viene calcolato il numero K ottimo di cluster da usare nell'analisi KMeans.
L'analisi K means permetterà di ottenere una divisione dimensionale degli atenei.



## Sito dove vengono presentati i risultati

https://simonedileo.github.io/OpenDataMiur-Viz/
