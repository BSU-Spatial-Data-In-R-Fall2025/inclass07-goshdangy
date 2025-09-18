#Access GDrive
library(googledrive)
library(sf)
library(terra)
library(tidyterra)
library(tidyverse)

#Access Source Code
source("scripts/utilities/download_utils.R")

#Load Dataset
file_list <- drive_ls(drive_get(as_id("https://drive.google.com/drive/u/1/folders/1PwfUX2hnJlbnqBe3qvl33tFBImtNFTuR")))

#Set Destination
file_list %>% 
  dplyr::select(id, name) %>%
  purrr::pmap(function(id, name) {
    gdrive_folder_download(list(id = id, name = name),
                           dstfldr = "inclass08")
  })

#Read Shape and Rast Files
cejst_shp <- read_sf("data/original/inclass08/cejst.shp")
fire_prob <- rast("data/original/inclass08/wildfire.tif")

#Check Bounding Box of Shape File
st_bbox(cejst_shp)

#Not Sure what is happenin here
cejst_shp %>% 
  filter(., SF == "Idaho") %>% 
  st_bbox()

#Plot the Bounding Box of the entire data, then the bbox for that of just Idaho
all_bbox <- st_bbox(cejst_shp) %>% 
  st_as_sfc()
id_bbox <- cejst_shp %>% 
  filter(., SF == "Idaho") %>% 
  st_bbox() %>% 
  st_as_sfc()

plot(all_bbox)
plot(id_bbox, add=TRUE, border ="red")

#Plot our shape files
ggplot() +
  geom_sf(data = all_bbox, fill = "darkorchid") +
  geom_sf(data= id_bbox, fill = "orange") +
  theme_linedraw()

#extenet of our raster
ext(fire_prob)

#plot raster & bbox
plot(ext(fire_prob), border = "red")
plot(fire_prob, add=TRUE)

# Filter Plot to >3000
fire_subset <- fire_prob %>% 
  filter(WHP_ID > 30000)

plot(ext(fire_subset), border = "red")
plot(fire_subset, add=TRUE)

#Changing extene and then plotting both
orig_bbox <- st_bbox(cejst_shp)

new_bbox <- st_bbox(c(orig_bbox["xmin"] + 1, orig_bbox["xmax"] - 1,  
                      orig_bbox["ymax"] - 1, orig_bbox["ymin"] + 1), 
                    crs = st_crs(orig_bbox)) %>% st_as_sfc()

ggplot() +
  geom_sf(data = st_as_sfc(orig_bbox), color = "yellow", fill = "darkorchid4") +
  geom_sf(data= new_bbox, fill = "orangered") +
  theme_bw()

#Changing the extnet of a raster and plotting
orig_ext <- as.vector(ext(fire_prob))

new_ext <- ext(as.numeric(c(
  orig_ext["xmin"] + 100000,
  orig_ext["xmax"] - 100000,
  orig_ext["ymin"] + 100000,
  orig_ext["ymax"] - 100000
)))

plot(orig_ext)
plot(new_ext, add=TRUE, border = "red")

#Resolution for Raster
res(fire_prob)

#Sharpen or coarsen our resultion
coarser_fire <- aggregate(fire_prob, fact = 5)
finer_fire <- disagg(fire_prob, fact = 5)

#Access CRS for Vector (SF)
st_crs(cejst_shp)

#Access CRS for Vector (terra)
crs(fire_prob)

#manually set the projection
fire_prob_new <- fire_prob
crs(fire_prob_new) <- "epsg:9001"

#check plot
plot(fire_prob)
plot(fire_prob_new)

#reproject
cejst_reproject <- cejst_shp %>% 
  st_transform(., st_crs(fire_prob_new))

#check vector data
st_crs(cejst_reproject)
st_crs(cejst_shp)
st_bbox(cejst_reproject)
st_bbox(cejst_shp)
