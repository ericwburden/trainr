# trainr

<!-- badges: start -->
[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)
[![Version](https://badge.fury.io/gh/tterb%2FHyde.svg)](https://badge.fury.io/gh/tterb%2FHyde)
<!-- badges: end -->

The goal of trainr is to provide an interactive R learning experience, inspired
by the [Ruby Koans](http://rubykoans.com/) and the idea of using Test-Driven
Development (and the Red -> Green -> Refactor) as a teaching tool. 

## Usage

- You can install the current version from GitHub using 
`devtools::install_github("ericwburden/trainr")`. 
- Once installed, you can create a `trainr` project using the RStudio 
'New Project...' dialog ("Learn R Using trainr" will be in the 'Project Type' 
list). That project will open to the `current_exercise.R` file containing your 
first learning challenge.
- When you think you've got it right, choose "TRAINR - Check Exercise" from the
'Addins' menu (or run `trainr::check_current_exercise()`) to check your answer.
- If you've got it right, choosing "TRAINR - Next Exercise" (or 
`trainr::next_exercise()`) will take you to the next exercise.

`trainr` keeps track of completed exercises on a per-project level, so if you
create a new project, that project starts at the beginning.

## Development

Extending `trainr` is super simple. Just fork the GitHub repository and add your 
challenges to the `inst/lessons` folder, with the 
`inst/lessons/chapter-<00>/lesson-<00>/<00>-exercise-name.R` pattern. Anywhere
in your script that you'd like a user to enter their own code, simply use the
``` `?` ``` token. Make sure to include tests for your code, and you're all
done. Build your package, and whenever a user opens a `trainr` project folder
with your package installed, the new exercises will be added to their list for
completion.
