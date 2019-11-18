% Compare the convergence of MC estimators on N(0,1) mean, variance and
% kurtosis.
clear;

rng(2019);
n_range = round(10.^(1:0.1:5)); % Range of Sample Size
m = 100; % Simulation times of each given sample size
% (a) Mean
mu_seq = [];
var_mu_seq = [];
for i = n_range
    mu_ests = [];
    for j = 1:m
        data = randn(1, i);
        mu_ests = [mu_ests, mean(data)];
    end
    mu_seq = [mu_seq, mean(mu_ests)];
    var_mu_seq = [var_mu_seq, var(mu_ests)];
end
mu = mu_seq(end); % Last estimation is the final estimation
% for i = 1:n
%     data = Y1(1:i);
%     mu_tmp = mean(data);
%     var_mu_tmp = var(mu_ests) / i;
%     mu_seq = [mu_seq, mu_tmp];
%     var_mu_seq = [var_mu_seq, var_mu_tmp];
% end

% (b) Variance
var_seq = [];
var_var_seq = [];
for i = n_range
    var_ests = [];
    for j = 1:m
        data = randn(1, i);
        tmp_var = (data - mu).^2;
        var_ests = [var_ests, mean(tmp_var)];
    end
    var_seq = [var_seq, mean(var_ests)];
    var_var_seq = [var_var_seq, var(var_ests)];
end
sigma2 = var_seq(end);

% (c) Kurtosis
krt_seq = [];
var_krt_seq = [];
for i = n_range
    krt_ests = [];
    for j = 1:m
        data = randn(1, i);
        tmp_krt = (data - mu).^4 / sigma2^2;
        krt_ests = [krt_ests, mean(tmp_krt)];
    end
    krt_seq = [krt_seq, mean(krt_ests)];
    var_krt_seq = [var_krt_seq, var(krt_ests)];
end

% Plot 1
figure(1); clf;
subplot(2,1,1);
plot(log10(n_range), mu_seq.^2, "LineWidth", 2);
title("SSE convergence of mean estimator", "FontSize", 12);
xlabel("Sample size (log_{10})");
ylabel("SSE");
subplot(2,1,2);
plot(log10(n_range), var_mu_seq, "LineWidth", 2);
title("Sample variance of mean estimator", "FontSize", 12);
xlabel("Sample size (log_{10})");
ylabel("Sample variance");
% Plot 2
figure(2); clf;
subplot(2,1,1);
plot(log10(n_range), (var_seq - 1).^2, "LineWidth", 2);
title("SSE convergence of variance estimator", "FontSize", 12);
xlabel("Sample size (log_{10})");
ylabel("SSE");
subplot(2,1,2);
plot(log10(n_range), var_var_seq, "LineWidth", 2);
title("Sample variance of variance estimator", "FontSize", 12);
xlabel("Sample size (log_{10})");
ylabel("Sample variance");
% Plot 3
figure(3); clf;
subplot(2,1,1);
plot(log10(n_range), (krt_seq-3).^2, "LineWidth", 2);
title("SSE convergence of kurtosis estimator", "FontSize", 12);
xlabel("Sample size (log_{10})");
ylabel("SSE");
subplot(2,1,2);
plot(log10(n_range), var_krt_seq, "LineWidth", 2);
title("Sample variance of kurtosis estimator", "FontSize", 12);
xlabel("Sample size (log_{10})");
ylabel("Sample variance");