# Chapter 01 - Data Types
# - Lesson 02 - Logical Values
# -- Exercise 02 - Conversion

# Double data types represent most numbers in R, both integers (whole numbers)
# and floating point (decimal) numbers. Type `?double` in the console for more
# information about these.

# Values are passed to functions as 'arguments' in parentheses immediately
# following the name of the function, like 'function(argument)'. That argument
# is available inside the function body. For example:
#
# add_two <- function(number) {
#   number + 2
# }

# Replace `?` with the correct function to proceed.

convert_to_double <- function(arg) {
  `?`
}


# This code will test your work
require(testthat)
test_that("I can convert double values", {

  # Reasonable expectations
  expect_identical(convert_to_double("3.14"), 3.14)
  expect_identical(convert_to_double(TRUE), 1)
  expect_identical(convert_to_double("99.99"), 99.99)
  expect_identical(convert_to_double("4000"), 4000)

})
