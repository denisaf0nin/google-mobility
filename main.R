# Mobility data - download and transformation

library(tidyverse)
library(openxlsx)
library(readr)
library(readxl)


### IMPORT AND PRE-PROCESSING ###
# Reading raw data file
google <- read_csv("https://www.gstatic.com/covid19/mobility/Global_Mobility_Report.csv")

# Reading file with the list of required countries
countries_list <- read_excel("countries_list.xlsx") %>% select(1) %>% .[[1]]

# Remove countries that are not available in google file:
countries_list <- countries_list[countries_list %in% sort(unique(google$country_region))]

# Filter required countries only. Remove extra columns:
df <- google %>%
  filter(country_region %in% countries_list) %>%
  select(c(2:5, 9:15)) 

df$date <- as.Date(df$date,"%Y/%m/%d")

# Create four datasets - one for each level of geographical hierarchy:
country_level <- df %>%
  filter(is.na(sub_region_1)) %>%
  select(1,5:ncol(.))

sub_reg_1 <- df %>%
  filter(!is.na(sub_region_1) & is.na(sub_region_2)) %>%
  select(1,2,5:11)

sub_reg_2 <- df %>%
  filter(!is.na(sub_region_1) & !is.na(sub_region_2)) %>%
  select(1,2,3,5:11)

metro_area <- df %>%
  filter(!is.na(metro_area)) %>%
  select(1, 4:11)


### TRANSFORMATION ###
# A function to transform a dataset into required shape 
transform <- function(df, geo_groups){
  
  transformed_df <- df %>%
    mutate(year = as.numeric(format(date, format = "%Y")),
           month = as.numeric(format(date, format = "%m"))) %>%
    select(-date) %>%
    group_by_at(geo_groups) %>%
    summarize(retail_and_recreation = round(mean(retail_and_recreation_percent_change_from_baseline, na.rm = T), 3),
              grocery_and_pharmacy = round(mean(grocery_and_pharmacy_percent_change_from_baseline, na.rm = T), 3),
              parks = round(mean(parks_percent_change_from_baseline, na.rm = T), 3),
              transit_stations = round(mean(transit_stations_percent_change_from_baseline, na.rm = T), 3),
              workplaces = round(mean(workplaces_percent_change_from_baseline, na.rm = T), 3),
              residential = round(mean(residential_percent_change_from_baseline, na.rm = T),3))
  
  transformed_df
  
}

# Define colums to group every df by:
cols_country_level<- c("country_region", "year", "month")
cols_sub_reion_1 <- c("country_region", "sub_region_1", "year", "month")
cols_sub_region_2 <- c("country_region", "sub_region_1", "sub_region_2", "year", "month")
cols_metro_area <- c("country_region", "metro_area", "year", "month")

# Apply transform function to each df using appropriate grouping columns:
country_level <- transform(country_level, cols_country_level)
sub_reg_1 <- transform(sub_reg_1, cols_sub_reion_1)
sub_reg_2 <- transform(sub_reg_2, cols_sub_region_2)
metro_area <- transform(metro_area, cols_metro_area)


### OUTPUT ###
# Get list of mobility groups
mobility_groups <- colnames(country_level)[4:ncol(country_level)]
i <- mobility_groups[2]

# Defining a function to create a blank workbook, write data in sheets and save the workbook
write_wb <- function(df, wb_name) {
  OUT <- createWorkbook()
  
  for (i in mobility_groups) {
    output_df <- df%>%
      select(-mobility_groups[!mobility_groups %in% i]) %>%
      spread(month, i)
    
    output_df$'1'[is.na(output_df$'1')] <- 0
    
    # Add sheet to the workbook
    addWorksheet(OUT, i)
    writeData(OUT, sheet = i, x = output_df)
    
  }
  
  saveWorkbook(OUT, wb_name, overwrite=T)
}

# Running the write_wb function for all four datasets grouped at different geographical levels
write_wb(country_level, "Country Level Mobility.xlsx")
write_wb(sub_reg_1, "Sub_reg_1 Level Mobility.xlsx")
write_wb(sub_reg_2, "Sub_reg_2 Level Mobility.xlsx")
write_wb(metro_area, "Metro Area Level Mobility.xlsx")
