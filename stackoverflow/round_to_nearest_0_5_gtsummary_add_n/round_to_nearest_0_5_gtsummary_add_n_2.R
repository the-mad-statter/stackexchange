library(gtsummary)

# function to generate style-functions
style_round_any <- function(accuracy, is_p = FALSE) {
  function(x) {
    if(is_p)
      x <- 100 * x
    
    ceiling(x / accuracy) * accuracy
  }
}

# generate function to style n
style_n <- style_round_any(5)

# generate function to style p
style_p <- style_round_any(2, is_p = TRUE)

# vector of styling functions for n and p
style_n_p <- c(style_n, style_p)

df <- structure(list(id = 1:100, age = c("a", "a", "b", "a", "b", "b", 
                                         "b", "c", "c", "c", "a", "a", "b", "a", "b", "b", "b", "c", "c", 
                                         "c", "a", "a", "b", "a", "b", "b", "b", "c", "c", "c", "a", "a", 
                                         "b", "a", "b", "b", "b", "c", "c", "c", "a", "a", "b", "a", "b", 
                                         "b", "b", "c", "c", "c", "a", "a", "b", "a", "b", "b", "b", "c", 
                                         "c", "c", "a", "a", "b", "a", "b", "b", "b", "c", "c", "c", "a", 
                                         "a", "b", "a", "b", "b", "b", "c", "c", "c", "a", "a", "b", "a", 
                                         "b", "b", "b", "c", "c", "c", "a", "a", "b", "a", "b", "b", "b", 
                                         "c", "c", "c"), sex = c("M", "F", "M", "M", "M", "F", "F", "F", 
                                                                 "F", "M", "F", "M", "M", "M", "F", "F", "F", "F", "M", "F", "M", 
                                                                 "M", "M", "F", "F", "F", "F", "M", "F", "M", "M", "M", "F", "F", 
                                                                 "F", "F", "M", "F", "M", "M", "M", "F", "F", "F", "F", "M", "F", 
                                                                 "M", "M", "M", "F", "F", "F", "F", "M", "F", "M", "M", "M", "F", 
                                                                 "F", "F", "F", "M", "F", "M", "M", "M", "F", "F", "F", "F", "M", 
                                                                 "M", "F", "F", "F", "F", "M", "F", "M", "M", "M", "F", "F", "F", 
                                                                 "F", "M", "M", "F", "F", "F", "F", "M", "F", "M", "M", "M", "F", 
                                                                 "F"), country = c("eng", "eng", "eng", "eng", "wale", "wale", 
                                                                                   "wale", "scot", "scot", "scot", "eng", "eng", "eng", "eng", "wale", 
                                                                                   "wale", "wale", "scot", "scot", "scot", "eng", "eng", "eng", 
                                                                                   "eng", "wale", "wale", "wale", "scot", "scot", "scot", "eng", 
                                                                                   "eng", "eng", "eng", "wale", "wale", "wale", "scot", "scot", 
                                                                                   "scot", "eng", "eng", "eng", "eng", "wale", "wale", "wale", "scot", 
                                                                                   "scot", "scot", "eng", "eng", "eng", "eng", "wale", "wale", "wale", 
                                                                                   "scot", "scot", "scot", "eng", "eng", "eng", "eng", "wale", "wale", 
                                                                                   "wale", "scot", "scot", "scot", "eng", "eng", "eng", "eng", "wale", 
                                                                                   "wale", "wale", "scot", "scot", "scot", "eng", "eng", "eng", 
                                                                                   "eng", "wale", "wale", "wale", "scot", "scot", "scot", "eng", 
                                                                                   "eng", "eng", "eng", "wale", "wale", "wale", "scot", "scot", 
                                                                                   "scot"), edu = c("x", "x", "x", "y", "y", "y", "z", "z", "z", 
                                                                                                    "z", "x", "x", "x", "y", "y", "y", "z", "z", "z", "z", "x", "x", 
                                                                                                    "x", "y", "y", "y", "z", "z", "z", "z", "x", "x", "x", "y", "y", 
                                                                                                    "y", "z", "z", "z", "z", "x", "x", "x", "y", "y", "y", "z", "z", 
                                                                                                    "z", "z", "x", "x", "x", "y", "y", "y", "z", "z", "z", "z", "x", 
                                                                                                    "x", "x", "y", "y", "y", "z", "z", "z", "z", "x", "x", "x", "y", 
                                                                                                    "y", "y", "z", "z", "z", "z", "x", "x", "x", "y", "y", "y", "z", 
                                                                                                    "z", "z", "z", "x", "x", "x", "y", "y", "y", "z", "z", "z", "z"
                                                                                   ), hba1c = c(1L, 1L, 1L, 1L, 1L, 1L, NA, NA, NA, 1L, 1L, 0L, 
                                                                                                0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, NA, NA, NA, NA, NA, NA, 
                                                                                                0L, 0L, 0L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 
                                                                                                1L, 1L, 1L, 1L, 1L, 1L, NA, NA, NA, NA, NA, NA, NA, NA, 0L, 0L, 
                                                                                                0L, 0L, 0L, 0L, 0L, 1L, 0L, 0L, 0L, 0L, 0L, 1L, 0L, 0L, 1L, 0L, 
                                                                                                0L, 0L, 1L, 0L, 0L, 0L, 0L, 1L, 1L, 1L, 0L, 1L, 1L, 1L, 0L, 1L, 
                                                                                                NA, NA, NA, NA, NA, 1L, 1L, 1L)), class = "data.frame", row.names = c(NA, 
                                                                                                                                                                      -100L))

df %>% 
  tbl_summary(
    by = hba1c,
    include = -id,
    digits = 
      list(
        # Example 1
        # - no specification for age
        # - allow tbl_summary to guess an appropriate number of decimals to round n and p
        #   - n will be rounded to 0 decimal places
        #   - p will be rounded to 0 decimal places
        # Example 2
        # - supply a vector of decimal places for n and p
        #   - n will be rounded to 1 decimal place
        #   - p will be rounded to 2 decimal places
        sex ~ c(1, 2),
        # Example 3
        # - user may also pass styling functions
        # - Example 3A
        #   - pass a vector of styling functions for n and p respectively
        #     - n will be rounded to the nearest 8
        #     - p will be rounded to the nearest 10
        country ~ c(style_round_any(8), style_round_any(10, is_p = TRUE)),
        # - Example 3B
        #   - pass a vector of styling functions for n and p respectively
        #     - n will be rounded to the nearest 5
        #     - p will be rounded to the nearst 2
        edu ~ c(style_n, style_p)
      )
  ) %>% 
  add_p(pvalue_fun = ~ style_pvalue(.x, digits = 2)) %>%
  add_overall(
    digits = list(
      # Example 4
      # - use all_categorical() to override all digits specficiations in tbl_summary()
      #   - all n will be rounded to the nearest 5 in overall column for all variables
      #   - all p will be rounded to the nearest 2 in overall column for all variables
      all_categorical() ~ style_n_p
    )
  ) %>%
  add_n(
    # Example 5
    # - a way to round the last digit to 0 or 5 in n column from add_n()
    statistic = "{round(as.integer(n) / 5) * 5}"
  )
