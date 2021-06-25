# Chapter 01 - Data Types
# - Lesson 01 - Logical Values
# -- Exercise 01 - Creation

# Logical data types represent TRUE/FALSE values (often called 'boolean' values).
# In R, a logical value of true is represented as `TRUE` or `T`, a value of
# false as `FALSE` or `F`. Type `?logical` in the console for more information
# about these.

# Replace `?` with the correct values to proceed.

true_value <- `?`
false_value <- `?`


# This code will test your work
require(testthat)
test_that("I can assign logical values", {

  # Reasonable expectations
  expect_true(true_value)
  expect_false(false_value)

})
