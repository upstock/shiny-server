# US Indexes ggplot shiny app
ui = fluidPage(
  titlePanel("US_Indexes"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput("sks",
                     "Select Indexes:",
                     choices = c(unique(us_indexes_adj_prices_df_tidy$Stocks)),
                     selected = "DJI",
                     multiple = TRUE
                     
      )
    ),
    mainPanel(
      plotOutput("plot")
    )
  ) 
)


server = function(input, output) {
  
  output$plot = renderPlot({
    plot.us_indexes_adj_prices_df_tidy <- us_indexes_adj_prices_df_tidy[us_indexes_adj_prices_df_tidy$Stocks %in% input$sks, ]
    ggplot(plot.us_indexes_adj_prices_df_tidy) +
      geom_line(aes(x = Date, y = Prices, colour = Stocks)) + 
      labs (x = "Date", y = "Prices", title = "US Indexes Adjusted Prices, SMA 50 and SMA 200") + 
      scale_y_log10() 
  })
  
}

shinyApp(ui = ui, server = server)



