#' Setup a trainr project
#'
#' @param path path to the new project directory
#'
#' @return NULL
#' @export
setup_dir <- function(proj_path) {
  # ensure project path exists
  dir.create(proj_path, recursive = TRUE, showWarnings = FALSE)

  # Create a data object to keep track of completed exercises
  exercise_listing_path <- update_exercise_listing(proj_path)
  exercise_listing <- next_exercise(proj_path)

  # Append `library(trainer)` to .Rprofile
  setup_rprofile(proj_path)
}



#' Setup .Rprofile file
#'
#' We want to load `trainr` and update the exercise listing on project open
#'
#' @param proj_path
#'
#' @return NULL
setup_rprofile <- function(proj_path) {
  rprofile <- paste0(proj_path, "/.Rprofile")
  if (!file.exists(rprofile)) file.create(rprofile)
  rprofile_file <- file(rprofile, open = "a+")
  contents <- readLines(rprofile_file)

  # If the `trainr` bits haven't already been written
  if (!any(grepl("trainr", contents))) {
    cat("library(trainr)\n", file = rprofile_file)
    cat("trainr::update_exercise_listing(getwd())\n", file = rprofile_file)
  }

  close(rprofile_file)
}


#' Makes an entry for the exercise listing
#'
#' Given a `split_path` and the `full_path` for an exercise, return a single
#' row dataframe containing an exercise listing entry for that exercise.
#'
#' @param split_path a length-3 character vector containing the chapter name,
#' lesson name, and exercise name for an exercise, in that order
#' @param full_path the full path to an exercise file
#'
#' @return a one-row dataframe containing `chapter`, `lesson`, `exercise`,
#' `path`, and `completed`
exercise_path_to_entry <- function(split_path, full_path) {
  data.frame(
    chapter = split_path[1],
    lesson = split_path[2],
    exercise = split_path[3],
    path = full_path,
    completed = FALSE
  )
}


#' Generate a fresh exercise listing
#'
#' Each listing entry contains the `chapter` name, `lesson` name,
#' `exercise` name, `path` to the exercise file, and a boolean indicating if
#' that exercise has been `completed`. Generated from the contents of the
#' 'inst/lessons' folder.
#'
#' @return a dataframe including an entry for each exercise
new_exercise_listing <- function() {
  # Get the package 'lessons' folder and paths to all exercises
  lesson_dir <- system.file("lessons", package = "trainr")
  exercise_paths <- list.files(lesson_dir, full.names = T, recursive = T)

  # Extract out the final '<chapter name>/<lesson name>/<exercise name>.R' bit
  regex_captures <- regexpr(r"((?<=lessons\/).*$)", exercise_paths, perl = T)
  lesson_paths <- regmatches(exercise_paths, regex_captures)
  split_lesson_paths <- strsplit(lesson_paths, "/")

  # Convert each path to an exercise file into a named list
  entries <- mapply(
    exercise_path_to_entry,
    split_lesson_paths,
    exercise_paths,
    SIMPLIFY = F
  )
  Reduce(rbind, entries) # Combine into a single dataframe
}


#' Create a new exercise listing if none exists, otherwise update the
#' existing listing with the package file structure
#'
#' @param proj_path path to create the exercise listing in
#'
#' @return path to the exercise listing
#' @export
update_exercise_listing <- function(proj_path) {
  if (!dir.exists(proj_path)) stop(proj_path, " is not a valid folder.")
  exercise_listing_path <- project_file_path(proj_path, "exercise_listings")

  new_exercise_listing <- new_exercise_listing()
  if (!file.exists(exercise_listing_path)) {
    saveRDS(new_exercise_listing, exercise_listing_path)
  } else {
    # If the file exists, merge with the new listing with the following rules
    # - The new `path` should replace the old `path`
    # - If the old `completed` is TRUE, then `completed` should be TRUE, otherwise
    #   it should be FALSE
    old_exercise_listing <- readRDS(exercise_listing_path)
    merged_listing <- merge(
      old_exercise_listing,
      new_exercise_listing,
      by = c("chapter", "lesson", "exercise"),
      all = T
    )
    merged_listing$path <- merged_listing$path.y
    merged_listing$completed <- ifelse(
      is.na(merged_listing$completed.x),
      FALSE,
      merged_listing$completed.x
    )
    merged_listing <- subset(
      merged_listing,
      select = c("chapter", "lesson", "exercise", "path", "completed")
    )
    saveRDS(merged_listing, exercise_listing_path)
  }

  exercise_listing_path
}

