##

# Dreissenid Paper Review Map Generation Script
# Date: May 25 2021
# Author: Steven Brownlee
# Email: sbrownle@sfu.ca

# Description: Script using the package 
#
# 

### File Metadata:

# Freshwater ecoregions sourced from: https://www.feow.org/contributors

# Medium-resolution coastline sourced from:

###

install.packages('transformr')
install.packages('wesanderson')

library(ggplot2)
library(ggmap)
library(sf)
library(sp)
library(raster)
library(tmap)
library(ggspatial)
library(gganimate)
library(gifski)
library(ggsn)
library(rgdal)
library(RStoolbox)
library(viridis)
library(tidyr)
library(rgeos)
library(transformr)
library(wesanderson)
install.packages("PNWColors")
library(PNWColors)

#devtools::install_github("thomasp85/transformr")


###
setwd('/media/sbrownlee/Seagate Expansion Drive/NCA/SFU/Dreissenid_Meta-analysis/Correlates_Analysis/Paper_Review/Dreissenid_paper_review_GIS_files')


bioregions <- st_read('bioregions_fixed.shp')

bioregions_crs <- st_transform(bioregions, '4326')

setwd('/media/sbrownlee/Seagate Expansion Drive/NCA/SFU/000a - Background Occurrences')

hyp <- brick('HYP_HR_SR_W_DR.tif')

e <- as(extent(-130, -70, 25, 60), 'SpatialPolygons')
crs(e) <- "+proj=longlat +datum=WGS84 +no_defs"
hypr <- crop(hyp, e)


lake <- st_read('ne_50m_lakes.shp')

laker <- st_crop(lake, e)

river <- st_read('ne_50m_rivers_lake_centerlines.shp')

riverr <- st_crop(river, e)

bioregions_c <- st_crop(bioregions, e)

###

ggplot() +
  xlim(-130, -70) +
  ylim(25, 60) +
  RStoolbox::ggRGB(hypr, 1, 2, 3, ggLayer = TRUE) +
  geom_sf(data = laker, fill = 'white') +
  geom_sf(data = bioregions_c, fill = NA, color = 'black') +
  xlab('Longitude') + ylab('Latitude') +
  labs(title = 'Study Sites in North America')
