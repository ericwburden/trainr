# Chapter 02 - Control Flow
# - Lesson 02 - Loops
# -- Exercise 01 - `for` Loops

# Control flow allows you to 'control the flow' of your code, by which we mean
# deciding which instructions are run, in what order, and how many times. This
# typically takes the form of 'choices' (run this code, or that code) and
# 'loops' (run this code some number of times, typically changing only a small
# part each time). Type `?Control` in the console for more information about
# control flow.

# Often, you will want to repeat an operation or a bit of code with only small
# variations each time. We refer to this process of doing the same or nearly the
# same thing repeatedly 'iterating', and one repetition is called an 'iteration'.
# R gives you the ability to 'iterate' over a group or collection of items by
# way of the `for` loop, which looks like this:
#
# for (<variable name> in <collection>) {
#   <some code that references the variable>
# }
#
# Say, for example, you want to multiply a list of numbers by 10. You can do
# that with the following example code:
#
# list_of_numbers <- c(5, 10, 15, 20, 25, 30)
# new_list_of_numbers <- numeric(0) # An empty list
#
# for (number in list of numbers) {
#   new_list_of_numbers <- append(number * 10, new_list_of_numbers)
# }


# Replace `?` with the correct values/variables to calculate the total sum of a
# list of numbers.
total_sum <- function(numbers) {
  total <- 0

  for (`?` in `?`) {
    total <- `?`
  }

  total
}


# Modify this `for` loop to return TRUE if there is a "character" type of
# value in the list of values
find_sneaky_character <- function(values) {

  for (value in `?`) {
    type <- typeof(value)

    if (`?` == `?`) {
      return(TRUE)
    }
  }

  FALSE
}


# This code will test your work
require(testthat)
test_that("I can use `for` loops", {

  # Reasonable expectations
  expect_identical(total_sum(c(10, 15)), 25)
  expect_identical(total_sum(c(1, 2, 3, 4, 5, 6)), 21)
  expect_identical(total_sum(c(-5, 0, 5)), 0)

  expect_identical(find_sneaky_character(c(1, 2, 3, 4)),   FALSE)
  expect_identical(find_sneaky_character(c(1, '2', 3, 4)), TRUE)
  expect_identical(find_sneaky_character(c(TRUE, FALSE, TRUE)),  FALSE)
  expect_identical(find_sneaky_character(c(TRUE, FALSE, 'TRUE')), TRUE)

})
