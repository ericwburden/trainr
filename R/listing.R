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
    completed = FALSE,
    current = FALSE
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
generate_exercise_listing <- function() {
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


#' Get the listing for the current exercise
#'
#' @param proj_path path to the project folder, optional
#'
#' @return a named list containing an exercise listing
#' @include global.R
get_current_exercise_listing <- function(proj_path = getwd()) {
  ex_list_path <- glue::glue("{proj_path}/{EX_LIST_FILENAME}")
  ex_list <- readRDS(ex_list_path)
  as.list(ex_list[ex_list$current,])
}


#' Create a new exercise listing if none exists, otherwise update the
#' existing listing with the package file structure
#'
#' @param proj_path path to create the exercise listing in
#'
#' @return path to the exercise listing
#' @include global.R
#' @export
update_exercise_listing <- function(proj_path = getwd()) {
  ex_list_path <- glue::glue("{proj_path}/{EX_LIST_FILENAME}")
  new_ex_list <- generate_exercise_listing()

  if (!file.exists(ex_list_path)) {
    saveRDS(new_ex_list, ex_list_path)
  } else {
    # If the file exists, merge with the new listing with the following rules
    # - The new `path` should replace the old `path`
    # - If the old `completed` is TRUE, then `completed` should be TRUE, otherwise
    #   it should be FALSE
    old_ex_list <- readRDS(ex_list_path)
    merged_ex_list <- merge(
      old_ex_list, new_ex_list,
      by = c("chapter", "lesson", "exercise"),
      all = T
    )
    merged_ex_list$path <- merged_ex_list$path.y
    merged_ex_list$completed <- ifelse(
      is.na(merged_ex_list$completed.x),
      FALSE,
      merged_ex_list$completed.x
    )
    merged_ex_list <- subset(
      merged_ex_list,
      select = c("chapter", "lesson", "exercise", "path", "completed")
    )
    saveRDS(merged_ex_list, ex_list_path)
  }

  ex_list_path
}
