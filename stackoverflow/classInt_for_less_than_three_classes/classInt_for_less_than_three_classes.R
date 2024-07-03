library(classInt)

data <- data.frame(
  country = c('Australia', 'Italy', 'Peru', 'China','Australia', 'Italy', 'Peru', 'China','Australia', 'Italy', 'Peru', 'China','Nigeria','Australia', 'Italy', 'Peru', 'China'), 
  time = c(21, 18, 17, 10, 10, 15, 27, 0, 2, 4, 5, 7, 4, 8, 9, 10, 5), 
  area = c("A", "A", "A", "A", "B", "B", "B", "B", "C", "C", "C", "C", "D", "D", "D", "D", "D")
)

split_data <- split(data, data$country)

result <- list()

for (i in 1:length(split_data)) {
  split <- split_data[[i]]
  
  if(nrow(split) == 1) {
    levels <- c(-1, split$time)
    labels <- sprintf("[%s]", levels)
    split$range_abs = factor(split$time, levels, labels)
    split$class_abs = as.numeric(split$range_abs)
  } else if(nrow(split) == 2) {
    levels <- sort(split$time)
    labels <- sprintf("[%s]", levels)
    split$range_abs = factor(split$time, levels, labels)
    split$class_abs = as.numeric(split$range_abs)
  } else {
    skip_to_next <- FALSE
    
    tryCatch(
      Classes <- classIntervals(
        split$time, 
        n = 5, 
        cutlabels = FALSE,
        style = 'fisher',
        factor = FALSE,
        warnSmallN = FALSE,
        warnLargeN = FALSE
      ), 
      error = function(e) { 
        skip_to_next <<- TRUE
      }
    )
    
    if(skip_to_next) { next } 
    
    split$range_abs <- classify_intervals(split$time, 3, "fisher", factor = TRUE)
    split$class_abs <- classify_intervals(split$time, 3, "fisher", factor = FALSE)
  }
  
  result[[i]] <- split
}

result