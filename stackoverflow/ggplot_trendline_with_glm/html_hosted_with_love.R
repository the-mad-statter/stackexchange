html_hosted_with_love <- function(href, host = "GitHub") {
  clipr::write_clip(sprintf('<sup>Reprex files hosted with <img src="https://i.sstatic.net/Z4PR2H0m.png" height="24" /> on <a href="%s">%s</a></sup>', href, host))
  message("copied to clipboard")
}
