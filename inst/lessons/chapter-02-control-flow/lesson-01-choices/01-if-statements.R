# Chapter 02 - Control Flow
# - Lesson 01 - Choices
# -- Exercise 01 - `if` Statements

# Control flow allows you to 'control the flow' of your code, by which we mean
# deciding which instructions are run, in what order, and how many times. This
# typically takes the form of 'choices' (run this code, or that code) and
# 'loops' (run this code some number of times, typically changing only a small
# part each time).

# In R, you have a number of options for controlling the execution flow of your
# code. One of the most traditional, and common to almost all programming
# languages, is the `if` statement. In R, you can assign the value of the
# last expression run in an `if` statement to a variable. The syntax for an
# `if` statement looks like this:
#
# result <- if (<conditional expression evaluates to TRUE>) {
#   <the first possible value>
# } else if (<another conditional expression evaluations to TRUE>) {
#   <the second possible value>
# } else {
#   <the default value>
# }
#
# Note: The '<expression>' statements should be replaced, including the angle
# brackets.
#
# The expressions inside the parentheses (if (<this one>) {}) should evaluate
# to a logical value (TRUE or FALSE) (a.k.a. `as.logical(<this one>)` returns
# TRUE or FALSE, not NA). The expressions between the curly braces
# (if () {<this one>}) can be as many statements as you like. The 'else if' and
# 'else' blocks are not strictly required.

# Replace `?` with the correct values to proceed.

compare_numbers <- function(number1, number2) {
  # Options: "greater", "lesser", "equal"
  result <- if (number1 > number2) {
    `?`
  } elseif (number2 > number1) {
    `?`
  } else {
    `?`
  }

  result
}


talk_about_types <- function(value) {
  type <- typeof(value)

  # Insert an `if` statement here that checks the value of `type`
  # - If `type` is "logical", return "This is a very logical result"
  # - If `type` is "character", return "This value has character"
  # - If `type` is "double", return "One, two, three, numeric as can be"
  # - For anything else, return "Sorry, I just don't get it"
  `?`
}


# This code will test your work
require(testthat)
test_that("I can use `if` statements", {

  # Reasonable expectations
  expect_identical(compare_numbers(10, 15), "lesser")
  expect_identical(compare_numbers(15, 10), "greater")
  expect_identical(compare_numbers(15, 15), "equal")

  expect_identical(talk_about_types(TRUE), "This is a very logical result")
  expect_identical(talk_about_types("hai"), "This value has character")
  expect_identical(talk_about_types(9), "One, two, three, numeric as can be")
  expect_identical(talk_about_types(raw()), "Sorry, I just don't get it")

})
