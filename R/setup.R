#' Setup a `trainr` project
#'
#' @param proj_path path to the new project directory
#'
#' @return NULL
#' @export
setup_dir <- function(proj_path, type = c("minimal", "rstudio", "shiny")) {
  type <- match.arg(type)

  # ensure project path exists
  dir.create(proj_path, recursive = TRUE, showWarnings = FALSE)

  # The bare minimum setup
  config <- list(type = type)
  write_config_file(proj_path, config)
  write_exercise_listing(proj_path)

  # RStudio project-specific setup
  if (type == "rstudio") {
    # Write the current exercise file
    write_current_exercise_file(proj_path)
    write_rprofile(proj_path)
  }
}


#' Function stub for creating a new RStudio project
#'
#' @param proj_path path to the new project directory
#'
#' @return NULL
#' @export
setup_rstudio_dir <- function(proj_path) {
  setup_dir(proj_path, "rstudio")
}


#' Write `trainr` config to config file
#'
#' @param proj_path path to the new project directory
#' @param config list of config options
#'
#' @return NULL
#' @include global.R
write_config_file <- function(proj_path, config) {
  config_file_path <- glue::glue("{proj_path}/{CONFIG_FILENAME}")
  yaml::write_yaml(config, config_file_path)
}


#' Write a new exercise listing file
#'
#' @param proj_path path to the new project directory
#'
#' @return NULL
#' @include global.R
write_exercise_listing <- function(proj_path) {
  ex_list_path <- glue::glue("{proj_path}/{EX_LIST_FILENAME}")
  ex_list <- generate_exercise_listing()
  saveRDS(ex_list, ex_list_path)
}


#' Copy the first exercise to current exercise file
#'
#' @param proj_path path to the new project directory
#'
#' @return NULL
#' @include global.R
write_current_exercise_file <- function(proj_path) {
  ex_list_path <- glue::glue("{proj_path}/{EX_LIST_FILENAME}")
  ex_list <- readRDS(ex_list_path)
  first_exercise_path <- ex_list[1,"path"]

  curr_exercise_path <- glue::glue("{proj_path}/{EXERCISE_FILENAME}")
  file.copy(first_exercise_path, curr_exercise_path, overwrite = T)
}


#' Setup .Rprofile file
#'
#' We want to load `trainr` and update the exercise listing on project open
#'
#' @param proj_path
#'
#' @return NULL
write_rprofile <- function(proj_path) {
  rprofile <- glue::glue("{proj_path}/.Rprofile")
  if (!file.exists(rprofile)) file.create(rprofile)
  rprofile_file <- file(rprofile, open = "a")
  cat("library(trainr)\n", file = rprofile_file)
  cat(
    glue::glue("trainr::update_exercise_listing({proj_path})\n"),
    file = rprofile_file
  )
  close(rprofile_file)
}

