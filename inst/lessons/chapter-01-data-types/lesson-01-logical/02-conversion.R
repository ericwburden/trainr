# Chapter 01 - Data Types
# - Lesson 01 - Logical Values
# -- Exercise 02 - Conversion

# Logical data types represent TRUE/FALSE values (often called 'boolean' values).
# In R, a logical value of true is represented as `TRUE` or `T`, a value of
# false as `FALSE` or `F`. Type `?logical` in the console for more information
# about these.

# Values are passed to functions as 'arguments' in parentheses immediately
# following the name of the function, like 'function(argument)'. That argument
# is available inside the function body. For example:
#
# add_two <- function(number) {
#   number + 2
# }

# Replace `?` with the correct function to proceed.

convert_to_logical <- function(arg) {
  `?`
}


# This code will test your work
require(testthat)
test_that("I can convert logical values", {

  # Reasonable expectations
  expect_true(convert_to_logical("true"))
  expect_true(convert_to_logical(1))
  expect_true(convert_to_logical("T"))

  expect_false(convert_to_logical("False"))
  expect_false(convert_to_logical(0.0))
  expect_false(convert_to_logical("FALSE"))

})
