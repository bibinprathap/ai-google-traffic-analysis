library(googletraffic)
library(ggplot2)
library(dplyr)
library(raster)
library(sp)
library(plumber)
library(leaflet.providers)
library(leaflet)
library(mongolite)

m = mongo("traffic",url = "mongodb://localhost:27017/Assets?retryWrites=true&w=majority")
#* Get the google traffic information
#* @get /googletraffic
function (x,y){
  google_key <- "AIzaSyCqt7888884PQ"
  
  r <- gt_make_raster(location   =  c(x, y),
                      height     = 2000,
                      width      = 2000,
                      zoom       = 16,
                      google_key = google_key)
  # x_coord <- c(54.5353, 54.6355, 54.6475, 54.5614, 54.5353)
  # y_coord <- c(24.3433, 24.3332, 24.4203, 24.4026, 24.3433)
  # xym <- cbind(x_coord, y_coord)
  # p = Polygon(xym)
  # ps = Polygons(list(p),1)
  #  sps = SpatialPolygons(list(ps))
  #  plot(sps)
  #  proj4string(sps) = CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
  #  data = data.frame(f=99.9)
  #  spdf = SpatialPolygonsDataFrame(sps,data)
  #  r <- gt_make_raster_from_polygon(polygon    = spdf,
  #                                   zoom       = 16,
  #                                   google_key = google_key)
  r_df <- rasterToPoints(r, spatial = TRUE) %>% as.data.frame()
  names(r_df) <- c("value", "x", "y")
  
  ex12_mydata<-filter(r_df, value>1)
  bachids = as.numeric( Sys.time())
  fin <- ex12_mydata |>
    distinct(x) |> 
    mutate(batchid = bachids,   createdAt =  Sys.time(),
           updatedAt =  Sys.time(), .before = x) |>
    inner_join(ex12_mydata)
  m$insert(fin)
  
}


#* Get the google Polygon information
#* @get /googlePolygon
function (){
  google_key <- "AIzayyyZcq4PQ"
  
  # x_coord <- c(54.5353, 54.6355, 54.6475, 54.5614, 54.5353)
  # y_coord <- c(24.3433, 24.3332, 24.4203, 24.4026, 24.3433)
  #Al Ain
  x_coord <- c(55.71126377394003, 55.764319662404006, 55.7924080739445, 55.76041842642297, 55.75261608988441, 55.76041842642297, 55.777583566808886, 55.81503478219551, 55.83376038988885, 55.87901394181415, 55.899300016815005, 55.828298754310964, 55.66366945334127, 55.55521697545058, 55.55989837737411, 55.62309730333956, 55.70112066872798, 55.71126377394003)
  y_coord <- c(24.276093282508754, 24.289606150570776, 24.276093282508754, 24.259733645365657, 24.23768041102987, 24.228431142845196, 24.231988633219544, 24.207795738779183, 24.200679307241487, 24.15441282260754, 24.090323871205428, 24.032616394206528, 24.052567592610032, 24.092460686606543, 24.180039409510627, 24.264712878709986, 24.303828637089268, 24.276093282508754)
  
  
  xym <- cbind(x_coord, y_coord)
  p = Polygon(xym)
  ps = Polygons(list(p),1)
  sps = SpatialPolygons(list(ps))
  plot(sps)
  proj4string(sps) = CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
  data = data.frame(f=99.9)
  spdf = SpatialPolygonsDataFrame(sps,data)
  r <- gt_make_raster_from_polygon(polygon    = spdf,
                                   zoom       = 13,
                                   google_key = google_key)
  r_df <- rasterToPoints(r, spatial = TRUE) %>% as.data.frame()
  names(r_df) <- c("value", "x", "y")
  
  ex12_mydata<-filter(r_df, value>1)
  bachids = as.numeric( Sys.time())
  fin <- ex12_mydata |>
    distinct(x) |> 
    mutate(batchid = bachids,areaname = "Al Ain",   createdAt =  Sys.time(),
           updatedAt =  Sys.time(), .before = x) |>
    inner_join(ex12_mydata)
  m$insert(fin)
  
}

 


