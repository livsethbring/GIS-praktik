# Regionala noder

#1 Funktionella tätorter
# består av småorter som ska slås samman i Dalarna - merge

#2 Skapa en buffer på 400 m runt varje ort i Dalarna


# libraries
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, sf, sp, httr, mapview, leaflet, dplyr)


smaorter_fil <- "C:/Users/sethb/OneDrive/Dokument/projekt_regionala_noder/indata/Smaorter_1990_2020.gpkg"
smaorter <- st_layers(smaorter_fil)

smaorter <- st_read(smaorter_fil, layer = "So2020_SR99TM", crs = 3006)
print(smaorter)
mapview(smaorter)


tatorter_fil <- "C:/Users/sethb/OneDrive/Dokument/projekt_regionala_noder/indata/Tatorter_1980_2020.gpkg"
tatorter <- st_layers(tatorter_fil)
print(tatorter)
tatorter <- st_read(tatorter_fil, layer = "To2020_SR99TM", crs = 3006)

fritidshus_fil <- "C:/Users/sethb/OneDrive/Dokument/projekt_regionala_noder/indata/Fritidshusomraden_2000_2020.gpkg"
fritidshus <- st_layers(fritidshus_fil)
print(fritidshus)
fritidshus <- st_read(fritidshus_fil, layer = "Fo2020_SR99TM", crs = 3006)



osm_landuse_fil <- "C:/Users/sethb/OneDrive/Dokument/projekt_regionala_noder/indata/gis_osm_landuse_a_free_1.shp"
osm_landuse <- st_read(osm_landuse_fil)
glimpse(osm_landuse)

osm_landuse <- osm_landuse %>% 
  st_transform(crs = 3006)
st_crs(osm_landuse)

industri_omr <- osm_landuse %>% 
  filter(fclass == "industrial")

handels_omr <- osm_landuse %>% 
  filter(fclass == "retail")

commerc_omr <- osm_landuse %>% 
  filter(fclass == "commercial")

mapview(industri_omr, col.regions = "grey") +
  mapview(handels_omr, col.regions = "blue") +
  mapview(commerc_omr, col.regions = "red") + 
  mapview(lan, zcol = "lan", alpha.regions = 0.5) +
  mapview(smaorter, col.regions = "orange") +
  mapview(tatorter, col.regions = "darkorange") +
  mapview(fritidshus, col.regions = "green")

Tatorter <- 
  
  
  mapview(osm_landuse)

# Buffer 400 m

#########################################################################################################################


# ChatGPTs lösning på hur vi skulle få in hela, valda, kommuner via kommunkod

# File path to GeoPackage
deso_fil <- "C:/Users/sethb/OneDrive/Dokument/projekt_regionala_noder/indata/DeSO_2018_v2.gpkg"

# Read spatial data
deso <- st_read(deso_fil)

# Define lan_kod
lan_kod <- c("20", "19", "17", "21", "23", "18", "03")

# Filter data based on lan_kod
deso <- filter(deso, lan %in% lan_kod)

# Create map view
mapview(deso, zcol = "lan")


#---------------------------------------------------------------------------------------------------
# Create kommun boundaries based on DeSo boundaries 
#---------------------------------------------------------------------------------------------------
kommun = deso %>% 
  group_by(kommun, kommunnamn) %>% 
  summarize(geom = st_union(geom)) %>% 
  ungroup()

mapview(kommun)


lan = deso %>% 
  group_by (lan, lannamn) %>% 
  summarize(geom = st_union(geom)) %>% 
  ungroup()

mapview(lan)

mapview(lan, zcol = "lan")

landuse_lan <- st_intersection(lan, osm_landuse)

mapview(landuse_lan)




