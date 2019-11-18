% Variance reduction by conditioning.
clear;

n = 500;
X = exprnd(1, 1, n);
Y = exprnd(X);
est_xy_seq = [];
est_seq = [];
for i = 1:n
    data = X(1:i);
    est_XY = mean(data .* Y(1:i) < 3);
    est = mean(1-exp(-3 ./ data.^2));
    est_seq = [est_seq, est];
    est_xy_seq = [est_xy_seq, est_XY];
end

figure(1); clf;
p1 = plot(est_seq, "LineWidth", 2); hold on;
p2 = plot(est_xy_seq, "--", "LineWidth", 2);
title("Problem 3 estimate of P(XY \leq 3)");
xlabel("Sample size");
ylabel("Estimate");
legend([p1,p2], "MC Conditioning", "Original MC");