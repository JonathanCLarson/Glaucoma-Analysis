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
}

generated quantities{
  real y_mean;
  int<lower = 0, upper = 1> y_fake[N];
  
  for (i in 1:N) {
    y_fake[i] = bernoulli_logit_rng(beta0 + beta[1]*x1[i] + beta[2]*x2[i]+beta[3]*x3[i]);
  }
  y_mean=sum(y_fake)/(N+0.0);
}
