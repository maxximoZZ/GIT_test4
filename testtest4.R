aa<- rnorm(1000)
summary(aa)
hist(aa)
library(usethis)
create_github_token()
library(gitcreds)
#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

gitcreds::gitcreds_set()
#prueba
#usethis::use_git_remote("origin", url = NULL, overwrite = TRUE)
  
library(usethis) # ya est? activo most likely
usethis::use_github()  
### si hay error no encuentra credenciales intentar lo que sigue
library(gh)
gh::gh_whoami()
gitcreds_get()
library(credentials)
credentials::set_github_pat()
gitcreds_get()
use_github()


##### solucion JCS
usethis::git_sitrep()
usethis::use_git_config(user.name = "maxximoZZ", user.email = "maximiliano.zilleruelo@ifop.cl")

## otras de JCS
#usethis::edit_r_environ()
#GITHUB_PAT=Tu PAT

### para manejar paquetes
install.packages("packrat")
library(packrat)
packrat::init()
packrat::bundle()  ## packrat::unbundle()

install.packages("tidyverse")

### Python
install.packages("reticulate")
library(reticulate)
#use_python("C:\Users\maximiliano.zillerue\AppData\Local\anaconda3")
use_python("C:/Users/maximiliano.zillerue7AppData/Local/anaconda3")
### not working

#### tidyverse
install.packages("tidyverse")
library(tidyverse)
install.packages("tidymodels")
library(tidymodels)
parsnip_addin()

### ejemplo tidyverse

install.packages("palmerpenguins")
library(palmerpenguins)
library(ggplot2)
library(dplyr)
penguins  ### tibble
penguins %>%
  filter(!is.na(sex)) %>%
  ggplot(aes(flipper_length_mm, bill_length_mm, color = sex, size = body_mass_g)) +
  geom_point(alpha = 0.5) +
  facet_wrap(~species)

## subset
penguins_df <- penguins %>%
  filter(!is.na(sex)) %>%
  select(-island)

### ejemplo tidymodels
library(tidymodels)
set.seed(123)
penguin_split <- initial_split(penguins_df, strata = sex)
penguin_train <- training(penguin_split)
penguin_test <- testing(penguin_split)
penguin_split

### bootstrap
set.seed(123)
penguin_boot <- bootstraps(penguin_train)

### ejemplo modelo
glm_spec <-logistic_reg() %>%
  set_engine("glm")
  glm_spec
### random fores ex
  rf_spec <- rand_forest() %>%
   set_mode("classification") %>%
   set_engine("ranger")
   rf_spec
#### workflow
   penguin_wf <- workflow() %>%
      add_formula(sex ~ .)
   penguin_wf
   
   glm_rs <- penguin_wf %>%
     add_model(glm_spec) %>%
     fit_resamples(
      resamples = penguin_boot,
      control = control_resamples(save_pred = TRUE)
      )
      glm_rs

    library(ranger)  
    rf_rs <- penguin_wf %>%
       add_model(rf_spec) %>%
       fit_resamples(
         resamples = penguin_boot,
         control = control_resamples(save_pred = TRUE)
         )
    rf_rs
      