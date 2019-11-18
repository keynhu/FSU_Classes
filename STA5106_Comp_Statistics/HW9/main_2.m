% Estimate an integral with two different MC estimators.
clear;

rng(0);
n_range = round(10.^(1:0.1:6)); % Sample size
est_1_seq = [];
est_2_seq = [];
for i = n_range
    data_1 = rand(1,i); % Estimator 1: Unif(0,1)
    data_2_U = rand(1,i);
    data_2 = sqrt(data_2_U); % Estimator 2: f(x)=2x, 0<x<1.
    est_1 = mean(exp(-data_1));
    est_2 = mean(exp(-data_2) ./ data_2) * 0.5;
    est_1_seq = [est_1_seq, est_1];
    est_2_seq = [est_2_seq, est_2];
end

figure(1); clf;
p1 = plot(1:0.1:6, est_1_seq, "--", "LineWidth", 2); hold on;
p2 = plot(1:0.1:6, est_2_seq, "LineWidth", 2);
legend([p1, p2], "Uniform(0,1)", "f(x)=2x, 0 \leq x \leq 1");
title("Problem 2 estimates of two MC estimators", "FontSize", 15);
xlabel("Sample size (log_{10})");
ylabel("Estimate");