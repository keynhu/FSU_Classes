% Linear Regression with PCA
% Input£º
%   X: Feature, Matrix (m x n, m > n)
%   y: Response, Vector (n x 1)
%   d: Number of PCA components
% Output:
%   b: Solution to equation y = X * b.
%   sse: Sum of squared error of the solution.
%   cum_var: Cumulative variance of principal components.

% load hw3_3_data
% d = 10;

function [b, sse, cum_var] = pca_linreg(X,y,d)
    COV_X = cov(X);
    [U, Sig, ~] = svd(COV_X);
    U1 = U(:, 1:d);
    X1 = X * U1; % Transformed data
    b = multilinreg(X1, y);
    cum_var = cumsum(diag(Sig));
    sse = norm(y - X1 * b)^2;
    % d = find(cum_var > cum_var(end) * 0.95, 1); % Number of PCs that
    % captures >95% of the variances
end
