# Chapter 01 - Data Types
# - Lesson 01 - Logical Values
# -- Exercise 03 - Logical Operators

# Logical data types represent TRUE/FALSE values (often called 'boolean' values).
# In R, a logical value of true is represented as `TRUE` or `T`, a value of
# false as `FALSE` or `F`. Type `?logical` in the console for more information
# about these.

# Logical operators are operators that allow you to combine or manipulate
# logical values in order to make more complex decisions. Type `?Logical` in
# the console for more information about these. The logical operators include:
# `!`, `&`, `&&`, `|`, `||`, and `xor()`.

# The `any()` and `all()` functions take multiple logical values and return a
# single logical value if 'any' or 'all' of their arguments evaluate to TRUE,
# respectively. Type `?any` and `?all` into the console for more information.

# Replace `?` with the correct logical operator to proceed

false_value1 <- `?`TRUE
false_value2 <- TRUE `?` FALSE
false_value3 <- `?`(TRUE, TRUE)
false_value4 <- `?`(TRUE, FALSE, TRUE, FALSE)
false_value5 <- `?`(c(FALSE, TRUE) `?` c(TRUE, FALSE))

true_value1 <- `?`FALSE
true_value2 <- TRUE `?` FALSE
true_value3 <- `?`(TRUE, FALSE)
true_value4 <- `?`(TRUE, FALSE, TRUE, FALSE)
true_value5 <- `?`(c(FALSE, TRUE) `?` c(TRUE, FALSE))


# This code will test your work
require(testthat)
test_that("I can use logical operators", {

  # Reasonable expectations
  expect_false(false_value1)
  expect_false(false_value2)
  expect_false(false_value3)
  expect_false(false_value4)
  expect_false(false_value5)

  expect_true(true_value1)
  expect_true(true_value2)
  expect_true(true_value3)
  expect_true(true_value4)
  expect_true(true_value5)

})
