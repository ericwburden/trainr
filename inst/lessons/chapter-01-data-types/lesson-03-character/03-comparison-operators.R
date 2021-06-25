# Chapter 01 - Data Types
# - Lesson 03 - Character Values
# -- Exercise 03 - Comparison Operators

# Character data types represent strings of characters in R, often referred to
# as simply 'strings' in other languages. A character value may be declared with
# single quotes (like 'this') or double quotes (like "this"). Note, surrounding
# a word or symbol with backticks (like `this`) is not a character value. Type
# `?character` in the console for more information about these.

# Comparing character values may be a bit counter-intuitive and is based on your
# locale. The tests below were written in an 'en_US.UTF-8' locale (US). In that
# locale, capital letters are greater than their lowercase equivalent, but less
# than the next letter in sequence (both capital and lowercase). For example:
#   "A" > "a"  => TRUE
#   "A" > "b"  => FALSE
#   "A" < "B"  => TRUE
#   "A" == "a" => FALSE

# For character values with multiple characters, comparison is based on the
# position in the string, for example:
#   "ab" > "aa"   => TRUE
#   "ab" > "ac"   => FALSE
#   "aa" > "a"    => TRUE
#   "aa" > "aab"  => FALSE

# The same rules apply for strings that contain numbers, for example:
#   "4" > "5"  => FALSE
#   "44" > "5" => FALSE

# You can compare character and double values, but the character value will
# always be greater, for example:
#   "5" > 1  => TRUE
#   "5" > 10 => TRUE

# Replace `?` with the correct comparison operator to proceed

false_value1 <- "cat" `?` "dog"
false_value2 <- "apples" `?` "oranges"
false_value3 <- "parasol" `?` "parasols"
false_value4 <- 99 `?` "99"
false_value5 <- "arbitrary" `?` "arbitrary"

true_value1 <- "cat" `?` "dog"
true_value2 <- "apples" `?` "oranges"
true_value3 <- "parasol" `?` "parasols"
true_value4 <- 99 `?` "99"
true_value5 <- "arbitrary" `?` "arbitrary"


# This code will test your work
require(testthat)
test_that("I can use comparison operators with character values", {

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
