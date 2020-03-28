library(shiny)
library(plotly)


ui <- fluidPage(
    titlePanel("March 28, 2020"),
    plotlyOutput("plotly_test")
)

