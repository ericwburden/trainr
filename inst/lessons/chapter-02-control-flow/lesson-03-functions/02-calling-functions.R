# Chapter 02 - Control Flow
# - Lesson 03 - Functions
# -- Exercise 02 - Calling Functions

# While not necessarily part of code control flow, functions are the starting
# point for organizing your code cleanly and effectively. A function is a
# collection of code that takes *arguments* and (optionally) returns a *result*.
# Type `?function` in the console for more information about functions.

# When you define a function, you may include some default values for one or
# more of that function's arguments. For example, the definition of the `paste()`
# function looks like:
#
# paste <- function(..., sep = " ", collapse = NULL, recycle0 = FALSE)
#
# where `...` indicates an arbitrary number of unnamed arguments, and `sep`,
# `collapse`, and `recycle0` are 'named' arguments with default values. So,
# if you call `paste('a', 'b')`, you get back "a b", but if you call
# `paste('a', 'b', sep = " +-+ ")`, you get "a +-+ b". In this case, the
# 'default' separator value is a space, but you can specify a different argument
# if you want. In functions that only take named arguments, you either need
# to ensure you pass in arguments in the same order as the function defintion, or
# use the argument names. So for a function defined as:
#
# some_function <- function(a, b, c)
#
# If you call it as `some_function(1, 2, 3)`, then the value of `a` will be 1,
# `b` will be 2, and `c` will be 3. You can, however, call it as
# `some_function(c = 1, a = 2, b = 3)`, which will assign the values to c, a,
# and b, respectively.



# Here is a somewhat silly function. Practice calling this function in different
# ways.

# Scrambles a given list of items. You can choose to include or ignore missing
# values (indicated as `NA`)
bedlam <- function(things, na.rm = FALSE) {
  things <- if (na.rm) { things[!is.na(things)] } else { things }
  sample(things, length(things))
}


# Call `bedlam` with the `valuables` list and...
valuables <- c(8, 5, NA, 1, 7, NA, 2, 4)

# ...no value for 'na.rm'
first <- bedlam(`?`)

# ...'TRUE' for 'na.rm', as a positional argument
second <- bedlam(`?`, `?`)

# ...'TRUE' for 'na.rm', as a named argument
third <- bedlam(`?`, na.rm = `?`)

# ...with both arguments named, in any order, with 'FALSE' for 'na.rm'
fourth <- bedlam(`?`, `?`)


# This code will test your work
require(testthat)
test_that("I can call functions in all kinds of ways", {

  sorted_valuables <- sort(valuables)
  sorted_no_na <- sorted_valuables[!is.na(sorted_valuables)]

  # Reasonable expectations
  expect_identical(sort(first) , sorted_valuables)
  expect_identical(sort(second), sorted_no_na)
  expect_identical(sort(third) , sorted_no_na)
  expect_identical(sort(fourth), sorted_valuables)
})
