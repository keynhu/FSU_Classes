% Problem 3, Weibull RNG
rng(2019);
Y = weibull_gen(1000, 1, 0.5);

figure(1); clf;
histogram(Y, 100);
title("Histogram of samples with Weibull(1, 0.5)");
