# Chapter 02 - Control Flow
# - Lesson 01 - Choices
# -- Exercise 03 - `switch()` Function

# Control flow allows you to 'control the flow' of your code, by which we mean
# deciding which instructions are run, in what order, and how many times. This
# typically takes the form of 'choices' (run this code, or that code) and
# 'loops' (run this code some number of times, typically changing only a small
# part each time).Type `?Control` in the console for more information about
# control flow.

# `switch()` is the third and final example of choice control flow in this
# lesson. Type `?switch` into the R console to learn more about this function.
# The `switch()` function takes a first argument that is either a character
# value or can be coerced to a whole number, then matches the result of that
# expression against the remaining named arguments to `switch()` and returns
# the value with that name. `switch()` also takes a single unnamed value to be
# used as the default in case there are no matching named arguments.
# For example:
#
# ```
# value <- "a"            |   value <- "g"
# result <- switch(       |     result <- switch(
#   value,                |       value,
#   a = "apple",          |       a = "apple",
#   b = "bear",           |       b = "bear",
#   c = "candle",         |       c = "candle",
#   d = "dog",            |       d = "dog",
#   e = "egg",            |       e = "egg",
#   "something else"      |       "something else"
# )                       |     )
#                         |
# print(result)           |     print(result)
# # result -> "apple"     |     # result -> "something else"
# ```
#
# These statements are most useful with a somewhat small number of choices, and
# particularly if the first argument is a character value. Other uses can get
# somewhat confusing and are not recommended. It is also recommended that the
# other arguments to `switch()` all produce the same type of result (all numbers,
# or all logical values, or all character values) to prevent confusion.

# Replace `?` with the correct values to proceed.

switch_practice <- function(arg) {
  first_letter <- substr(as.character(arg), 1, 1) # The first letter of `arg`
  first_letter <- tolower(first_letter)           # Make it lowercase

  # Insert a switch statement here that evaluates `first_letter`, and returns
  # the position of that letter in the alphabet (a -> 1, z -> 26). You can
  # ignore letter case (we lowercased it for you).
  `?`
}


# This code will test your work
require(testthat)
test_that("I can use the `switch()` function", {

  # Reasonable expectations
  expect_identical(switch_practice("apple")   , 1)
  expect_identical(switch_practice("frog")    , 6)
  expect_identical(switch_practice("iguana")  , 9)
  expect_identical(switch_practice("Lion")    , 12)
  expect_identical(switch_practice("Ocean")   , 15)
  expect_identical(switch_practice("queen")   , 17)
  expect_identical(switch_practice("Umbrella"), 21)
  expect_identical(switch_practice("yak")     , 25)

})
