data {
  int N;
  int<lower=0> imp[N];
  int<lower=0> click[N];
}

parameters {
  real<lower=0, upper=1> theta[N] ;
}

model {
  for (n in 1:N) {
    click[n] ~ binomial(imp[n], theta[n]);
  }
}
