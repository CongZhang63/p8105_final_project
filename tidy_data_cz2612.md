Tidy Wine Data
================

<br/>

### Import `winemag-data_first150k.csv` data.

``` r
wine150_df = 
  read_csv("./data/winemag-data_first150k.csv") %>% 
  janitor::clean_names() %>% 
    select(id = x1, points, price, country, province, variety, winery) %>% 
  mutate(
        country = factor(country),
        province = factor(province),
        variety = factor(variety),
        winery = factor(winery)     
    )
```

    ## Warning: Missing column names filled in: 'X1' [1]

The original dataset `winemag-data_first150k.csv` has 150930
observations. <br/> The numbers of missing values for some important
variables are as follows. <br/> `id`: 0 missing observations. <br/>
`points`: 0 missing observations. <br/> `price`: 13695 missing
observations. <br/> `country`: 5 missing observations. <br/> `province`:
5 missing observations. <br/> `variety`: 0 missing observations. <br/>
`winery`: 0 missing observations. <br/>

<br/>

### Create average points and price at the country and province levels respectively for `winemag-data_first150k.csv` data.

``` r
wine150_tidy =
  wine150_df %>% 
  arrange(country, points) %>% 
  group_by(country) %>% 
  mutate(
    points_avg_country = round(mean(points), 2),
    points_med_country = median(points),
    price_avg_country = round(mean(price, na.rm = TRUE), 2),
    price_med_country = median(price)
  ) %>% 
  ungroup(country) %>% 
  arrange(province, points) %>% 
  group_by(province) %>% 
  mutate(
    points_avg_province = round(mean(points), 2),
    points_med_province = median(points),
    price_avg_province = round(mean(price, na.rm = TRUE), 2),
    price_med_province = median(price)
  ) %>% 
  ungroup(province) %>%  
  arrange(country, province, points)
```

Due to 5 missing values of country and province in
`winemag-data_first150k.csv` data, average points and price are also
created for this missing group. Caution is needed for subsequent
analysis.

<br/>

### Create average points and price at the variety and winery levels respectively for `winemag-data_first150k.csv` data.

``` r
wine150_tidy =
  wine150_tidy %>% 
  arrange(variety, points) %>% 
  group_by(variety) %>% 
  mutate(
    points_avg_variety = round(mean(points), 2),
    points_med_variety = median(points),
    price_avg_variety = round(mean(price, na.rm = TRUE), 2),
    price_med_variety = median(price)
  ) %>% 
  ungroup(variety) %>% 
  arrange(winery, points) %>% 
  group_by(winery) %>% 
  mutate(
    points_avg_winery = round(mean(points), 2),
    points_med_winery = median(points),  
    price_avg_winery = round(mean(price, na.rm = TRUE), 2),
    price_med_winery = median(price)
  ) %>% 
  ungroup(winery) %>%    
  arrange(variety, winery, points)

save(wine150_tidy, file = "./data/wine150_tidy")
```

There is not any missing value of variety in
`winemag-data_first150k.csv` data.
