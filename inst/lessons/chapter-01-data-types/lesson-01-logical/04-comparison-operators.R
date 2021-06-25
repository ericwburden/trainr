# Chapter 01 - Data Types
# - Lesson 01 - Logical Values
# -- Exercise 04 - Comparison Operators

# Logical data types represent TRUE/FALSE values (often called 'boolean' values).
# In R, a logical value of true is represented as `TRUE` or `T`, a value of
# false as `FALSE` or `F`. Type `?logical` in the console for more information
# about these.

# Comparison operators produce boolean values. Most data types can be compared,
# though these comparisons may need to be implemented independently for more
# complicated objects. Type `?Comparison` in the console for more information
# about these. The comparison operators include `>`, `>=`, `<`, `<=`, `==`, and
# `!=`. Multiple values can be compared at once, for example:
# `c(1, 5) > 2` -> `c(FALSE, TRUE)`.

# Replace `?` with the correct comparison operator to proceed

false_value1 <- 100 `?` 500
false_value2 <- 500 `?` 500
false_value3 <- "balls" `?` "strikes"
false_value4 <- "a" `?` "b"
false_value5 <- all(c(1, 2, 3) `?` c(1, 2, 3))

true_value1 <- 100 `?` 500
true_value2 <- 500 `?` 500
true_value3 <- "balls" `?` "strikes"
true_value4 <- "a" `?` "b"
true_value5 <- all(c(1, 2, 3) `?` c(1, 2, 3))


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
