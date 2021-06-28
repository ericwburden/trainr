#' Check an exercise for missing arguments
#'
#' Exercise files contain a number of `?` markers that should be filled in by
#' the user. R interprets these as variables named `?`, which of course don't
#' exist. Given the lines (as character vectors) of the exercise file, raises
#' an informative error if any of those placeholders aren't filled in.
#'
#' @param file_lines character vector of exercise file lines
#'
#' @return a list containing:
#'   - `success`: logical value indicating whether the check succeeded
#'   - `msg`: character value indicating the success/failure message
check_placeholders <- function(file_lines) {
  comment <- grepl(r"(^#)", file_lines)  # indices of comment lines
  no_arg <- grepl(r"(`\?`)", file_lines) # indices of lines that contain `?`

  if (any(!comment & no_arg)) {
    numbered_file_lines <- paste(1:length(file_lines), file_lines, sep = ": ")
    err_msg <- paste0(
      "Missing arguments on the following lines:\n\t",
      paste(numbered_file_lines[!comment & no_arg], collapse = "\n\t")
    )
    list(success = FALSE, msg = err_msg)
  } else {
    list(success = TRUE, msg = "All placeholders filled in!")
  }
}


#' Check exercise file tests pass
#'
#' Runs the R code, ensuring all tests pass
#'
#' @param file_lines character vector of exercise file lines
#'
#' @return a list containing:
#'   - `success`: logical value indicating whether the check succeeded
#'   - `msg`: character value indicating the success/failure message
#'   - `output`: character vector of the lines of test output
check_tests <- function(file_lines) {
  output_lines <- testthat::capture_output_lines({
    eval(parse(text = file_lines))
  })
  tests_passed <- any(stringr::str_detect(output_lines, r"(Tests? passed)"))
  if (tests_passed) {
    list(success = TRUE, msg = "Exercise completed!", output = output_lines)
  } else {
    list(success = FALSE, msg = "One or more tests failed!", output = output_lines)
  }
}


#' Check a local exercise file for completed exercise
#'
#' This version of the file check is completed when the trainr project type is
#' "rstudio". Checks the "current_exercise.R" file for completion and outputs
#' messages to the console via the `cli` package.
#'
#' @param proj_path path to the project folder, optional
#'
#' @return a logical value, indicating whether the file passed all checks
#' @include global.R
check_exercise_rstudio <- function(proj_path = getwd()) {
  current_exercise_file_path <- glue::glue("{proj_path}/{EXERCISE_FILENAME}")
  file_lines <- readLines(current_exercise_file_path)

  cli::cli_h1("Checking current exercise...")

  # Check that all placeholders (`?`) are filled in
  cli::cli_h2("Ensuring all code has been entered...")
  placeholder_check_result <- check_placeholders(file_lines)
  if (!placeholder_check_result$success) {
    cli::cli_alert_danger(placeholder_check_result$msg)
    return(FALSE)
  }
  cli::cli_alert_success(placeholder_check_result$msg)

  # Check that code passes tests
  cli::cli_h2("Ensuring all tests pass...")
  test_check_result <- check_tests(file_lines)
  cli::cli_text(test_check_result$output)
  if (!test_check_result$success) {
    cli::cli_alert_danger(test_check_result$msg)
    return(FALSE)
  }
  cli::cli_alert_success(test_check_result$msg)

  # Helpful info message
  cli::cli_alert_info("Move on to the next exercise using `trainr::next_exercise()`")
  save_completed_exercise_file(proj_path)
  mark_current_exercise_complete(proj_path)

  TRUE
}


#' Check code lines for completed exercise in Shiny application
#'
#' This version of the file check is completed when the trainr project type is
#' "shiny". Checks the lines passed in as R code and outputs the results as
#' `message()`s, with `<span>`s for HTML formatting.
#'
#' @param lines character vector of exercise code lines
#' @export
#'
#' @return a logical value, indicating whether the file passed all checks
check_exercise_shiny <- function(lines) {

  msg_h1("Checking current exercise...")

  # Check that all placeholders (`?`) are filled in
  msg_h2("Ensuring all code has been entered...")
  placeholder_check_result <- check_placeholders(lines)
  if (!placeholder_check_result$success) {
    msg_alert_danger(placeholder_check_result$msg)
    return(FALSE)
  }
  msg_alert_success(placeholder_check_result$msg)

  # Check that code passes tests
  msg_h2("Ensuring all tests pass...")
  test_check_result <- check_tests(lines)
  collapsed_output <- paste(test_check_result$output, collapse = "\n\t")
  message(text_to_html(collapsed_output))
  if (!test_check_result$success) {
    msg_alert_danger(test_check_result$msg)
    return(FALSE)
  }
  msg_alert_success(test_check_result$msg)

  # Helpful info message
  msg_alert_info("Move on to the next exercise by clicking 'Next'.")

  TRUE
}


#' Save current exercise to 'completed' folder
#'
#' Maintains a folder of completed exercises, copies the currently completed
#' exercise file into the completed folder.
#'
#' @param proj_path path to the project folder, optional
#'
#' @return NULL
#' @include global.R
save_completed_exercise_file <- function(proj_path = getwd()) {
  metadata <- get_current_exercise_listing(proj_path)
  completed_path <- with(
    metadata,
    paste("completed", chapter, lesson, exercise, sep = "/")
  )
  completed_dir <- dirname(completed_path)

  # Copy 'current_exercise.R' to the destination folder
  current_file_path <- glue::glue("{proj_path}/{EXERCISE_FILENAME}")
  dir.create(completed_dir, showWarnings = F, recursive = T)
  file.copy(current_file_path, completed_dir, recursive = T)

  # Rename 'current_exercise.R' in the destination folder
  new_file_path <- glue::glue("{completed_dir}/{EXERCISE_FILENAME}")
  file.rename(new_file_path, completed_path)
  cli::cli_alert_info("Completed exercise stored at {completed_path}")
}


#' Update the completed status of the current exercise
#'
#' @param proj_path path to the project folder, optional
#'
#' @return NULL
#' @include global.R
#' @export
mark_current_exercise_complete <- function(proj_path = getwd()) {
  ex_list_path <- glue::glue("{proj_path}/{EX_LIST_FILENAME}")
  ex_list <- readRDS(ex_list_path)
  ex_list[ex_list$current, "completed"] <- TRUE
  saveRDS(ex_list, ex_list_path)
}


#' Update the current exercise
#'
#' If the current exercise has been completed, mark the next exercise in sequence
#' as the current exercise.
#'
#' @param proj_path
#'
#' @return NULL
#' @include global.R
#' @export
update_current_exercise <- function(proj_path = getwd()) {
  ex_list_path <- glue::glue("{proj_path}/{EX_LIST_FILENAME}")
  ex_list <- readRDS(ex_list_path)

  if (ex_list[ex_list$current, "completed"]) {
    current_row <- which(ex_list$current)
    ex_list[current_row, "current"] <- FALSE
    ex_list[current_row + 1, "current"] <- TRUE
  }

  saveRDS(ex_list, ex_list_path)
}


#' Advance to the next exercise file
#'
#' Updates (creates) the current exercise file to be the current exercise
#' in the exercise listing
#'
#' @param proj_path path to the project folder, optional
#'
#' @return an object representing the current exercise
#' @include global.R
#' @export
next_exercise <- function(proj_path = getwd()) {
  current_file_path <- glue::glue("{proj_path}/{EXERCISE_FILENAME}")
  update_current_exercise(proj_path) # Move on if current is complete
  metadata <- get_current_exercise_listing(proj_path)
  file.copy(metadata$path, current_file_path, overwrite = T)
}


#' Fetch the contents of the current exercise file
#'
#' @param proj_path path to the project folder, optional
#'
#' @return (unmodified) lines from the current exercise
#' @export
current_exercise_lines <- function(proj_path = getwd()) {
  metadata <- get_current_exercise_listing(proj_path)
  readLines(metadata$path)
}


