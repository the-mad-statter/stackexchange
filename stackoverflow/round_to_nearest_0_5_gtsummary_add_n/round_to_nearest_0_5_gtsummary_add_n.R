library(gtsummary)

trial[c("trt", "age", "grade", "response")] %>%
  tbl_summary(by = trt) %>%
  add_n(statistic  = "{round(as.integer(n) / 5) * 5}")
