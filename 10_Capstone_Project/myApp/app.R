#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# This R script creates a shiny app that takes a word as input and output the 
# predicted next word.
library(shiny)

## Source n-gram prediction functions

source("prediction.R")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Word Prediction Model"),
    p("This application takes a word or set of words as input and outputs a prediction of next word with 3 options."),
    

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            span(h2("Instructions for Prediction Model"),style="color:green"),
            span(h4("Enter a word or words in text box"),style="color:red"),
            span(h4("Top 3 Predicted next word prints below in blue colour"),style="color:red"),
            span(h4("No need to press enter or submit"),style="color:red"),
            span(h4("A question mark (?) means no prediction"),style="color:red"),
            span(h4("Additional tabs shows the plots of top ngrams in the dataset"),style="color:red"),
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                tabPanel("predict",
                         textInput("user_inp", h3("Enter the word(s)"), 
                                   value ="Your words"),
                         h3('Predicted Next Word(s) : '),
                         h4(em(span(textOutput("ngram_out"),style="color:blue")))
               
                ),
                
                tabPanel("Top 20 Quadgrams",
                         br(),
                         img(src = "quadgram.png")
                         ),
                
                tabPanel("Top 20 Trigrams",
                         br(),
                         img(src = "trigram.png")
                ),
                
                tabPanel("Top 20 Bigrams",
                         br(),
                         img(src = "bigram.png")
                )
            )
          
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

   output$ngram_out <- renderText({
       ngrams(input$user_inp)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)
