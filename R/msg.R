# Define colors used here

green   <- "#859900"
blue    <- "#268bd2"
cyan    <- "#2aa198"
violet  <- "#6c71c4"
magenta <- "#d33682"
red     <- "#d30102"
orange  <- "#cb4b16"
yellow  <- "#b58900"


#' Replace console color codes in text with styled spans
#'
#' The current replacements are:
#' - \033[1m  -> '<span style = "font-weight: bold;">'
#' - \033[32m -> '<span style = "color: green">'
#' - \033[33m -> '<span style = "color: red">'
#' - \033[90m -> '<span style = "color: magenta">'
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
    lines, "\\033\\[32m", glue::glue("<span style = \"color: {green};\">")
  )
  lines <- stringr::str_replace_all(
    lines, "\\033\\[33m", glue::glue("<span style = \"color: {red};\">")
  )
  lines <- stringr::str_replace_all(
    lines, "\\033\\[90m", glue::glue("<span style = \"color: {magenta};\">")
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
#' @return an HTML formatted message
msg_h1 <- function(msg) {
  pre   <- "──"
  post  <- "──────────────────"
  style <- glue::glue("style=\"color:{blue}; font-weight:bold; font-size:1.65rem;\"")
  msg   <- text_to_html(msg)
  glue::glue("<span {style}>{pre} {msg} {post}</span>")
}



#' Message Headings
#'
#' Outputs a message with the specified heading format
#'
#' @param msg text of the heading
#'
#' @return an HTML formatted message
msg_h2 <- function(msg) {
  pre   <- "──"
  post  <- "──"
  style <- glue::glue("style=\"color: {yellow}; font-weight:bold;\"")
  msg   <- text_to_html(msg)
  glue::glue("<span {style}>{pre} {msg} {post}</span>")
}


#' Message Alerts
#'
#' Displays a short status message with HTML formatting
#'
#' @param msg text of the message
#'
#' @return an HTML formatted message
msg_alert_danger <- function(msg) {
  pre   <- "\u2718"
  style <- glue::glue("style=\"color: {red}\"")
  msg   <- text_to_html(msg)
  glue::glue("<span {style}>{pre} {msg}</span>")
}


#' Message Alerts
#'
#' Displays a short status message with HTML formatting
#'
#' @param msg text of the message
#'
#' @return an HTML formatted message
msg_alert_success <- function(msg) {
  pre   <- "\u2714"
  style <- glue::glue("style=\"color: {green}\"")
  msg   <- text_to_html(msg)
  glue::glue("<span {style}>{pre} {msg}</span>")
}


#' Message Alerts
#'
#' Displays a short status message with HTML formatting
#'
#' @param msg text of the message
#'
#' @return an HTML formatted message
msg_alert_info <- function(msg) {
  pre   <- "\u24d8"
  style <- glue::glue("style=\"color: {cyan}\"")
  msg   <- text_to_html(msg)
  glue::glue("<span {style}>{pre} {msg}</span>")
}


#' Message Alerts
#'
#' Displays a short status message with HTML formatting
#'
#' @param msg text of the message
#'
#' @return an HTML formatted message
msg_alert_warning <- function(msg) {
  pre   <- "\u203C"
  style <- glue::glue("style=\"color: {yellow}\"")
  msg   <- text_to_html(msg)
  glue::glue("<span {style}>{pre} {msg}</span>")
}
