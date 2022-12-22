# https://r-tmap.github.io/tmap-book/geodata.html
# Pseudo-cylindrical proyection (NO LA USE)
#
pacman::p_load(
  "tmap",        
  "rJava",          
  "OpenStreetMap",
  "sf",
  "rnaturalearth"
  )


aof <- data.frame(name="aof",lat=c(-40, -65),lon=c(-50, -70))
aof_sf <- st_as_sf(aof,coords = c("lon", "lat"), crs = 4326) %>% st_bbox() %>% 
  st_as_sfc()   # WGS84
# waterfalls_sf_trans = st_transform(waterfalls_sf, 8857)      # Equal Earth projection (EPSG 8857)


gsj <- data.frame(name="GSJ",lat=c(-45, -47),lon=c(-65, -68))
gsj_sf <- st_as_sf(gsj,coords = c("lon", "lat"), crs = 4326) %>% st_bbox() %>% 
  st_as_sfc()   # WGS84
amp <- data.frame(lat=c(-54, -55),lon=c(-56, -62))
amp <- st_as_sf(amp,coords = c("lon", "lat"), crs = 4326) %>% st_bbox() %>% 
  st_as_sfc()   # WGS84

beag <- data.frame(lat=c(-54.75, -55),lon=c(-68.5, -66))
beag <- st_as_sf(beag,coords = c("lon", "lat"), crs = 4326) %>% st_bbox() %>% 
  st_as_sfc()   # WGS84

pott <- data.frame(lat=c(-62, -62.1),lon=c(-58, -58.1))
pott <- st_as_sf(pott,coords = c("lon", "lat"), crs = 4326) %>% st_bbox() %>% 
  st_as_sfc()   # WGS84

study_areas <- st_sf(data.frame(name=c("A","B","C","D"),geometry= c(gsj_sf,amp,beag,pott)))
#name=c("GSJ","AMP","BEAGLE","POTT")


tmap_mode("view")
tm_shape(study_areas) +
  tm_polygons(alpha=.5) +
  tm_text("name")

#For a static map, you need to read in the basemap via read_osm, e.g.  
require(tmaptools)
tmap_mode("plot")

base_map <- read_osm(bb(aof_sf), 
                    #zoom = 10, 
                    type = "bing") 
tm <- tm_shape(base_map)+tm_rgb()+tm_shape(study_areas) +
  tm_polygons(alpha=.5) +
  tm_text("name",col= "white",size=2) +
  tm_graticules(alpha=0.5,labels.size=1)
tm
tmap_save(tm, "Figures/Figura1_Marina&Saravia_2022.png")






