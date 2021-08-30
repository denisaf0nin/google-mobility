# Google COVID-19 Community Mobility Reports Downloader
![image](https://user-images.githubusercontent.com/59995500/131332872-d4d0a99f-6ae9-4d63-8cec-cfd62caaf042.png)

R code to access [Google COVID-19 Community Mobility Reports](https://www.google.com/covid19/mobility/) csv file and transforming it to the required format:
- Only countries from `countries_list.xlsx` file are included
- Four output Excel files are created - one for each level of geographical aggregation:

  - Mobility at Country Level
  - Mobility at Sub_region_1 Level
  - Mobility at Sub_region_2 Level
  - Mobility at Metro Area Level
  
- In each file, there are six tabs - one for each category of places:

  - Retail and Recreation
  - Grocery and Pharmacy
  - Parks
  - Transit Stations
  - Workplaces
  - Residential

- Monthly averages are calculated. Table is pivoted such that months are in columns. This allows comparison of monthly average mobility in each country in 2020 and 2021.
- Output examples are available [here](https://github.com/denisaf0nin/google-mobility/tree/main/Output%20examples)
