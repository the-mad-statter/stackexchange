#' HTML footer that describes where reprex files are hosted
#'
#' @param x link to GitHub page with reprex files
#' @param host host of reprex files
#'
#' @return html code invisibly
reprex_file_html_footer <- function(x = clipr::read_clip(), host = "GitHub") {
  heart_html <- '<img src="https://i.sstatic.net/Z4PR2H0m.png" height="14" />'
  fmt <- '<sub>Reprex files hosted with %s on <a href="%s">%s</a></sub>'
  html_footer <- sprintf(fmt, heart_html, x, host)
  
  clipr::write_clip(html_footer)
  message("HTML footer is on the clipboard.")
  
  temp_file <- tempfile(fileext = ".html")
  writeLines(html_footer, temp_file)
  rstudioapi::viewer(temp_file)
  
  invisible(html_footer)
}
