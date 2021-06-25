# Chapter 01 - Data Types
# - Lesson 03 - Character Values
# -- Exercise 02 - Conversion

# Character data types represent strings of characters in R, often referred to
# as simply 'strings' in other languages. A character value may be declared with
# single quotes (like 'this') or double quotes (like "this"). Note, surrounding
# a word or symbol with backticks (like `this`) is not a character value. Type
# `?character` in the console for more information about these.

# Values are passed to functions as 'arguments' in parentheses immediately
# following the name of the function, like 'function(argument)'. That argument
# is available inside the function body. For example:
#
# add_two <- function(number) {
#   number + 2
# }

# Replace `?` with the correct function to proceed.

convert_to_character <- function(arg) {
  `?`
}


# This code will test your work
require(testthat)
test_that("I can convert character values", {

  # Reasonable expectations
  expect_identical(convert_to_character(3.14), "3.14")
  expect_identical(convert_to_character(TRUE), "TRUE")
  expect_identical(convert_to_character(99.99), "99.99")
  expect_identical(convert_to_character(4000), "4000")

})
