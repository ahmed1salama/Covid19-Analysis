library("shiny") # for interactive web apps
library("shinythemes")
library("plotly") # interactive graphs
source("server.R")

c = c("Afghanistan" , "Albania","Algeria","Andorra" , "Angola" ,"Antigua and Barbuda",
      "Argentina" , "Armenia","Australia","Austria" , "Azerbaijan" ,"Bahamas","Bahrain" , 
      "Bangladesh" ,"Barbados" ,"Belarus" , "Belgium","Belize" ,"Benin" , "Bhutan" ,"Bolivia",
      "Bosnia and Herzegovina", "Botswana" ,"Brazil" ,"Brunei", "Bulgaria" ,"Burkina Faso" ,"Burma" , 
      "Burundi","Cabo Verde" ,"Cambodia", "Cameroon" ,"Canada" ,"Central African Republic", "Chad" ,
      "Chile","China" , "Colombia" ,"Comoros","Congo (Brazzaville)" , "Congo (Kinshasa)" ,"Costa Rica" ,
      "Cote d'Ivoire" , "Croatia","Cuba" ,"Cyprus", "Czechia","Denmark","Diamond Princess", 
      "Djibouti" ,"Dominica" ,"Dominican Republic", "Ecuador","Egypt","El Salvador" , "Equatorial Guinea",
      "Eritrea","Estonia" , "Eswatini" ,"Ethiopia" ,"Fiji", "Finland","France" ,"Gabon" , "Gambia" ,
      "Georgia","Germany" , "Ghana","Greece" ,"Grenada" , "Guatemala","Guinea" ,"Guinea-Bissau" , "Guyana" ,
      "Haiti","Holy See", "Honduras" ,"Hungary","Iceland" , "India","Indonesia","Iran", "Iraq" ,"Ireland","Israel", 
      "Italy","Jamaica","Japan" , "Jordan" ,"Kazakhstan" ,"Kenya" , "Korea, South" ,"Kosovo" ,"Kuwait", "Kyrgyzstan" ,
      "Laos" ,"Latvia", "Lebanon","Lesotho","Liberia" , "Libya","Liechtenstein","Lithuania" , "Luxembourg" ,"MS Zaandam" ,
      "Madagascar", "Malawi" ,"Malaysia","Maldives", "Mali" ,"Malta" ,"Marshall Islands", "Mauritania" ,"Mauritius", 
      "Mexico", "Micronesia" ,"Moldova", "Monaco" , "Mongolia" ,"Montenegro","Morocco" , "Mozambique" ,"Namibia", "Nepal" , 
      "Netherlands","New Zealand", "Nicaragua" , "Niger","Nigeria" ,"North Macedonia" , "Norway" ,"Oman","Pakistan", 
      "Panama" ,"Papua New Guinea" , "Paraguay", "Peru" ,"Philippines", "Poland", "Portugal" ,"Qatar", "Romania" , 
      "Russia" ,"Rwanda","Saint Kitts and Nevis" , "Saint Lucia","Saint Vincent and the Grenadines","Samoa" , "San Marino",
      "Sao Tome and Principe", "Saudi Arabia", "Senegal","Serbia" , "Seychelles", "Sierra Leone" ,"Singapore" ,"Slovakia",
      "Slovenia" ,"Solomon Islands", "Somalia" , "South Africa" ,"South Sudan", "Spain" , "Sri Lanka","Sudan", "Suriname",
      "Sweden" ,"Switzerland" ,"Syria" , "Taiwan*","Tajikistan","Tanzania", "Thailand" ,"Timor-Leste", "Togo",
      "Trinidad and Tobago","Tunisia", "Turkey", "US" ,"Uganda" , "Ukraine" , "United Arab Emirates" ,"United Kingdom" ,
      "Uruguay" , "Uzbekistan" ,"Vanuatu" ,"Venezuela" , "Vietnam","West Bank and Gaza","Yemen" , "Zambia" ,"Zimbabwe" )

ui = fluidPage(theme  = shinytheme("cerulean"),
               navbarPage(title = "Covid19 Live Update",
                          tabPanel(title = "Countries Update",
                                   tags$style(type='text/css', '#date {color: green; font-weight: bold; font-size: large;}'),
                                   verbatimTextOutput("date"),
                                   br(),
                                   dataTableOutput("table")),
                          tabPanel(title = "Countries Graphs",
                                   sidebarLayout(
                                 sidebarPanel = selectInput(inputId = "country",
                                                            label = "Country/Region",
                                                            choices = c),
                                 mainPanel = plotlyOutput(outputId = "country_graph") 
                                  )),
                          tabPanel(title = "About",
                                   p(
                                     strong("About this app"),
                                     br(),
                                     br(),
                                     "This dashboard demonstrates some recent news about the Coronavirus pandemic. This App is a simulator, that reads from the John Hopkins dataset",
                                     br(),
                                     br(),
                                     "This app is for educational purposes only !!",
                                     br(),
                                     br(),
                                     strong("Data source"),
                                     br(),
                                     br(),
                                     "Data are conduted from Center for Systems Science and Engineering (CSSE) at Johns Hopkins University ",
                                     a("Data", href = "https://github.com/CSSEGISandData/COVID-19"),
                                     br(),
                                     br(),
                                     strong("Creator"),
                                     br(),
                                     br(),
                                     "Ahmed Salama Hamed"
                                     )
                                   )
               )
)



shinyApp(ui = ui, server = server, options = list(height = 1080))
