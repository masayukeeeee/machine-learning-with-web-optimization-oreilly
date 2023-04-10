# item A について多項分布・ディリクレ分布によるベイズ推論を行う
df <- read.csv("book/dataset/chapter02/review_score.csv") %>% 
  dplyr::filter(item == "A")
n <- sum(df$count)
# score <- rep(df$score, df$count)
counts <- df$count

review_data <- list(
  n_category = 5,
  counts = counts,
  alpha = c(1,1,1,1,1)
)

# stan
model_path <- "book/script/chapter02/stan/review-score-01.stan"
seed = 1234

fit <- rstan::stan(
  file = model_path,
  data = review_data,
  seed = seed,
  iter = 4000,
  chain = 4,
  control = list(
    max_treedepth = 15
  )
)

save_path <- "book/script/chapter02/stan/review-score-01.obj"
saveRDS(fit, save_path)

# results
summary(fit)$summary
ms <- rstan::extract(fit)
