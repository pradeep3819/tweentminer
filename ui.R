shinyUI(pageWithSidebar(
  headerPanel("Tweets hunter"),
  
  sidebarPanel(textInput("term", "Enter a term", ""),
               sliderInput("cant", "Select a number of tweets",min=5,max=1500, value = 5),
               radioButtons("lang", "Select the language", c(
                 "English"="en",
                 "Spanish"="es",
                 "Dutch"="nl")),
               submitButton(text = "Run"),
               
               downloadButton("download", "Download File")),
  
  
  mainPanel(
    h4("Last 5 tweets"),
    tableOutput("table"),
    plotOutput("wordcl"))
))
