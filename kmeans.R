library(png)
library(reshape)
library(stats)

img <- readPNG("bird_small.png")
origdim <- dim(img)

dim(img) <- c(dim(img)[1]*dim(img)[2],3)

k_colors = kmeans(img,centers=128,iter.max=100)
img128 <- k_colors$centers[k_colors$cluster,]
dim(img128) <- origdim
writePNG(img128,"img128.png")