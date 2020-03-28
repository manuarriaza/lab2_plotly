library(shiny)
library(plotly)

shinyServer(function(input, output, session) {
  
  # Generate different series
  fibonacci_series <- function(len){
    fibonacci <- numeric(len)
    fibonacci[1] <- 1
    fibonacci[2] <- 1
    
    for (i in 3:len) { 
      fibonacci[i] <- fibonacci[i-1]+fibonacci[i-2]
    } 
    return(fibonacci)
  }
  
  fibonacci <- fibonacci_series(10)
  quadratic <- seq(from = 1, to = 10)^2
  linear <- seq(from = 1, to = 10)
  
  # Convert to dataframe
  df <- as.data.frame(
    rbind(
      cbind(linear, seq(2000, 2009)),
      cbind(quadratic, seq(2000, 2009)),
      cbind(fibonacci, seq(2000, 2009))
    )
  )
  
  df$serie <- c(rep("linear", 10), rep("quadratic", 10), rep("fibbonacci", 10))
  #str(df)
  colnames(df) <- c("Number of objects", "Year", "Serie")
  
  
    output$plotly_test <- renderPlotly({
      fig <- df %>%
        plot_ly(
          x = ~Year, 
          y = ~`Number of objects`, 
          size = ~`Number of objects`,
          color = ~Serie, 
          colors = c("red", "blue", "green"),
          frame = ~Year, 
          text = ~`Number of objects`, 
          hoverinfo = "text",
          type = 'scatter',
          mode = 'markers'
        )
      
      fig <- fig %>%
        layout(
          title = "Simulated growth per year",
          images = 
            list(source =  "https://images.plot.ly/language-icons/api-home/r-logo.png",
                 xref = "x",
                 yref = "y",
                 x = 2000,
                 y = 100,
                 sizex = 10,
                 sizey = 100,
                 sizing = "stretch",
                 opacity = 0.1,
                 layer = "below"
            )
        )
      
    })
})

# Run the application 
#shinyApp(ui = ui, server = server)


