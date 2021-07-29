# Chapter 02 - Control Flow
# - Lesson 03 - Functions
# -- Exercise 01 - Writing Functions

# While not necessarily part of code control flow, functions are the starting
# point for organizing your code cleanly and effectively. A function is a
# collection of code that takes *arguments* and (optionally) returns a *result*.
# Type `?function` in the console for more information about functions.

# By now, you will have seen a number of examples of functions. In R, the
# *definition* for a function looks like this:
#
# <function name> <- function(<arguments>) {
#   <code to run>
#   <optional return statement>
# }
#
# Arguments are variables whose values are given to the function by the 'calling
# code' (the code that calls the function) and those values are available inside
# the function.
#
# In R, you can use the `return()` function to exit the function and return
# the value passed to the `return()` function, OR you can rely on your function
# to return the value of evaluating the last expression (line of code) in your
# function. So:
#
# return_three <- function() {
#   2 + 1
# }
#
# three <- return_three()
#
# will yield `3` as the value of the variable `three`. When you read R code, you
# will often see functions written this way, without an explicit call to
# `return()`.


# Modify this function to take a character value as an argument and return
# a greeting message
say_my_name <- function(`?`) {
  paste("Hello,", `?`)
}


# Modify this function to take two numbers and return the result of performing
# the `op()` operation on those numbers. As you can see, the math operators are
# really just functions in disguise!
do_math <- function(`?`, `?`, op = c(`+`, `-`, `/`, `*`)) {
  op(`?`, `?`)
}


# Write a function that takes an argument and gives it back.
give_me_back <- `?`


# This code will test your work
require(testthat)
test_that("I can write functions", {

  # Reasonable expectations
  expect_identical(say_my_name("Frank"), "Hello, Frank")
  expect_identical(say_my_name(404)    , "Hello, 404")

  expect_identical(do_math(3, 2, `+`), 5)
  expect_identical(do_math(3, 2, `-`), 1)
  expect_identical(do_math(3, 2, `/`), 1.5)
  expect_identical(do_math(3, 2, `*`), 6)

  expect_identical(give_me_back("tea"), "tea")
  expect_identical(give_me_back(500)  , 500)
  expect_identical(give_me_back(2e55) , 2e55)
})
