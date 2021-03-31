library("tidyverse") # data manipulation
library("DT") # tables displayed on HTML
library("fs") # file system management



# downloading the data

downloadGithubData = function() {
  download.file(
    url      = "https://github.com/CSSEGISandData/COVID-19/archive/master.zip",
    destfile = "data/covid19_data.zip"
  )
  
  data_path <- "COVID-19-master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_"
  unzip(
    zipfile   = "data/covid19_data.zip",  
    files     = paste0(data_path, c("confirmed_global.csv", "deaths_global.csv", "recovered_global.csv")),
    exdir     = "data",
    junkpaths = T
  )
}

get_data = function(){
  # reading the data
  
  data_confirmed = read_csv("data/time_series_covid19_confirmed_global.csv")
  
  data_deceased = read_csv("data/time_series_covid19_deaths_global.csv")
  
  data_recovered = read_csv("data/time_series_covid19_recovered_global.csv")
  
  
  
  # manipulating the data 
  data_confirmed_sub = data_confirmed %>% 
    pivot_longer(names_to = "date", cols = 5:ncol(data_confirmed)) 
  
  names(data_confirmed_sub)[6] = "Confirmed"
  
  
  
  data_deceased_sub = data_deceased %>%
    pivot_longer(names_to = "date", cols = 5:ncol(data_deceased))
  
  names(data_deceased_sub)[6] = "Deceased"
  
  
  data_recovered_sub = data_recovered %>%
    pivot_longer(names_to = "date", cols = 5:ncol(data_deceased))
  
  names(data_recovered_sub)[6] = "Recovered"
  
  
  
  full_data = data_confirmed_sub %>% 
    full_join(data_deceased_sub) %>%
    full_join(data_recovered_sub) %>%
    group_by(`Province/State`, `Country/Region`, Lat, Long) %>%
    mutate(date = as.Date(date, "%m/%d/%y"),
           Active = Confirmed - Deceased - Recovered,
           Confirmed_New = Confirmed - lag(Confirmed, 1, default = 0),
           Deceased_New = Deceased - lag(Deceased, 1, default = 0),
           Recovered_New = Recovered - lag(Recovered, 1, default = 0),
           Active_New = ifelse(Active - lag(Active, 1, default = 0) > 0, Active - lag(Active, 1, default = 0), 0))%>%
    ungroup()
  return(full_data)
  
}

if(!exists("full_data")){
  full_data <<- get_data()
}


updateData = function() {
  # Download data from Johns Hopkins (https://github.com/CSSEGISandData/COVID-19) if the data is older than 0.5h
  if (!dir_exists("data")) {
    print("data not found")
    dir.create('data')
    downloadGithubData()
    full_data <<- get_data()
  } else if ((!file.exists("data/covid19_data.zip")) || (as.double(Sys.time() - file_info("data/covid19_data.zip")$change_time, units = "hours") > 4)) {
    print("more than 4 hoirs")
    downloadGithubData()
    full_data <<- get_data()
  } 
}





