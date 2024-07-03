library(shinyWidgets)

ui <- fluidPage(
  tags$head(
    tags$link(
      rel = "stylesheet", 
      type = "text/css", 
      href = "shinyWidgets_multiInput.css"
    )
  ),
  multiInput(
    inputId = "id",
    label = "Fruits :",
    choices = c(
      "Banana",
      "Blueberry",
      "Cherry",
      "Coconut",
      "Grapefruit",
      "Kiwi",
      "Lemon",
      "Lime",
      "Mango",
      "Orange",
      "Papaya"
    ),
    selected = "Banana",
    width = "350px"
  ), verbatimTextOutput(outputId = "res")
)

server <- function(input, output, session) {
  output$res <- renderPrint({
    input$id
  })
}

shinyApp(ui = ui, server = server)