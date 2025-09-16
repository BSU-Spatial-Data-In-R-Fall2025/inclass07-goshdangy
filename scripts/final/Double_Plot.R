# Save TIFF file
tiff("~/R Studio/inclass07-goshdangy/outputs/my_plot2.tif", 
     width = 800, height = 800, res = 150)

par(mfrow = c(1, 2))   # 1 row, 2 columns
mycols <- colorRampPalette(c("blue", "white", "red"))(20)

# Left: Vector
plot(st_geometry(cejst_shp), main = "Vector")

# Right: Raster
plot(fire_prob, col = mycols, main = "Fire Risk")

dev.off()  # closes the file
