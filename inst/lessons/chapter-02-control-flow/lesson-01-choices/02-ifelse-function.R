# Chapter 02 - Control Flow
# - Lesson 01 - Choices
# -- Exercise 02 - `ifelse()` Function

# Control flow allows you to 'control the flow' of your code, by which we mean
# deciding which instructions are run, in what order, and how many times. This
# typically takes the form of 'choices' (run this code, or that code) and
# 'loops' (run this code some number of times, typically changing only a small
# part each time).Type `?Control` in the console for more information about
# control flow.

# R also provides the `ifelse()` function that allows you to make multiple
# comparisons in a single statement. For more information about this function,
# type `?ifelse` into the console. For example:
#
# ```
# result <- ifelse(c(5, 10, 15, 20) > 12, "greater than", "not greater")
# print(result)
# # c("not greater", "not greater", "greater than", "greater than")
# ```

# Replace `?` with the correct values to proceed.

compare_numbers <- function(numbers1, numbers2) {
  # Options: "equal", "not equal"
  ifelse(numbers1 == numbers2, `?`, `?`)
}


multiple_comparison <- function(numbers1, numbers2) {
  # Insert an `ifelse()` function call here that compares `numbers1` to
  # `numbers2` and returns a list containing the larger numbers
  `?`
}


# This code will test your work
require(testthat)
test_that("I can use the `ifelse()` function", {

  # Reasonable expectations
  expect_identical(compare_numbers(c(10, 15), c(10, 15)), c("equal", "equal"))
  expect_identical(compare_numbers(c(15, 15), c(10, 15)), c("not equal", "equal"))
  expect_identical(compare_numbers(c(10, 15), c(10, 10)), c("equal", "not equal"))

  expect_identical(multiple_comparison(c(10, 15), c(15, 5)),  c(15, 15))
  expect_identical(multiple_comparison(c(10, 15), c(15, 50)), c(15, 50))
  expect_identical(multiple_comparison(c(20, 20), c(15, 5)),  c(20, 20))

})
