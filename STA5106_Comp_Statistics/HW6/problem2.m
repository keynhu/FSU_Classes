clear;

% load hw6_2_data1.mat
load hw6_2_data2.mat

figure(1);
hist(Y);
title("Histogram of Data 1");
% title("Histogram of Data 2");
xlabel("Y");
ylabel("count");

n = length(Y);
eps = 1e-3;
% [a1,mu1,sig1,a2,mu2,sig2] = deal(0.3, 0, 1.3, 0.7, 5, 1);
[a1,mu1,sig1,a2,mu2,sig2] = deal(0.3, 2.25, 1.5, 0.7, 3.25, 1);
llh_seq = log_ll(Y,a1,mu1,sig1,a2,mu2,sig2);
while true
    [P1, P2] = label_prob(Y,a1,mu1,sig1,a2,mu2,sig2);
    a1_new = sum(P1) / n;
    mu1_new = sum(Y .* P1) / sum(P1);
    sig1_new = sqrt(sum((Y-mu1_new).^2 .* P1) / sum(P1));
    a2_new = sum(P2) / n;
    mu2_new = sum(Y .* P2) / sum(P2);
    sig2_new = sqrt(sum((Y-mu2_new).^2 .* P2) / sum(P2));
    
    llh_seq = [llh_seq, log_ll(Y,a1_new,mu1_new,sig1_new,a2_new,mu2_new,sig2_new)];
    % loss = max([abs(a1_new - a1), abs(mu1_new - mu1), abs(sig1_new - sig1), abs(a2_new - a2), abs(mu2_new - mu2), abs(sig2_new - sig2)]);
    loss = max([sqrt((a1_new-a1)^2+(a2_new-a2)^2), sqrt((mu1_new-mu1)^2+(mu2_new-mu2)^2), sqrt((sig1_new-sig1)^2+(sig2_new-sig2)^2)]);
    if loss < eps
        opt_params = [a1_new, mu1_new, sig1_new, a2_new, mu2_new, sig2_new];
        break;
    end
    a1 = a1_new;
    mu1 = mu1_new;
    sig1 = sig1_new;
    a2 = a2_new;
    mu2 = mu2_new;
    sig2 = sig2_new;
end

figure(2);
plot(llh_seq, "Linewidth", 2);
xlabel("m-th iteration");
ylabel("Sum of data log-likelihood");
title("Observed data log-likelihood evolution of Data 1");
% title("Observed data log-likelihood evolution of Data 2");

function L = log_ll(Y, a1, mu1, sig1, a2, mu2, sig2)
    L = sum(log(a1 * normpdf(Y, mu1, sig1) + a2 * normpdf(Y, mu2, sig2)));
end

function [P1, P2] = label_prob(x,a1,mu1,sig1,a2,mu2,sig2)
    P1 = (a1 * normpdf(x, mu1, sig1)) ./ ((a1 * normpdf(x, mu1, sig1)) + (a2 * normpdf(x, mu2, sig2)));
    P2 = 1 - P1;
end