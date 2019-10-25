% Householder Transformation - Row Iteration
% Input:
%   X: Matrix (m x n, m > n)
%   v: householder vector array (n x 1)
% Output:
%   X_new: First-row-transformed matrix

% Example
% X = [1.4 4.5 6.5; 5.8 3.2 7.3; 2.3 -2.6 8.2; 8.1 -5.8 -8; 9 0.3 1.5];

function X_new = rowhouse(X,v)
    X_new = X - 2 / norm(v)^2 * v * v' * X;
end