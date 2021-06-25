# Chapter 01 - Data Types
# - Lesson 03 - Character Values
# -- Exercise 01 - Creation

# Character data types represent strings of characters in R, often referred to
# as simply 'strings' in other languages. A character value may be declared with
# single quotes (like 'this') or double quotes (like "this"). Note, surrounding
# a word or symbol with backticks (like `this`) is not a character value. Type
# `?character` in the console for more information about these.

# Replace `?` with the correct values to proceed.

lions <- `?`
tigers <- `?`
bears <- `?`
oh_my <- `?`


# This code will test your work
require(testthat)
test_that("I can assign character values", {

  # Reasonable expectations
  expect_identical(lions, "lions")
  expect_identical(tigers, "tigers")
  expect_identical(bears, "bears")
  expect_identical(oh_my, "Oh my!")

})
