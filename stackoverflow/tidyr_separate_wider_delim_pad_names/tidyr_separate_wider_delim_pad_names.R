library(tidyr)

data.frame(
  Group = c("A","B","C"),
  fruits_selected = c(
    "'Apple'+'Banana'+'Cherry'",
    "'Peach'+'Banana'+'Apple'",
    "'Orange'+'Banana'+'Cherry'"
  )
) %>%
  separate_wider_delim(
    fruits_selected, 
    delim = "+", 
    names_sep = "_",
    names_repair = ~ sub("fruits_selected_(\\d)", "fruits_selected_0\\1", .)
  )
