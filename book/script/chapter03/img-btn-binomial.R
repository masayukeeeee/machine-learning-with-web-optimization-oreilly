df <- read_csv("book/dataset/chapter03/test-results.csv") %>% 
  mutate(ctr = round(ctr, 4)) %>% 
  mutate(
    img = c(0, 0, 1, 1),
    btn = c(0, 1, 0, 1)
  ) %>% 
  select(pattern, img, btn, everything())

model_path <- "book/script/chapter03/img-btn-binomial.stan"

data <- list(
  N = 4,
  Impression = as.integer(df$imp),
  Click      = as.integer(df$click),
  Img        = as.integer(df$img),
  Btn        = as.integer(df$btn)
)

fit_img_btn <- rstan::stan(
  file = model_path,
  data = data,
  iter = 4000,
  chain = 4,
  seed = 1234
)

saveRDS(
  fit_img_btn,
  file = "book/script/chapter03/fit_img_btn.obj"
)
