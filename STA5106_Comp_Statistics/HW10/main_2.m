% Problem 2: Tilted sampling to estimate standard normal tail

clear;

a_range = 1:5; % Sequence of a
N_range = [1e3, 1e5, 1e7];
est_mat = zeros(length(a_range), length(N_range));
i = 0;
for a = a_range
    i = i + 1;
    j = 0;
    for N = N_range
        j = j + 1;
        data = randn(1,N) + a;
        est_mat(i, j) = mean(exp(a^2 / 2 - a .* data) .* (data >= a));
    end
end

% Output
for i = 1:length(a_range)
    sprintf("a = %d, Integral estimate with sample size: \n 1e3: %.6e, 1e5: %.6e, 1e7: %.6e", a_range(i), est_mat(i,:))
end

% Plot
% figure(1); clf;
% for i = 1:length(a_range)
%     hold on;
%     plot([3, 5, 7], est_mat(i,:), 'LineWidth', 2);
% end
% title("Problem 2 - Tilted sampling estimate");
% xlabel("Sample size");
% ylabel("Estimate");
% legend("a=1", "a=2", "a=3", "a=4", "a=5");