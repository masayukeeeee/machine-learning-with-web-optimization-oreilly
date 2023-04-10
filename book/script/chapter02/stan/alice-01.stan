data {
  int Impression;
  int Click;
  int K; // number of predictors
}

parameters {
  real<lower=0, upper=1> Probability;
}

model {
    Click ~ binomial(Impression, Probability);
}

generated quantities {
  vector[K] Click_pred;
  for (k in 1:K) {
    Click_pred[k] = binomial_rng(Impression, Probability);
  }
}
