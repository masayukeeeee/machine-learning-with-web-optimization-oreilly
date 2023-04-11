df <- read_csv("book/dataset/chapter03/test-results-new.csv") %>% 
  mutate(ctr = round(ctr, 4)) %>% 
  mutate(
    img = c(0, 0, 1, 1),
    btn = c(0, 1, 0, 1)
  ) %>% 
  select(pattern, img, btn, everything())

model_path <- "book/script/chapter03/with-intraction-effect.stan"

data <- list(
  N = 4,
  Impression = as.integer(df$imp),
  Click      = as.integer(df$click),
  Img        = as.integer(df$img),
  Btn        = as.integer(df$btn)
)

fit_interaction <- rstan::stan(
  file = model_path,
  data = data,
  iter = 4000,
  chain = 4,
  seed = 1234
)

saveRDS(
  fit_interaction,
  file = "book/script/chapter03/fit_with-interaction.obj"
)


ggmcmc::ggs(fit_interaction) %>% 
  ggmcmc::ggs_traceplot()


# theta
fit_interaction %>% 
  tidybayes::spread_draws(theta[condition]) %>% 
  mutate(
    condition = as.factor(c("A", "B", "C", "D")[condition])
  ) %>% 
  ggplot(aes(y = fct_rev(condition), x = theta),) + 
  tidybayes::stat_halfeye(.width = c(.90, .5), fill = "skyblue") + 
  xlim(0, 0.10) +
  ylab("theta") + 
  xlab("density")


# coefficient
fit_interaction %>% 
  tidybayes::spread_draws(alpha, beta1, beta2, gamma) %>% 
  select(alpha, beta1, beta2, gamma) %>% 
  pivot_longer(cols = everything(),
               names_to = "parameter") %>% 
  ggplot(aes(y = parameter, x = value),) + 
  tidybayes::stat_halfeye(.width = c(.90, .5), fill = "skyblue")
