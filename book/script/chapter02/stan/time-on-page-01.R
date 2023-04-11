url <- "https://www.oreilly.co.jp/pub/9784873119168/data/time-on-page.csv"
time_on_page <- read.csv(url) %>% 
  tidyr::as_tibble() %>% 
  magrittr::set_colnames("time_on_page")

data <- list(
  N = nrow(time_on_page),
  time_on_page = time_on_page$time_on_page
)

fit_time_on_page <- rstan::stan(
  file = "book/script/chapter02/stan/time-on-page-01.stan",
  data = data,
  seed = 1234,
  iter = 2000,
  chain = 4
)

#saveRDS(fit_time_on_page,
#        "book/script/chapter02/stan/time-on-page-01.obj")

# 収束は問題なさそう
stan_results <- ggmcmc::ggs(fit_time_on_page)
ggmcmc::ggs_traceplot(stan_results)

# 事後分布の描画
ms <- rstan::extract(fit_time_on_page)
{1/ms$theta} %>% 
  tibble::as_tibble_col(
    column_name = "sample-of-theta"
  ) %>% 
  ggplot() + 
  geom_density(aes(x = `sample-of-theta`),
               fill = "blue", alpha = 0.4)

summary(fit_time_on_page)$summary

tidybayes::hdi(1/ms$theta)
# > [175, 230]

