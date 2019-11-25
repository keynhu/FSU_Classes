% Problem 3: Tilted sampling to estimate exponential tail

clear;

a_range = 1:5; % Sequence of a
N_range = [1e3, 1e5, 1e7];
lambda = 5;
est_mat = zeros(length(a_range), length(N_range));
i = 0;
for a = a_range
    i = i + 1;
    j = 0;
    for N = N_range
        j = j + 1;
        data = exprnd(a, 1, N);
        est_mat(i, j) = mean(exp(-(lambda - 1/a) .* data) .* (data >= a)) * a * lambda;
    end
end

% Output
for i = 1:length(a_range)
    sprintf("a = %d, Integral estimate with sample size: \n 1e3: %.6e, 1e5: %.6e, 1e7: %.6e", a_range(i), est_mat(i,:))
end