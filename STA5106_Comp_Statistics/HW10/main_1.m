% Problem 1: Importance sampling to estimate an integral

clear;

rng(2019);
y = 0.5;
N_range = round(10.^(1:0.1:7));
est_seq = [];
for i = 1:length(N_range)
    data = exprnd(1/3, 1, N_range(i)); % Parameter = 3, Generate (1 x i) samples
    Z_est = mean(exp(-(y - data).^2/2)) / 3;
    theta_est = mean(data .* exp(-(y - data).^2/2)) / (3 * Z_est);
    est_seq(i) = theta_est;
end

figure(1); clf;
plot(log10(N_range), est_seq, 'LineWidth', 2);
xlabel("Sample size (log_{10})");
ylabel("Estimate");
title("Problem 1 - Importance sampling estimate", "FontSize", 14);
