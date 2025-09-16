#Assign Shape file
cejst_shp <- read_sf("data/original/inclass07/cejst.shp")

#glimpse at shape
str(cejst_shp)

#Validate Shape
all(st_is_valid(cejst_shp))

#Plot Shape
plot(st_geometry(cejst_shp))
