# Chapter 02 - Control Flow
# - Lesson 02 - Loops
# -- Exercise 02 - `while` Loops

# Control flow allows you to 'control the flow' of your code, by which we mean
# deciding which instructions are run, in what order, and how many times. This
# typically takes the form of 'choices' (run this code, or that code) and
# 'loops' (run this code some number of times, typically changing only a small
# part each time). Type `?Control` in the console for more information about
# control flow.

# Sometimes, instead of iterating over a finite set of values, you will want to
# repeat code until some condition is met. In these cases, you want to use a
# `while` loop, which looks like this:
#
# while (<conditional expression evaluates to TRUE>) {
#   <some code to execute>
# }
#
# `while` loops come with the danger of creating an 'infinite loop' in cases
# where the condition never evaluates to FALSE. Below, you'll see one 'trick'
# to ensure this doesn't happen.

# `haystack` is a list of character values, either 'needle' or 'hay'
# This function should return the index of the first 'needle' in 'haystack'
needle_in_a_haystack <- function(haystack) {
  item_to_look_at <-  1

  # Replace `?` to make a valid comparison
  while (haystack[item_to_look_at] == "hay") {
    item_to_look_at = item_to_look_at + 1
  }

  item_to_look_at   # The return value
}


# The height of a projectile launched on a ballistic trajectory, ignoring drag, is
# given by the formula: y = v_0 * t * sin(z) - 1/2 * g * t^2, where `v_0` is
# the initial velocity, `t` is the time after launch, `z` is the angle of the
# launch, and g is the downward gravitational acceleration. The following
# function calculates the height of a projectile launched at 45 degrees for each
# time `t`, and returns the amount of time it takes for the projectile to
# hit the ground (height <= 0). The function returns `Inf` if the projectile travels
# further than the maximum time observed.
time_to_land <- function(v_0) {
  g <- 9.80665                     # m/s2, average for Earth
  sin_z <- sin(pi/4)               # Pre-calculate the sin of 45 degrees
  max_time_observed <- 2147483647  # This is the max for an integer in R
  height <- 1; time <- 1           # Initial values

  # Repeat until the projectile 'hits the ground', i.e. the height is less
  # than or equal to zero
  while (`?`) {
    # Return `Inf` if `time` is greater than the max time observed
    if (`?`) return(Inf)

    height <- (v_0 * time * sin_z) - ((g * time^2)/2)
    time <- time + 360  # Increase time
  }

  time  # The return value
}


# This code will test your work
require(testthat)
test_that("I can use a `while` loop", {
  haystack1 <- c(rep("hay", 50), "needle")
  haystack2 <- c(rep("hay", 10), "needle", rep("hay", 10))
  haystack3 <- c(rep("needle", 10), "hay", rep("needle", 10))

  expect_identical(needle_in_a_haystack(haystack1), 51)
  expect_identical(needle_in_a_haystack(haystack2), 11)
  expect_identical(needle_in_a_haystack(haystack3), 1)


  expect_identical(time_to_land(5e04), 7921)
  expect_identical(time_to_land(2e10), Inf)
  expect_identical(time_to_land(1e02), 721)

})
