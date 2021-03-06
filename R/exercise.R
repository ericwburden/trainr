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
  comment <- grepl(r"(^#)", file_lines)   # indices of comment lines
  no_arg  <- grepl(r"(`\?`)", file_lines) # indices of lines that contain `?`

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


#' Check to ensure exercise tests have not been altered
#'
#' Compares the tests from the user's modified exercise file to the tests
#' included in the source exercise file. Since the actual tests run are those
#' included in the source file, the results displayed for the user may not
#' match the results they would get if their tests were run.
#'
#' @param file_lines character vector of exercise file lines
#' @param test_lines character vector of original test lines
#'
#' @return a list containing:
#'   - `success`: logical value indicating whether the check succeeded
#'   - `msg`: character value indicating the success/failure message
check_test_integrity <- function(file_lines, test_lines) {
  current_test_lines <- file_lines[is_test(file_lines)]

  if (all(test_lines == current_test_lines)) {
    list(success = TRUE, msg = "Test integrity confirmed!")
  } else {
    warning_msg <- paste(
      "It appears you have altered the tests.",
      "Results may not match the tests displayed on your screen."
    )
    list(success = FALSE, msg = warning_msg)
  }
}


#' Check exercise file tests pass
#'
#' Runs the R code, ensuring all tests pass
#'
#' @param file_lines character vector of exercise file lines
#' @param proj_path path to the project folder, optional
#'
#' @return a list containing:
#'   - `success`: logical value indicating whether the check succeeded
#'   - `msg`: character value indicating the success/failure message
#'   - `output`: character vector of the lines of test output
check_tests <- function(file_lines, proj_path = getwd()) {
  unaltered_test_lines <- original_test_lines(proj_path)
  exercise_code_lines  <- file_lines[!is_test(file_lines)]
  lines_to_test        <- c(exercise_code_lines, unaltered_test_lines)

  output_lines <- testthat::capture_output_lines({
    (parse(text = lines_to_test)
      |> eval()
      |> testthat::capture_error())
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

  # Check that test code has not been altered
  cli::cli_h2("Ensuring test integrity...")
  test_lines <- original_test_lines(proj_path)
  test_integrity_result <- check_test_integrity(file_lines, test_lines)
  if (!test_integrity_result$success) {
    cli::cli_alert_warning(test_integrity_result$msg)
  } else {
    cli::cli_alert_success(test_integrity_result$msg)
  }

  # Check that code passes tests
  cli::cli_h2("Ensuring all tests pass...")
  test_check_result <- check_tests(file_lines)
  if (!test_check_result$success) {
    cli::cli_alert_danger(test_check_result$msg)
    cli::cli_verbatim(test_check_result$output)
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
#' @param test_lines character vector of original test lines
#' @export
#'
#' @return a list containing:
#'   `success` a boolean indicating whether the code was evaluated successfully
#'             and passed all tests
#'   `msg`     a character vector of HTML formatted messages generated while
#'             evaluating the code
check_exercise_shiny <- function(lines, test_lines) {

  msg_lines <- c()
  append_to_msg_lines <- \(x) append(msg_lines, x)

  # Check that all placeholders (`?`) are filled in
  (msg_lines
    <- msg_h2("Ensuring all code has been entered...")
    |> append_to_msg_lines())
  placeholder_check_result <- check_placeholders(lines)
  if (!placeholder_check_result$success) {
    (msg_lines
      <- msg_alert_danger(placeholder_check_result$msg)
      |> append_to_msg())
    return(list(success = FALSE, msg = msg_lines))
  }
  (msg_lines
    <- msg_alert_success(placeholder_check_result$msg)
    |> append_to_msg_lines())

  # Check that test code has not been altered
  msg_lines <- msg_h2("Ensuring test integrity...") |> append_to_msg_lines()
  test_integrity_result <- check_test_integrity(lines, test_lines)
  if (!test_integrity_result$success) {
    (msg_lines
      <- msg_alert_warning(test_integrity_result$msg)
      |> append_to_msg_lines())
  } else {
    (msg_lines
      <- msg_alert_success(test_integrity_result$msg)
      |> append_to_msg_lines())
  }

  # Check that code passes tests
  msg_lines <- msg_h2("Ensuring all tests pass...") |> append_to_msg_lines()
  test_check_result <- check_tests(lines)
  if (!test_check_result$success) {
    # Add the error message
    (msg_lines
      <- msg_alert_danger(test_check_result$msg)
      |> append_to_msg_lines())

    # Add the message from `testthat`
    collapsed_output <- paste(test_check_result$output, collapse = "\n\t")
    msg_lines <- text_to_html(collapsed_output) |> append_to_msg_lines()
    return(list(success = FALSE, msg = msg_lines))
  }
  msg_lines <- msg_alert_success(test_check_result$msg) |> append_to_msg_lines()

  # Helpful info message
  (msg_lines
    <- msg_alert_info("Move on to the next exercise by clicking 'Next'.")
    |> append_to_msg_lines())

  list(success = TRUE, msg = msg_lines)
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
  ex_list      <- readRDS(ex_list_path)
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
#' @return a dataframe containing the exercise listing
#' @include global.R
#' @export
update_current_exercise <- function(proj_path = getwd()) {
  ex_list_path <- glue::glue("{proj_path}/{EX_LIST_FILENAME}")
  ex_list      <- readRDS(ex_list_path)

  # If the current exercise is also completed, make the next exercise current
  if (ex_list[ex_list$current, "completed"]) {
    current_row <- which(ex_list$current)
    ex_list[current_row, "current"]     <- FALSE
    ex_list[current_row + 1, "current"] <- TRUE
  }

  # If no exercises are marked as current, and all the exercises are not
  # marked as completed, set the first exercise as the current one
  if (!any(ex_list$current) & !all(ex_list$completed)) {
    ex_list[1, "current"] <- TRUE
  }

  saveRDS(ex_list, ex_list_path)
  ex_list
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


#' Flag lines that contain test code
#'
#' This function assumes that tests begin with the line containing a 'flag' and
#' continue until the end of the file.
#'
#' @param lines character vector of exercise code lines
#'
#' @return a logical vector indicating which lines contain test code
is_test <- function(lines) {
  tests_flag <- "(require\\(testthat\\))"

  # The line with the tests flag and every line after will be TRUE
  as.logical(cumsum(grepl(tests_flag, lines)))
}


#' Extract test lines from exercise lines
#'
#' @param lines character vector of exercise code lines
#'
#' @return a character vector of lines containing test code
#' @export
get_test_lines <- function(lines) {
  lines[is_test(lines)]
}


#' Get test code from original exercise file
#'
#' Fetches the lines containing test code from the original, unaltered version
#' of the current exercise file. Current exercise file is the one listed in the
#' exercise listing in `proj_path`.
#'
#' @param proj_path path to the project folder, optional
#'
#' @return a character vector containing the test code for the current exercise
original_test_lines <- function(proj_path = getwd()) {
  (lines
    <- get_current_exercise_listing(proj_path)
    |> (\(x) x$path)()
    |> readLines())
  lines[is_test(lines)]
}


