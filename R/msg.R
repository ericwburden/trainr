#' Replace console color codes in text with styled spans
#'
#' The current replacements are:
#' - \033[1m  -> '<span style = "font-weight: bold;">'
#' - \033[32m -> '<span style = "color: limegreen">'
#' - \033[33m -> '<span style = "color: crimson">'
#' - \033[90m -> '<span style = "color: darkslategray">'
#' - \033[39m -> '</span>'
#' - \033[22m -> '</span>'
#'
#' @param lines lines of text to make replacements in
#'
#' @return lines of text with replacements made
text_to_html <- function(lines) {
  lines <- stringr::str_replace_all(lines, "\n", "</br>")
  lines <- stringr::str_replace_all(lines, "\t", "&nbsp;&nbsp;&nbsp;&nbsp;")
  lines <- stringr::str_replace_all(
    lines, "\\033\\[1m", "<span style = \"font-weight: bold;\">"
  )
  lines <- stringr::str_replace_all(
    lines, "\\033\\[32m", "<span style = \"color: limegreen;\">"
  )
  lines <- stringr::str_replace_all(
    lines, "\\033\\[33m", "<span style = \"color: crimson;\">"
  )
  lines <- stringr::str_replace_all(
    lines, "\\033\\[90m", "<span style = \"color: darkslategray;\">"
  )
  lines <- stringr::str_replace_all(lines, "\\033\\[39m", "</span>")
  lines <- stringr::str_replace_all(lines, "\\033\\[22m", "</span>")
  lines <- stringr::str_replace_all(lines, "<text>", "line")
  lines
}

#' Message Headings
#'
#' Outputs a message with the specified heading format
#'
#' @param msg text of the heading
#' @param out.width width of the output line, in characters
#'
#' @return NULL
msg_h1 <- function(msg, out.width = 90) {
  pre <- "──"
  post <- paste(rep("─", out.width - 4 - nchar(msg)), collapse = "")
  style <- "style=\"color: dodgerblue\""
  msg <- text_to_html(msg)
  message(glue::glue("<span {style}>{pre} {msg} {post}</span>"))
}



#' Message Headings
#'
#' Outputs a message with the specified heading format
#'
#' @param msg text of the heading
#'
#' @return NULL
msg_h2 <- function(msg) {
  pre <- "──"
  post <- "──"
  style <- "style=\"color: lightskyblue\""
  msg <- text_to_html(msg)
  message(glue::glue("<span {style}>{pre} {msg} {post}</span>"))
}


#' Message Alerts
#'
#' Displays a short status message with HTML formatting
#'
#' @param msg text of the message
#'
#' @return NULL
msg_alert_danger <- function(msg) {
  pre <- "\u2718"
  style <- "style=\"color: crimson\""
  msg <- text_to_html(msg)
  message(glue::glue("<span {style}>{pre} {msg}</span>"))
}


#' Message Alerts
#'
#' Displays a short status message with HTML formatting
#'
#' @param msg text of the message
#'
#' @return NULL
msg_alert_success <- function(msg) {
  pre <- "\u2714"
  style <- "style=\"color: limegreen\""
  msg <- text_to_html(msg)
  message(glue::glue("<span {style}>{pre} {msg}</span>"))
}


#' Message Alerts
#'
#' Displays a short status message with HTML formatting
#'
#' @param msg text of the message
#'
#' @return NULL
msg_alert_info <- function(msg) {
  pre <- "\u24d8"
  style <- "style=\"color: skyblue\""
  msg <- text_to_html(msg)
  message(glue::glue("<span {style}>{pre} {msg}</span>"))
}
