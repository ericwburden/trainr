#' Alert the user if their exercise is missing any arguments
#'
#' Exercise files contain a number of `?` markers that should be filled in by
#' the user. R interprets these as variables named `?`, which of course don't
#' exist. Given the lines (as character vectors) of the exercise file, raises
#' an informative error if any of those placeholders aren't filled in.
#'
#' @param file_lines character vector of exercise file lines
#'
#' @return logical there are missing arguments
missing_arguments <- function(file_lines) {
  comment <- grepl(r"(^#)", file_lines)  # indices of comment lines
  no_arg <- grepl(r"(`\?`)", file_lines) # indices of lines that contain `?`

  if (any(!comment & no_arg)) {
    numbered_file_lines <- paste(1:length(file_lines), file_lines, sep = ": ")
    err_msg <- paste0(
      "Missing arguments on the following lines:\n\t",
      paste(numbered_file_lines[!comment & no_arg], collapse = "\n\t")
    )
    cli::cli_alert_danger(err_msg)
    TRUE
  } else {
    FALSE
  }
}


#' Check an exercise file for completion
#'
#' Given the path to an exercise file, checks the file for completion by
#' ensuring all placeholder arguments are filled in and that all tests pass.
#'
#' @param path path to the exercise file
#'
#' @return logical all tests ran successfully
check_exercise <- function(path) {
  if (missing(path)) stop("Must provide a path to the exercise!")

  exercise_file_contents <- readLines(path)

  # Check if all `?` have been completed
  if (!missing_arguments(exercise_file_contents))  {
    eval(parse(path)) # Try to run the contents of the file, triggering tests
  } else {
    FALSE
  }
}


#' Check the current exercise
#'
#' @param proj_path path to the project folder, optional
#'
#' @return NULL
#' @export
check_current_exercise <- function(proj_path = getwd()) {
  if (!is_trainr_project(proj_path)) stop(proj_path, " is not a trainr project folder.")

  cli::cli_h1("Checking current exercise")
  current_exercise_filepath <- project_file_path(proj_path, "current_exercise")

  # If all tests run and pass, alert user
  if (check_exercise(current_exercise_filepath)) {
    cli::cli_alert_success("Exercise completed!")
    complete_current_exercise(proj_path)
    cli::cli_alert_info("Move on to the next exercise using `trainr::next_exercise()`")
    update_exercise_entry(proj_path)
  }
}


#' Mark the current exercise as complete
#'
#' Set the current exercise metadata to indicate the exercise is complete and
#' save the current exercise to the 'completed' folder
#'
#' @param proj_path path to the project folder, optional
#'
#' @return NULL
complete_current_exercise <- function(proj_path = getwd()) {
  current_metadata <- get_current_metadata(proj_path)
  current_metadata[["completed"]] <- TRUE
  write_metadata(proj_path, current_metadata)

  completed_path <- with(
    current_metadata,
    paste("completed", chapter, lesson, exercise, sep = "/")
  )
  completed_dir <- dirname(completed_path)

  current_file_path <- project_file_path(proj_path, "current_exercise")
  dir.create(completed_dir, showWarnings = F, recursive = T)
  file.copy(current_file_path, completed_dir, recursive = T)

  new_file_path <- paste0(completed_dir, "/current_exercise.R")
  file.rename(new_file_path, completed_path)
  cli::cli_alert_info("Completed exercise stored at {completed_path}")
}


#' Advance to the next exercise
#'
#' Checks the `.exercises` listing for the last entry where
#' `completed` == `false`, sets that entry as the current exercise.
#'
#' @param proj_path path to the project folder, optional
#'
#' @return an object representing the current exercise
#' @export
next_exercise <- function(proj_path = getwd()) {
  if (!dir.exists(proj_path)) stop(proj_path, " is not a valid folder.")
  exercise_listing_path <- project_file_path(proj_path, "exercise_listings")
  metadata_path <- project_file_path(proj_path, "current_exercise_metadata")
  current_exercise_filepath <- project_file_path(proj_path, "current_exercise")

  exercise_listing <- readRDS(exercise_listing_path)
  metadata <- as.list(exercise_listing[!exercise_listing$complete,][1,])

  # Copy the latest exercise file to the project folder and write exercise
  # listing to a .yml file
  yaml::write_yaml(metadata, metadata_path)
  file.copy(metadata$path, current_exercise_filepath, overwrite = T)
  metadata
}


#' Update the completed status of the current exercise
#'
#' @param proj_path path to the project folder, optional
#'
#' @return proj_path path to the project folder, optional
update_exercise_entry <- function(proj_path = getwd()) {
  if (!dir.exists(proj_path)) stop(proj_path, " is not a valid folder.")
  exercise_listing_path <- project_file_path(proj_path, "exercise_listings")
  metadata_path <- project_file_path(proj_path, "current_exercise_metadata")

  exercise_listing <- readRDS(exercise_listing_path)
  metadata <- yaml::read_yaml(metadata_path)
  exercise_listing[
    exercise_listing$chapter == metadata$chapter &
      exercise_listing$lesson == metadata$lesson &
      exercise_listing$exercise == metadata$exercise,
    "completed"
  ] <- metadata$completed
  saveRDS(exercise_listing, exercise_listing_path)
  metadata
}


