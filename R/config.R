#' Load the config file
#'
#' @return an object representing package config
load_config <- function() {
  config_file <- system.file("config/config.yml", package = "trainr")
  yaml::read_yaml(config_file)
}


#' Get an option from the config file
#'
#' @param option_name the name of the option to return
#'
#' @return the value of the named config option
config_get <- function(option_name) {
  value <- load_config()[[option_name]]
  if (is.null(value)) stop("No config option named ", option_name)
  value
}


#' Get the path for a local project file
#'
#' Returns the path to a given type of *trainr* project file. Does not check
#' to see if that file exists, does check to be sure the project path is valid.
#'
#' @param proj_path path to the current project folder
#' @param file_type the type of project file, as named in the config
#'
#' @return a file path (character)
project_file_path <- function(proj_path, file_type) {
  if (!dir.exists(proj_path)) stop(proj_path, " is not a valid folder.")

  filename <- config_get(file_type)
  paste0(proj_path, "/", filename)
}


#' Is this path a *trainr* project?
#'
#' If the directory at the path contains both the current exercise metadata and
#' the exercise listings, then it is a *trainr* project folder.
#'
#' @param proj_path path to the potential project folder
#'
#' @return logical path is a *trainr* project path
is_trainr_project <- function(proj_path = getwd()) {
  if (!dir.exists(proj_path)) stop(proj_path, " is not a valid folder.")
  metadata <- project_file_path(proj_path, "current_exercise_metadata")
  exercises <- project_file_path(proj_path, "exercise_listings")
  file.exists(metadata) & file.exists(exercises)
}


#' Fetch the current exercise metadata
#'
#' @param proj_path path to the project folder, optional
#'
#' @return a list representing the current exercise metadata
get_current_metadata <- function(proj_path = getwd()) {
  if (!is_trainr_project(proj_path)) stop(proj_path, " is not a trainr project folder.")
  filepath <- project_file_path(proj_path, "current_exercise_metadata")
  yaml::read_yaml(filepath)
}


#' Write current exercise metadata to file
#'
#' @param proj_path path to the project folder, optional
#' @param metadata current exercise metadata object
#'
#' @return
write_metadata <- function(proj_path = getwd(), metadata) {
  metadata_filepath <- project_file_path(proj_path, "current_exercise_metadata")
  yaml::write_yaml(metadata, metadata_filepath)
}
