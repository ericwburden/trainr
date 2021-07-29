# Chapter 02 - Control Flow
# - Lesson 02 - Loops
# -- Exercise 03 - `repeat ` Loops

# Control flow allows you to 'control the flow' of your code, by which we mean
# deciding which instructions are run, in what order, and how many times. This
# typically takes the form of 'choices' (run this code, or that code) and
# 'loops' (run this code some number of times, typically changing only a small
# part each time). Type `?Control` in the console for more information about
# control flow.

# The most flexible type of loop in R is a `repeat` loop. It looks like this:
#
# repeat {
#   <some code to execute>
# }
#
# A `repeat` loop IS an infinite loop by design, and you will need to use some
# other coding tools to exit from a `repeat` loop. In our previous exercise,
# you saw an example of 'exiting early' from a loop using `return()`. You can
# also use the `next` and `break` keywords to modify the flow of loops. `next`
# and `break` work for all loop types. When `next` is encountered in a loop, the
# rest of the code in the loop is skipped and the loop moves on to the 'next'
# iteration. When `break` is encountered in a loop, the loop immediately exits
# and doesn't run again.


# Given a character value, return a list containing five copies of that value
repeat_five_times <- function(string) {
  output_strings <- character(0)  # An empty list of character values

  repeat {
    output_strings <- append(output_strings, string)

    # If the output is five items long, then stop looping
    if (`?`) `?`
  }

  output_strings  # Return value
}


# Given a character value, return a list of the vowels in that value
extract_the_vowels <- function(string) {
  all_letters <- strsplit(string, "")[[1]]  # Split the character value into letters
  letter_list <- character(0)  # An empty list of character values
  current <- 1  # Start by looking at the first letter
  vowels <- c('a', 'e', 'i', 'o', 'u')  # List of vowels

  repeat {
    # If the letter is not a vowel, skip and go to the next loop. You can check
    # if an item is in a list with (item %in% list) or if the item is not in the
    # list with (!(item %in% list)).
    if (`?`) `?`

    # If you've checked all the letters in the list, you're done
    if (`?`) `?`

    # Add a letter to the list and look at the next letter
    letter_list <- append(letter_list, all_letters[current])
    current <- `?`
  }

  letter_list  # Return value
}


# This code will test your work
require(testthat)
test_that("I can use a `repeat` loop", {

  # Reasonable expectations
  expect_identical(repeat_five_times("a") , rep("a" , 5))
  expect_identical(repeat_five_times("hi"), rep("hi", 5))

  expect_identical(extract_the_vowels("goodbye")    , c("o", "o", "e"))
  expect_identical(extract_the_vowels("teen spirit"), c("e", "e", "i", "i"))
  expect_identical(extract_the_vowels("aardvark")   , c("a", "a", "a"))



})
