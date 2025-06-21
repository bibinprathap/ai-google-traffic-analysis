 
 # 🚦 Real-time Dubai Traffic Analysis using Google Map
[![Article](https://bibinprathap.medium.com/unlock-dubais-traffic-secrets-real-time-analysis-with-google-maps-r-07971d9207c8)



  ![  Traffic Visualization](google-traffic.jpeg)  


[![GitHub stars](https://img.shields.io/github/stars/bibinprathap/ai-google-traffic-analysis.svg?style=social)](https://github.com/bibinprathap/ai-google-traffic-analysis/stargazers)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![R](https://img.shields.io/badge/R-4.3+-blue.svg)](https://www.r-project.org/)
[![Last Commit](https://img.shields.io/github/last-commit/bibinprathap/ai-google-traffic-analysis)](https://github.com/bibinprathap/ai-google-traffic-analysis/commits/main)

A powerful R-based solution for analyzing and visualizing real-time traffic conditions across Dubai using Google Maps API data.

## 🌟 Why Star This Repository?

- **First open-source** Dubai-specific traffic analysis tool
- **Real-time data** processing pipeline
- **Ready-to-deploy** API endpoints
- **MongoDB integration** for data persistence
- **Beautiful Leaflet visualizations**


# Quick install
git clone https://github.com/bibinprathap/ai-google-traffic-analysis.git
cd ai-google-traffic-analysis
Rscript -e "install.packages(c('googletraffic', 'leaflet', 'mongolite'))"


 ## 📊 Key Features
Feature	Description
Real-time Data	Live traffic data from Google Maps API
Polygon Analysis	Analyze specific Dubai neighborhoods
API Endpoints	Ready-to-use /googletraffic and /googlePolygon endpoints
Data Storage	MongoDB integration for historical analysis
Visualization	Interactive Leaflet maps with traffic heatmaps
##  🚀 Getting Started
Prerequisites
R (≥ 4.3.0)

Google Maps API key

MongoDB instance

## Installation
r
# Install required packages
install.packages(c("googletraffic", "leaflet", "mongolite", "plumber", "raster", "sp"))
Configuration
Add your Google Maps API key to config.R:

r
google_key <- "YOUR_ACTUAL_API_KEY"
Set up MongoDB connection in db_config.R:

r
mongo_url <- "mongodb://localhost:27017/yourdb"
🗺️ Example: Analyzing Downtown Dubai
r
source("googletraffic.R")

# Get traffic for Burj Khalifa area
r <- gt_make_raster(location = c(25.1972, 55.2744), 
                    height = 2000, 
                    width = 2000,
                    zoom = 16)
## 📈 Sample Output
 

## 🤝 Contributing
We welcome contributions! Please see our Contribution Guidelines.

## 📜 License
MIT License - see LICENSE file for details.
 
 areaname
    batchid
    createdAt
    filename
    updatedAt


r <- gt_make_raster(location = c(24.380374, 54.659353),
height = 2000,
width = 2000,
zoom = 16,
google_key = google_key)
library(leaflet)
library(leaflet.providers)
Google Maps
x_coord <- c(54.5353, 54.6355, 54.6475, 54.5614, 54.5353)
y_coord <- c(24.3433, 24.3332, 24.4203, 24.4026, 24.3433)
xym <- cbind(x_coord, y_coord)
xym
library(sp)
p = Polygon(xym)
ps = Polygons(list(p),1)
sps = SpatialPolygons(list(ps))
plot(sps)
proj4string(sps) = CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
data = data.frame(f=99.9)
spdf = SpatialPolygonsDataFrame(sps,data)
spdf





## Define Leaflet Palette and Legend

traffic_pal <- colorNumeric(c("green", "orange", "red", "#660000"),
1:4,
na.color = "transparent")

leaflet(width = "100%") %>%
addProviderTiles("Esri.WorldGrayCanvas") %>%
addRasterImage(r, colors = traffic_pal, opacity = 1, method = "ngb")

## Plot

r_df <- rasterToPoints(r, spatial = TRUE) %>% as.data.frame()
names(r_df) <- c("value", "x", "y")

library(plumber)
r <- plumb("googletraffic.R")
r$run(port = 8000)

DB_CONNECT = mongodb://localhost:27017/myFirstDatabase?retryWrites=true&w=majority



#Abu dhabi

#x_coord <- c(54.315598592481166, 54.38807553730996, 54.39987410972415, 54.45255673177493, 54.46228594160962, 54.41234266445588, 54.42790940019273, 54.39807315669759, 54.41039682248953, 54.42350165251307, 54.43876477808257, 54.4739054625349, 54.47958476507358, 54.48668389324558, 54.5200497956549, 54.58962125174375, 54.61269341830288, 54.59273896642898, 54.55822315778096, 54.60730032320237, 54.715748929643354, 54.704901852468, 54.59823892690443, 54.54942707961365, 54.515573153632886, 54.455450081068875, 54.470312024174376, 54.52224892039041, 54.52318787114257, 54.5132904654011, 54.498111997715654, 54.48510188255767, 54.487703905589484, 54.48163251851497, 54.37364856270085, 54.32717665638944, 54.32374592161605, 54.313987709056846, 54.306940111095116, 54.31543337017581, 54.31561111799459, 54.315596926112704, 54.31559867601632, 54.315598592481166)
#y_coord <- c(24.460220843990555, 24.525080307538047, 24.53866149690367, 24.56062896035357, 24.51165532519562, 24.520507396567623, 24.479782705694376, 24.46325298286861, 24.449673372971446, 24.444191801391938, 24.44742315804865, 24.43029602391175, 24.42803377567479, 24.424155541450617, 24.423509157489576, 24.446130625326973, 24.45259315637057, 24.4872769932456, 24.50543529775517, 24.51819361836573, 24.479082016049446, 24.370442536345635, 24.30125967535602, 24.289725527109226, 24.316105246788084, 24.31672102910197, 24.382240205171072, 24.380828115762597, 24.389584270177252, 24.392058852126482, 24.391663890040263, 24.39363868812943, 24.401340105734903, 24.40331475256393, 24.43332558192172, 24.456345115435255, 24.458153014412346, 24.45371166177837, 24.45502763443831, 24.460126898655204, 24.460211500566288, 24.46022011266264, 24.460220332181777, 24.460220843990555)


 # x_coord <- c(54.5353, 54.6355, 54.6475, 54.5614, 54.5353)
 # y_coord <- c(24.3433, 24.3332, 24.4203, 24.4026, 24.3433)
#Al Ain
x_coord <- c(55.71126377394003, 55.764319662404006, 55.7924080739445, 55.76041842642297, 55.75261608988441, 55.76041842642297, 55.777583566808886, 55.81503478219551, 55.83376038988885, 55.87901394181415, 55.899300016815005, 55.828298754310964, 55.66366945334127, 55.55521697545058, 55.55989837737411, 55.62309730333956, 55.70112066872798, 55.71126377394003)
y_coord <- c(24.276093282508754, 24.289606150570776, 24.276093282508754, 24.259733645365657, 24.23768041102987, 24.228431142845196, 24.231988633219544, 24.207795738779183, 24.200679307241487, 24.15441282260754, 24.090323871205428, 24.032616394206528, 24.052567592610032, 24.092460686606543, 24.180039409510627, 24.264712878709986, 24.303828637089268, 24.276093282508754)

