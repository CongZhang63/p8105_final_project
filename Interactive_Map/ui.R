library(shiny)
library(ggplot2)
library(tidyverse)
library(leaflet)
library(countrycode)
library(dplyr)
library(plotly)
library(shinydashboard)

winedata=read_csv("./wine_first150k.csv",locale = readr::locale(encoding = "UTF-8"))
lat_long=read_csv("./latitude_and_longitude_values.csv")
continent=read_csv("./continent.csv")

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


continent_choice = wine_location %>% distinct(continent) %>% pull()
continent_choice[6] ="All Continents"


max_price = wine_location %>% distinct(price) %>% max(na.rm = T)
min_price = wine_location %>% distinct(price) %>% min(na.rm = T)


rating = wine_location %>% distinct(points) %>% pull()
rating=sort(rating, decreasing = T)
rating=prepend(rating, "All Ratings")

sidebar <-dashboardSidebar(
  
  radioButtons(
    "continent_choice",
    label = h3("Choose Continent"),
    choices = continent_choice,
    selected = "All Continents"
  ),
  #--------------------------------------------------------------------
  # sliderInput widget
  
  
  
  sliderInput(
    "price_range",
    label = h3("Choose Price Range"),
    min = min_price, max = max_price, value = c(4, 2000)),
  
  #--------------------------------------------------------------------
  # selectInput widget
  
  
  selectInput(
    "rating_chose",
    label = h3("Select Rating"),
    choices = rating,
    selected = "All Ratings"
  )
  
)

body <- dashboardBody(
  fluidRow(
    # column(width = 12,
    box(
      title = "Wine Information World Map", background = "black",
      width = 12, 
      leafletOutput("map")
    )
    # )
  ),
  
  fluidRow(              
    # column(width = 6, 
    box(
      width = 6, 
      plotlyOutput("map1")
    ),
    box(
      width = 6, 
      plotlyOutput("map2")
    )
    # )
  )     
)

dashboardPage(
  dashboardHeader(title = "Interactive tabs"),
  sidebar,
  body
)
