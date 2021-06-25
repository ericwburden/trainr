test_that("Can setup a new trainr project in an empty directory", {
  proj_path <- tempdir()
  setup_dir(proj_path)

  # These files should exist
  metadata_file_path <- paste0(proj_path, "/.metadata")
  exercises_file_path <- paste0(proj_path, "/.exercises")
  current_file_path <- paste0(proj_path, "/current_exercise.R")

  expect_true(file.exists(metadata_file_path))
  expect_true(file.exists(exercises_file_path))
  expect_true(file.exists(current_file_path))

  # The exercises file should have `completed == FALSE` for all entries
  exercises <- readRDS(exercises_file_path)
  expect_false(any(exercises$completed))

  # The metadata file should parse to a list with the same names as
  # the exercises listing
  metadata <- yaml::read_yaml(metadata_file_path)
  expect_setequal(names(exercises), names(metadata))

  # Cleanup
  unlink(proj_path, recursive = T, force = T)
})
