library(shiny)

ui <- fluidPage(
  tags$head(
    tags$script("
      let myTimeout;
    
      function changeBackgroundColor(color1, interval1, color2, interval2, elementId) {
        let isColor1 = true;
        
        function updateColor() {          
          const element = document.getElementById(elementId);
          
          element.style.backgroundColor = isColor1 ? color1 : color2;
          isColor1 = !isColor1;
          
          myTimeout = setTimeout(updateColor, isColor1 ? interval2 : interval1);
        }

        clearTimeout(myTimeout);

        updateColor();
      };
    
      Shiny.addCustomMessageHandler('runLight', function(x) {
        changeBackgroundColor(x.color1, x.interval1, x.color2, x.interval2, x.element);
      });
    ")
  ),
  sidebarLayout(
    sidebarPanel(
      numericInput("green_time", "Dauer der Grünphase (Sekunden):", value = 1, min = 1),
      numericInput("red_time", "Dauer der Rotphase (Sekunden):", value = 2, min = 1),
      actionButton("start", "Starten")
    ),
    mainPanel(
      tags$div(
        id = "traffic_light",
        style = "width: 100px; height: 200px; border-radius: 10px; background-color: green;"
      )
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$start, {
    msg <- list(
      color1 = "green", 
      interval1 = 1000 * input$green_time, 
      color2 = "red", 
      interval2 = 1000 * input$red_time, 
      element = "traffic_light"
    )
    
    session$sendCustomMessage("runLight", msg)
  })
}

shinyApp(ui, server)
