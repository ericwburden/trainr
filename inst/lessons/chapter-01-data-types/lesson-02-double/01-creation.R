# Chapter 01 - Data Types
# - Lesson 02 - Double Values
# -- Exercise 01 - Creation

# Double data types represent most numbers in R, both integers (whole numbers)
# and floating point (decimal) numbers. Type `?double` in the console for more
# information about these.

# Replace `?` with the correct values to proceed.

fifteen <- `?`
zero_point_two <- `?`
one_hundred_thirty_two <- `?`
twenty_two_point_six_two <- `?`


# This code will test your work
require(testthat)
test_that("I can assign double values", {

  # Reasonable expectations
  expect_identical(fifteen, 15)
  expect_identical(zero_point_two, 0.2)
  expect_identical(one_hundred_thirty_two, 132)
  expect_identical(twenty_two_point_six_two, 22.62)

})
