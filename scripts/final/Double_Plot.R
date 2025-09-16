###Plot both Vector and Raster
par(mfrow = c(1, 2))   # 1 row, 2 columns
mycols <- colorRampPalette(c("blue", "white", "red"))(20)
plot(st_geometry(cejst_shp))
plot(fire_prob, col = mycols, main = "Fire Risk")
