library(googledrive)
library(sf)
library(terra)
library(tidyterra)
library(tidyverse)

#Sourcing script for GDrive
source("scripts/utilities/download_utils.R")

#Give Access to G Drive Folder
file_list <- drive_ls(drive_get(as_id("https://drive.google.com/drive/u/1/folders/1PwfUX2hnJlbnqBe3qvl33tFBImtNFTuR")))

#feed files into Origin Folder
file_list %>% 
  dplyr::select(id, name) %>%
  purrr::pmap(function(id, name) {
    gdrive_folder_download(list(id = id, name = name),
                           dstfldr = "inclass07")
  })

