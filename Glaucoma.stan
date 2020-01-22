data {
  int<lower=0> N;
  int<lower = 0, upper = 1> y[N];
  vector<lower = 0,upper = 1>[N] x1; // Sex
  vector<lower = 0>[N] x2;           // Total
  vector<lower = 0>[N] x3;           // Age
}
parameters {
  real beta0;
  real beta[3];   
}
model {
  beta ~ normal(0,10);
  beta0 ~ normal(0,10);
  y ~ bernoulli_logit(beta0 + beta[1]*x1+beta[2]*x2+beta[3]*x3);
}

generated quantities{
  real ymean;
  int<lower = 0, upper = 1> y_rep[N];
  for (i in 1:N) {
    y_rep[i] = bernoulli_logit_rng(beta0 + beta[1]*x1[i] + beta[2]*x2[i]+beta[3]*x3[i]);
  }
  ymean = sum(y_rep)/(N+0.0);
}



