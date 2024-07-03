library(ggplot2)
library(ggstats)
library(scales)

example_data <- data.frame(
  Pre = as.factor(c("Somewhat Familiar","Unfamiliar","Somewhat Familiar",
                    "Somewhat Unfamiliar","Somewhat Familiar","Unfamiliar",
                    "Neither Unfamiliar or Familiar","Unfamiliar",
                    "Neither Unfamiliar or Familiar","Unfamiliar")),
  Post = as.factor(c("Very Familiar",
                     "Very Familiar","Somewhat Familiar",
                     "Very Familiar","Very Familiar","Very Familiar",
                     "Very Familiar","Somewhat Familiar","Very Familiar",
                     "Somewhat Familiar"))
)

gglikert(example_data, add_totals = FALSE) + 
  scale_x_continuous(
    labels = label_percent(), 
    limits = c(-1, 1)
  )
