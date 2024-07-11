library(shiny)

ui <- fluidPage(
  fileInput(
    "file1",
    "jpg image",
    accept = c('image/jpeg', 'image/jpg')
  ),
  textOutput("upload_message_output")
)

server <- function(input, output, session) {
  upload_message <- reactiveVal()
  
  observeEvent(input$file1, {
    to <- file.path("www", "img", input$file1$name)
    to_sans_ext <- tools::file_path_sans_ext(to)
    to_ext <- tools::file_ext(to)
    i <- 0
    while(file.exists(to)) {
      i <- i + 1
      to <- paste0(to_sans_ext, "_", i, ".", to_ext)
    }
    if(file.copy(input$file1$datapath, to))
      upload_message(sprintf("File uploaded to %s", to))
  })
  
  output$upload_message_output <- renderText({ upload_message() })
}

shinyApp(ui, server)
