library(gtExtras)
library(shiny)

ui <- fluidPage(
  includeScript("javascript-color-gradient.js"),
  includeScript("shiny_value_listener.js"),
  gt_output("gt_out")
)

server <- function(input, output) {
  output$gt_out <- render_gt({
    data.frame(x = seq(10, 100, 10)) |> 
      gt() |>
      gt_plt_bar_pct(column = x, labels = TRUE)
  })
}

shinyApp(ui = ui, server = server)
