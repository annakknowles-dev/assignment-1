# 1. Load the shiny package 
library(shiny)

# 2. Define the User Interface 
ui <- fluidPage(
  
  titlePanel("Iris Dataset Explorer"),
  
  # Sidebar layout
  sidebarLayout(
    
    # Reactive inputs
    sidebarPanel(
      selectInput(inputId = "species_choice", 
                  label = "Choose a Flower Species:",
                  choices = c("setosa", "versicolor", "virginica"))
    ),
    
    # Dynamic outputs
    mainPanel(
      plotOutput(outputId = "flower_plot")
    )
  )
)

# 3. Server Logic 
server <- function(input, output) {
  
  output$flower_plot <- renderPlot({
    
    # Filter based on selection
    filtered_data <- subset(iris, Species == input$species_choice)
    
    # Scatter plot of the filtered data
    plot(x = filtered_data$Sepal.Length, 
         y = filtered_data$Sepal.Width,
         main = paste("Sepal Dimensions for", input$species_choice),
         xlab = "Sepal Length",
         ylab = "Sepal Width",
         col = "purple",
         pch = 19,
         cex = 1.5)
  })
}

# 4. Run 
shinyApp(ui = ui, server = server)