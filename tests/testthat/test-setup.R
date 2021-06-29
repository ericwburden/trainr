test_that("Can setup a 'minimal' project in an empty directory", {
  proj_path <- tempdir()
  setup_dir(proj_path, type = 'minimal')

  # These files should exist
  config_file_path <- glue::glue("{proj_path}/{CONFIG_FILENAME}")
  ex_list_path <- glue::glue("{proj_path}/{EX_LIST_FILENAME}")

  expect_true(file.exists(config_file_path))
  expect_true(file.exists(ex_list_path))

  # The exercises file should have `completed == FALSE` for all entries
  exercises <- readRDS(ex_list_path)
  expect_false(any(exercises$completed))

  # The first record should have `current == TRUE`
  expect_true(exercises[1, "current"])

  # Only one record should have `current == TRUE`
  expect_identical(sum(exercises$current), as.integer(1))

  unlink(proj_path, recursive = T)
})


test_that("Can setup an 'rstudio' project in an empty directory", {
  proj_path <- tempdir()
  setup_dir(proj_path, type = 'rstudio')

  # These files should exist
  config_file_path <- glue::glue("{proj_path}/{CONFIG_FILENAME}")
  current_exercise_path <- glue::glue("{proj_path}/{EXERCISE_FILENAME}")
  ex_list_path <- glue::glue("{proj_path}/{EX_LIST_FILENAME}")
  rprofile_path <- glue::glue("{proj_path}/.Rprofile")

  expect_true(file.exists(config_file_path))
  expect_true(file.exists(current_exercise_path))
  expect_true(file.exists(ex_list_path))
  expect_true(file.exists(rprofile_path))

  # The exercises file should have `completed == FALSE` for all entries
  exercises <- readRDS(ex_list_path)
  expect_false(any(exercises$completed))

  # The first record should have `current == TRUE`
  expect_true(exercises[1, "current"])

  # Only one record should have `current == TRUE`
  expect_identical(sum(exercises$current), as.integer(1))

  # .Rprofile should have trainr lines
  rprofile_lines <- readLines(rprofile_path)
  expect_true(length(grepl(r"(library\(trainr\))", rprofile_lines)) > 0)

  unlink(proj_path, recursive = T)
})
