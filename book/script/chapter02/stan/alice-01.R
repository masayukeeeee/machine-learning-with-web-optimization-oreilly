library(rstan)
library(glue)
library(tidyverse)
library(ggmcmc)
folder_path <- "book/script/chapter02/stan"
file_name <- "alice-01.stan"
model_path <- file.path(folder_path, file_name)

# preparating data
alice_data <- list(
  Impression = 40, 
  Click = 2,
  K = 1000
)

# execute MCMC
fit <- rstan::stan(
  file = model_path, data = alice_data, seed = 1234
)

# check
summary(fit)$summary[c("Probability"), ] %>% round(3)

# samples
ms <- rstan::extract(fit)

# posterior distribution of p
ms$Probability %>% 
  as_tibble() %>% 
  ggplot() + 
  geom_density(aes(x = value), fill = "blue", alpha = 0.4)

# HDI
est_dens <- density(ms$Probability)
hmv <- tibble(x = est_dens$x, p = est_dens$y)
hdi <- hmv %>% 
  arrange(desc(p)) %>% 
  mutate(hdi = cumsum(p) / sum(p)) %>% 
  dplyr::filter(hdi < 0.95) %>% 
  pull(x) %>% 
  range()

bounds <- hmv %>% 
  dplyr::filter(
    x > hdi[1], x <hdi[2]
  )

hdi_low  = round(hdi[1], 3)
hdi_high = round(hdi[2], 3)
hmv %>% 
  ggplot(aes(x = x, y = p)) + 
  geom_line() + 
  geom_ribbon(data = bounds, aes(ymax = p), ymin = 0,
              fill = "orange", alpha=0.5) + 
  ggtitle(label = "MCMC Result of Alice A",
          subtitle = glue("95%HDI: [{hdi_low}, {hdi_high}]"))

