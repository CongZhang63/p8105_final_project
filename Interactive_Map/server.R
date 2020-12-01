library(shiny)
library(tidyverse)
library(leaflet)
library(countrycode)
library(dplyr)
library(plotly)

function(input, output) {
  
  winedata=read_csv("./wine_first150k.csv.csv",locale = readr::locale(encoding = "UTF-8"))
  lat_long=read_csv("./latitude_and_longitude_values.csv")
  continent=read_csv("./continent.csv")
  
  
  # winedata
  
  # continent
  
  lat_long=subset(lat_long, 
                  select = -c(usa_state_code,
                              usa_state_latitude,
                              usa_state_longitude,
                              usa_state)
  )
  
  winedata$continent <- countrycode(sourcevar = winedata$country,
                                    origin = "country.name",
                                    destination = "continent")
  
  winedata =
    winedata %>%
    mutate(country  = ifelse(country == "US","United States", country))
  
  wine_location=merge(winedata, lat_long, by.x = "country", by.y = "country" )
  wine_location = arrange(wine_location,X1)