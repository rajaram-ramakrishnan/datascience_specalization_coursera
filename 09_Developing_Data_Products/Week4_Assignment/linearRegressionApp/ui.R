#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Shiny Project"),
    mainPanel(
        h2("This App has 2 tabs :"),
        HTML("<b> Linear Regression </b> Tab is used to perform linear regression based on selecting single or multiple independent variables <br>
             <b> Plotter </b> Tab is used for visulaization of the independent variables against mpg of mtcars dataset"),
        tabsetPanel(
            type ="tabs",
            tabPanel("Linear Regression
                 ", 
                     br(),
                     h1("Linear Regression analysis on mtcars"),
                     br(),
                     sidebarLayout(
                         sidebarPanel(
                             selectInput("cols","Independent Variables to Select",
                                         choices=names(mtcars[,-1]),selected = names(mtcars[,-1])[[8]],
                                         multiple=TRUE)
                         ),
                         mainPanel(
                             verbatimTextOutput(outputId = "RegOut"),
                             plotOutput("RegPlot")
                         )
                     )
            ),
            tabPanel("Plotter",
                     br(),
                     h1("Plotter on mtcars"),
                     br(),
                     sidebarLayout(
                         sidebarPanel (
                             selectInput("x","X-Axis",choices=names(mtcars[-1]),multiple=FALSE),
                             selectInput("y","Y-Axis",choices=names(mtcars[1]),multiple=FALSE),
                             selectInput("color","Color",c("None",names(mtcars[-1]))),
                             selectInput("size","Size",c("None",names(mtcars[-1]))),
                             checkboxInput("smooth","Smooth"),
                             selectInput("fac_row","Facet Row",c(None=".",names(mtcars[-1]))),
                             selectInput("fac_col","Facet Column",c(None=".",names(mtcars[-1])))
                         ),
                         mainPanel(
                             plotOutput("plotOut")
                         )
                     )
                     
            )
            
            
        )
    )
))
