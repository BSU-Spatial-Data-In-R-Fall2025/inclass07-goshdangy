#Assign TIF
fire_prob <- rast("data/original/inclass07/wildfire.tif")

#Look at data
str(fire_prob)

#Glimpse at Data
glimpse(fire_prob)

#Plot Raster
mycols <- colorRampPalette(c("blue", "white", "red"))(20)
plot(fire_prob, col = mycols, main = "Blue-White-Red")
