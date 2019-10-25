% Backward Substitution
% Input: 
%   X: Upper triangular matrix (n x n).
%   y: Response array (n x 1).
% Output: 
%   b: Array (n x 1). Solution to y = X * b.

% Example:
% X = [6 3 9 2; 0 4 6 1; 0 0 8 8; 0 0 0 5];
% y = [1 4 6 1]';

function b = backsub(X, y)
    m = size(X,1);
    n = size(X,2);
    b = zeros(n,1);
    b(n) = y(n) / X(n,n);
    for i = n-1:-1:1
        b(i) = (y(i) - sum(X(i, i+1:n) * b(i+1:n))) / X(i,i);
    end
end
