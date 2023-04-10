data {
  int<lower=1> n_category;
  int<lower=0> counts[n_category];
  vector<lower=0>[n_category] alpha;
}

parameters {
  simplex[n_category] theta;
}

model {
  theta ~ dirichlet(alpha);
  counts ~ multinomial(theta);  
}
