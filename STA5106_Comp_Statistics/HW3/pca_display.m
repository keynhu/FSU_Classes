% Display the principal direction of 2D data
% Input:
%   X: Feature matrix -- n = #Subject, m = #Feature
% Output:
%   1) Display the scatter plot of X.
%   2) Display the 2D principal directions of X on the scatter plot.
%   3) Return variance of the first PC, as well as its ratio in total variance.

% X = [15 16 12 14 13 15 16 21 12 11 19 14 13 14 16 17 12 16; 13 11 13 12 9
% 14 12 16 9 8 15 13 15 13 12 16 11 9];

function [first_pc_var, first_pc_ratio] = pca_display(X)
    % Plot the raw data in scatter plot
    figure(1);
    plot(X(1,:), X(2,:), ".", "markersize", 20);
    title("Student Experiment Data", "fontsize", 15);
    xlabel("First Trial (min)"');
    ylabel("Second Trial (min)");
    % Conduct PCA
    COV_X = cov(X');
    [U, Sig, ~] = svd(COV_X);
    % Plot the principal directions on original raw data
    figure(1);
    hold on;
    first_len = 2 * sqrt(Sig(1,1)); % 2 times of standard deviation
    second_len = 2 * sqrt(Sig(2,2));
    m_X = mean(X');
    plot(first_len * [-U(1,1), U(1,1)] + m_X(1), first_len * [-U(2,1), U(2,1)] + m_X(2), ...
        'g', 'linewidth', 2); % First Principal Direction, Z1 = U11 * X1 + U21 * X2
    plot(second_len * [-U(1,2), U(1,2)] + m_X(1), second_len * [-U(2,2), U(2,2)] + m_X(2), ...
        'g', 'linewidth', 2); % Second Principal Direction, Z1 = U12 * X1 + U22 * X2
    
    % Compute variance
    total_variance = trace(COV_X);
    first_pc_ratio = Sig(1,1) / total_variance;
    first_pc_var = Sig(1,1);
end
