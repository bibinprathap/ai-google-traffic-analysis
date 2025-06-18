library(googletraffic)
library(ggplot2)
library(dplyr)
library(raster)
library(sp)
library(plumber)
library(leaflet.providers)
library(leaflet)
library(mongolite)

# MongoDB connection
m = mongo("traffic", url = "mongodb://localhost:27017/Assets?retryWrites=true&w=majority")

#* Get the google traffic information for Dubai
#* @get /googletraffic
function(x, y){
  google_key <- "AIzaSyCqt7888884PQ"  # Replace with your actual Google API key
  
  r <- gt_make_raster(location = c(x, y),
                      height = 2000,
                      width = 2000,
                      zoom = 16,
                      google_key = google_key)
  
  r_df <- rasterToPoints(r, spatial = TRUE) %>% as.data.frame()
  names(r_df) <- c("value", "x", "y")
  
  ex12_mydata <- filter(r_df, value > 1)
  bachids = as.numeric(Sys.time())
  fin <- ex12_mydata |>
    distinct(x) |> 
    mutate(batchid = bachids, 
           createdAt = Sys.time(),
           updatedAt = Sys.time(), 
           .before = x) |>
    inner_join(ex12_mydata)
  m$insert(fin)
}

#* Get the google Polygon information for Dubai
#* @get /googlePolygon
function(){
  google_key <- "AIzayyyZcq4PQ"  # Replace with your actual Google API key
  
  # Dubai polygon coordinates (approximate bounding box)
  x_coord <- c(55.1236, 55.1236, 55.3865, 55.3865, 55.1236)  # Longitude
  y_coord <- c(24.8003, 25.2694, 25.2694, 24.8003, 24.8003)  # Latitude
  
  xym <- cbind(x_coord, y_coord)
  p = Polygon(xym)
  ps = Polygons(list(p), 1)
  sps = SpatialPolygons(list(ps))
  plot(sps)
  proj4string(sps) = CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
  data = data.frame(f = 99.9)
  spdf = SpatialPolygonsDataFrame(sps, data)
  
  r <- gt_make_raster_from_polygon(polygon = spdf,
                                   zoom = 13,
                                   google_key = google_key)
  r_df <- rasterToPoints(r, spatial = TRUE) %>% as.data.frame()
  names(r_df) <- c("value", "x", "y")
  
  ex12_mydata <- filter(r_df, value > 1)
  bachids = as.numeric(Sys.time())
  fin <- ex12_mydata |>
    distinct(x) |> 
    mutate(batchid = bachids,
           areaname = "Dubai",
           createdAt = Sys.time(),
           updatedAt = Sys.time(),
           .before = x) |>
    inner_join(ex12_mydata)
  m$insert(fin)
}

# For more precise Dubai areas, you could use these coordinates:
# Downtown Dubai polygon example
# x_coord <- c(55.2685, 55.2805, 55.2835, 55.2765, 55.2685)
# y_coord <- c(25.1905, 25.1905, 25.1975, 25.1975, 25.1905)

# To run the API:
# r <- plumb("dubai_traffic.R")
# r$run(port = 8000)