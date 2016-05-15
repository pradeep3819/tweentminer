shinyServer(function(input,output){
  
  library(shiny)
  library(twitteR)
  library(wordcloud)
  library(tm)
  
  
  consumerKey<-"5ZV7LxWDkhCr6T1B1SFd2tI2o"
  consumerSecret <- "58cNJmMnPDwo69g0v62sRT3Q91BhRgYmEtHtGf7tEIQV5piW63"
  ACCESS_TOKEN<-"78569899-7d0Xw6v03V7ScmmVUEuGIGvPpmE90QlwNNobBeqLG"
  ACCESS_secret<-"En39L7qNfyEUG0f1rL0phsF2yB4Xs4vwHIbBVx0oGoFN0"
  
  
  my_oauth <- setup_twitter_oauth(consumerKey,consumerSecret,ACCESS_TOKEN,ACCESS_secret)
  
  
  
  rawData <- (function(){
    tweets <- searchTwitter(input$term, n=input$cant,lang=input$lang)
    twListToDF(tweets)
  })
  
  output$table <- renderTable(
    data.frame(head(rawData()[1],n=input$cant)))
  
  
  
  output$wordcl <- renderPlot({
    tw.text <- enc2native(as.character(rawData()))
    tw.text <- tolower(tw.text)
    tw.text <- removeWords(tw.text,c("english","rt"))
    tw.text <- removePunctuation(tw.text, TRUE)
    tw.text <- unlist(strsplit(tw.text," "))
    
    word <- sort(table(tw.text),TRUE)
    wordc <- head(word,n=15)
    wordcloud(names(wordc),word,random.color = TRUE,colors = rainbow(10),scale = c(15,2))
  })
  
  
  
  
})
