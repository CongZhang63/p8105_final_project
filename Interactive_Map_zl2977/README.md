Hello, welcome to use my Shinydashboard. Since the main dataset is too large for Github, I did not push the dataset `winedata_first150k.csv` under my folder. However, the shiny.io server needs the file `winedata_first150k.csv` in the same directory as `server.R` and `ui.R` to run correctly. The `winemag-data_first150k.csv` contain the same data as `winedata_first150k.csv`.

Therefore, When reproducing my Shiny R Code (`server.R` and `ui.R`), please move the dataset `winemag-data_first150k.csv` from the `data` folder to the same folder as `server.R` and `ui.R`, and rename the name of `winemag-data_first150k.csv` to `winedata_first150k.csv`.

please also make sure the datasets `continent.csv` and `latitude_and_longitude_values.csv` are in the the same folder as `server.R` and `ui.R` as well.

Then I believe you can successfully reproduce the Shiny code locally.

Enjoy the Shinydashboard. Thank you!


Zhourong Li zl2977