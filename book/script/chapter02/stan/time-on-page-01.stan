data {
  int N;
  int <lower=0> time_on_page[N];
}

parameters {
  real <lower=0, upper=3000> theta;
}

model {
  // prior
  theta ~ uniform(0, 3000);
  
  // likelihood
  for (n in 1:N) {
    time_on_page[n] ~ exponential(theta);
  }
}
