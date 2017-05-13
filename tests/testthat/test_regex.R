library(testthat)
library(magrittr)
library(recipes)

data(covers)
covers$rows <- 1:nrow(covers)
covers$ch_rows <- paste(1:nrow(covers))

rec <- recipe(~ description + rows + ch_rows, covers)

test_that('default options', {
  rec1 <- rec %>%
    step_regex(description, pattern = "(rock|stony)") %>%
    step_regex(description, result = "all ones")
  rec1 <- learn(rec1, training = covers)
  res1 <- process(rec1, newdata = covers)
  expect_equal(res1$X.rock.stony., 
               as.numeric(grepl("(rock|stony)", covers$description)))
  expect_equal(res1$`all ones`, rep(1, nrow(covers)))
})


test_that('nondefault options', {
  rec2 <- rec %>%
    step_regex(description, pattern = "(rock|stony)", 
               result = "rocks",
               options = list(fixed = TRUE)) 
  rec2 <- learn(rec2, training = covers)
  res2 <- process(rec2, newdata = covers)
  expect_equal(res2$rocks, rep(0, nrow(covers)))
})


test_that('bad selector(s)', {
  expect_error(rec %>% step_regex(description, rows, pattern = "(rock|stony)"))
  rec3 <- rec %>% step_regex(starts_with("b"), pattern = "(rock|stony)")
  expect_error(learn(rec3, training = covers))
  rec4 <- rec %>% step_regex(rows, pattern = "(rock|stony)")
  expect_error(learn(rec4, training = covers))
})