# Google COVID-19 Community Mobility Reports Downloader
![image](https://user-images.githubusercontent.com/59995500/131332872-d4d0a99f-6ae9-4d63-8cec-cfd62caaf042.png)

R code to access [Google COVID-19 Community Mobility Reports](https://www.google.com/covid19/mobility/) csv file and transform it to the required format:
- Only countries from `countries_list.xlsx` file are included
- Four output Excel files are created - one for each level of geographical aggregation:

  - Mobility at Country Level
  - Mobility at Sub_region_1 Level
  - Mobility at Sub_region_2 Level
  - Mobility at Metro Area Level
  
- In each file there are six Sheets - one for each category of places:

  - Retail and Recreation
  - Grocery and Pharmacy
  - Parks
  - Transit Stations
  - Workplaces
  - Residential

- Monthly averages are calculated. Table is pivoted so that months are in columns. This allows to compare monthly average mobility for each country in 2020 and 2021:

| country_region |	year |	1 |	2 |	3 |	4 |	5 |	6 |	7 |	8 |	9 |	10 |	11 |	12 |
| -------------- | ----- | :---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Argentina |	2020	| 0 |	-0.667 |	-39.161 |	-82.467 |	-73.774 |	-63.433 |	-58.968 |	-54.71 |	-54.533 |	-51 |	-44.5 |	-34.129 |
| Argentina | 2021 |	-41.548 |	-34.071 |	-30.935 |	-36.367 |	-42.935 |	-34.667 |	-19.419 |	-14.92 |				
| Australia |	2020 |	0	1.2 |	-12.355 |	-41.1 |	-28.226 |	-16.3 |	-14.452 |	-21.355 |	-18.4 |	-15.742 |	-9.667 |	-5 |
| Australia | 2021 | -13.774 | -12.75 | -8.355 | -7.733 | -6.129 | -9.967 | -18.613 | -24.36 |  
| Austria | 2020 | 0 | 5.6 | -45.387 | -69.967 | -37.194 | -17.967 | -6.161 | -6.032 | -9.2 | -22.871 | -54.867 | -52.065 |
| Austria | 2021 | -67.774 | -48.893 | -42 | -48.7 | -31.742 | -13.8 | -5.29 | 0.6 |  
| ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... |

(Data was extracted on August 30, so months 9-12 in 2021 are blank)			

- Output examples are available [here](https://github.com/denisaf0nin/google-mobility/tree/main/Output%20examples)
