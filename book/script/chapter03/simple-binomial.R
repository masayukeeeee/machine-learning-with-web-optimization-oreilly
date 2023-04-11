df <- read_csv("book/dataset/chapter03/test-results.csv")
model_path <- "book/script/chapter03/simple-binomial.stan"

data <- list(
  N = nrow(df),
  imp = df$imp,
  click = df$click
)

fit_simple_model <- rstan::stan(
  file = model_path,
  data = data,
  iter = 4000,
  chain = 4,
  seed = 1234
)

saveRDS(
  fit_simple_model,
  file = "book/script/chapter03/simple-obj"
)

# confirm
summary(fit_simple_model)$summary

ms <- rstan::extract(fit_simple_model)
fit_simple_model %>% 
  tidybayes::spread_draws(theta[condition]) %>% 
  ggplot(aes(y = fct_rev(as.factor(condition)), x = theta),) + 
  tidybayes::stat_halfeye(.width = c(.90, .5), fill = "skyblue") + 
  xlim(0, 0.25) +
  ylab("theta") + 
  xlab("density")
  

ggmcmc::ggs(fit_simple_model) %>% 
  ggmcmc::ggs_traceplot()

# HDI
fit_simple_model %>% 
  rstan::extract() %>% 
  purrr::pluck("theta") %>% 
  as.data.frame() %>% 
  magrittr::set_colnames(
    paste("theta", 1:4, sep = "_")
  ) %>% 
  apply(2, function(x) {
    res <- c(mean=mean(x), sd=sd(x), hdi(x, 0.95))
    return(res)
  }) %>% 
  t() %>% 
  round(3) %>% 
  as.data.frame() %>% 
  tibble::rownames_to_column() %>% 
  tibble::as_tibble() %>% 
  mutate(
    hid_range = upper - lower
  )
  

