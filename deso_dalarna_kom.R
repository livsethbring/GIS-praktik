<<<<<<< HEAD

# libraries
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, sf, sp, httr, mapview, leaflet)


lan_kod = "20"

deso_fil <- "DeSO_2018_v2.gpkg"

deso = st_read(deso_fil)

deso = filter(deso, lan == lan_kod)

mapview(deso)
#---------------------------------------------------------------------------------------------------
# Create kommun boundaries based on DeSo boundaries 
#---------------------------------------------------------------------------------------------------
kommun = deso %>% 
  group_by(kommun, kommunnamn) %>% 
  summarize(geom = st_union(geom)) %>% 
  ungroup()

mapview(kommun)
=======

# libraries
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, sf, sp, httr, mapview, leaflet)


lan_kod = "20"

deso_fil <- "DeSO_2018_v2.gpkg"

deso = st_read(deso_fil)

deso = filter(deso, lan == lan_kod)

mapview(deso)
#---------------------------------------------------------------------------------------------------
# Create kommun boundaries based on DeSo boundaries 
#---------------------------------------------------------------------------------------------------
kommun = deso %>% 
  group_by(kommun, kommunnamn) %>% 
  summarize(geom = st_union(geom)) %>% 
  ungroup()

mapview(kommun)
>>>>>>> 30bf4bd3a73604c9663e637113937cebd0a48399
