data {
  int<lower=0> N;
  int<lower=0> Impression[N];
  int<lower=0> Click[N];
  vector[N] Img;
  vector[N] Btn;
}

parameters {
  real alpha;
  real beta1;
  real beta2;
}

transformed parameters {
  vector<lower=0, upper=1>[N] theta;
  for (n in 1:N) {
    theta[n] = inv_logit(alpha + beta1 * Img[n] + beta2 * Btn[n]);
  }
}

model {
    alpha ~ normal(0, 10);
    beta1 ~ normal(0, 10);
    beta2 ~ normal(0, 10);
    
    for(n in 1:N) {
      Click[n] ~ binomial(Impression[n], theta[n]);
    }
}
