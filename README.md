Final Project Proposal
================
Zhourong Li (zl2977), Yubei Liang (yl4606), Leo Liu (ll3452), Cong Zhang
(cz2612),Ruwen Zhou (rz2530)

## Tentative Project Title

CHEERS\! Professional Wine Reviews

## Motivation

Wine is an essential component in western food culture. Due to the
variety of wine brands, people may easily get lost. Therefore, we would
like to provide a review of wines by professional wine tasters and a
guidance for wine lovers based on variety, location, winery, score and
price. Wine lovers can select and buy wines more easily with information
provided on our website.

## Intended Final Products

A github website, a report regarding summary visualization, statistical
analysis and interactive map, and a screenshot introduction video

## Anticipated Data Resources

Our dataset [Wine Reviews](https://www.kaggle.com/zynicide/wine-reviews)
comes from [Kaggle](http://kaggle.com/) website.

This dataset contains 10 columns, including country, description,
designation (the vineyard within the winery where the grapes that made
the wine are from), points (the number of points
[WineEnthusiast](https://www.winemag.com/?s=&drink_type=wine) rated the
wine on a scale of 1-100), price, province, region\_1, region\_2,
variety (the type of grapes used to make the wine), winery (the winery
that made the wine).

The second dataset we will use is [Continent
Data](https://datahub.io/JohnSnowLabs/country-and-continent-codes-list)
comes from [Datahub](https://datahub.io/) website.

This dataset contains 6 columns, including Continent\_Name,
Continent\_Code, Country\_Name, Two\_Letter\_Country\_Code,
Three\_Letter\_Country\_Code, Country\_Number.

## Planned Analyses / Visualizations / Coding Challenges

  - World-wide maps showing the region of wine growing
  - Ranking of wines by score
  - Distribution of prices of wines
  - Price-ranking comparison to find cost-performance ratio
  - The popularity of different types of grapes used to make the wine
  - Evaluating winery by variety, score and price of wines produced
  - Hypothesis Test
  - Regression of price vs. points + variety + continent
  - Interactive map showing wine information based on continents,
    countries, prices and wine points
  - The dataset is very large with more than 150,000 rows, so it might
    cost us more time to tidy, filter and clean data.
  - Moreover, the region of wines is divided into attributes: country,
    province, region\_1 and region\_2. It might be difficult for us to
    create a map showing all this information all together.
  - Dealing with text attributes.
  - Collect longitude, latitude and continent data by countries to
    construct a world map using ShinyDashboard.

## Planned Timeline

  - November 5-7: group meeting, write the proposal document
  - November 8-13: discuss the framework of the project, prepare and do
    the project review meeting
  - November 14-15: include the text and words,description and website
    framework, start to write - the report
  - November 14-20: build the World-wide maps showing the region of
    wines
  - November 21-31: build the plots and charts, more
    visualizations,start video recording
  - December 1-5: finished the report, video, and refine the website
  - December 5: peer assessment, final refinements
  - December 6-10: prepare for the presentation
  - December 10: presentation and discussion
