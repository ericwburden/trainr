# Chapter 01 - Data Types
# - Lesson 02 - Double Values
# -- Exercise 03 - Arithmetic Operators

# Double data types represent most numbers in R, both integers (whole numbers)
# and floating point (decimal) numbers. Type `?double` in the console for more
# information about these.

# Arithmetic operators allow you to perform mathematical operations on numbers.
# Type `?Arithmetic` in the console for more information about these. The
# arithmetic operators include `+`, `-`, `*`, `/`, `^`, `%%`, and `%/%`.

# Replace `?` with the correct arithmetic operator to proceed. Each can be used
# once.

five <- 45.5 `?` 8.2
two_hundred_fifty_six <- 2 `?` 8
eighteen <- 3 `?` 6
ninety_nine <- 166 `?` 67
four <- 44 `?` 10
one_hundred_twenty_five <- 800 `?` 6.4
fifty_five <- 32 `?` 23



# This code will test your work
require(testthat)
test_that("I can use arithmetic operators", {

  # Reasonable expectations
  expect_identical(five, 5)
  expect_identical(two_hundred_fifty_six, 256)
  expect_identical(eighteen, 18)
  expect_identical(ninety_nine, 99)
  expect_identical(four, 4)
  expect_identical(one_hundred_twenty_five, 125)
  expect_identical(fifty_five, 55)

})
