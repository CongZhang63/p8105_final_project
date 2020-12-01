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
  

  output$map <- renderLeaflet({
    
    
    statistics=
      wine_location %>%
      filter(continent == input[["continent_choice"]] | input[["continent_choice"]] == "All Continents",
             price %in% input$price_range[1]:input$price_range[2],
             points == input[["rating_chose"]] | input[["rating_chose"]] == "All Ratings"
      )%>%
      dplyr::group_by(country) %>%
      dplyr::summarize(
        n_obs = n(),
        mean_point = mean(points),
        max_price = max(price,na.rm = T),
        min_price = min(price, na.rm = T)
      ) 
    
    wine_location_simp=
      wine_location %>% 
      filter(continent == input[["continent_choice"]] | input[["continent_choice"]] == "All Continents",
             price %in% input$price_range[1]:input$price_range[2],
             points == input[["rating_chose"]] | input[["rating_chose"]] == "All Ratings"
      )%>%
      distinct(country, .keep_all = TRUE)
    
    wine_location_simp=arrange(wine_location_simp,country)
    
    statistics= cbind(statistics,latitude=wine_location_simp$latitude, longitude=wine_location_simp$longitude)
    
    statistics=
      statistics%>%
      mutate(mean_point=round(mean_point, digits=2),
             max_price=as.character(max_price),
             min_price=as.character(min_price)
      )
    
    statistics$max_price[which(statistics$max_price == "-Inf")] = "Na"
    statistics$min_price[which(statistics$min_price == "Inf")] = "Na"
    
    pal <- colorNumeric(
      palette = "viridis",
      domain = statistics$mean_point)
    
    statistics %>% 
      mutate(
        click_label = 
          str_c("<b>",statistics$country,"</b><br>","Average Rating: ", statistics$mean_point, "<br>", "<b>$", statistics$min_price, "~", statistics$max_price, "</b><br>Wines Recorded: ", statistics$n_obs)) %>% 
      leaflet() %>% 
      addProviderTiles(providers$CartoDB.Positron) %>% 
      addCircleMarkers(~longitude, ~latitude, radius = .1, color = ~pal(mean_point), popup = ~click_label)
    
  }
  )
  
  output$map1 <- renderPlotly({
    
    statistics=
      wine_location %>%
      filter(continent == input[["continent_choice"]] | input[["continent_choice"]] == "All Continents",
             price %in% input$price_range[1]:input$price_range[2],
             points == input[["rating_chose"]] | input[["rating_chose"]] == "All Ratings"
      )%>%
      plot_ly(
        y= ~price, x = ~country, color = ~country, type = "box", colors = "viridis"
      )%>%
      layout(yaxis = list(title = 'Price'),
             xaxis = list(title = 'Country')  
      )
  })
  