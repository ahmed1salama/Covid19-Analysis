source("main.R")

server = function(input, output){
  
  
  # Updating data every 4 hours
  dataLoadingTrigger <- reactiveTimer(1000)
  
  observeEvent(dataLoadingTrigger, {
    updateData()
  })
  
  
  output$table = renderDataTable(
    expr = full_data %>% filter(date == max(date)) %>% group_by(`Country/Region`) %>% summarise(Confirmed = sum(Confirmed),
                                                                                                Deceased = sum(Deceased),
                                                                                                Recovered = sum(Recovered),
                                                                                                Active = sum(Active),
                                                                                                Confirmed_New = sum(Confirmed_New),
                                                                                                Deceased_New = sum(Deceased_New),
                                                                                                Recovered_New = sum(Recovered_New),
                                                                                                Active_New = sum(Active_New)) %>% arrange(desc(Confirmed))
    
  )
  output$date = renderText({paste("Date:",sep = " ", max(full_data$date))})
  
  output$country_graph = renderPlotly({ 
    data = full_data %>% filter(`Country/Region` == input$country) %>% group_by(date) %>% summarize(Confirmed = sum(Confirmed))
    plot_ly(
      data,
      x     = ~date,
      y     = ~Confirmed,
      type  = 'scatter',
      mode  = 'lines') %>% layout(xaxis = list(title = "Date", titlefont = list(color = "red", size = 18)),
                                  yaxis = list(title = "Confirmed Cases", titlefont = list(color = "red", size = 18)))

  })
  
}

