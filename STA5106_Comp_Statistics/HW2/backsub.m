% Backward Substitution
% Input: 
%   X: Upper triangular matrix (n x n).
%   y: Response array (n x 1).
% Output: 
%   b: Array (n x 1). Solution to y = X * b.
function b = backsub(X, y)
    m = size(X,1);
    n = size(X,2);
    b = zeros(n,1);
    b(n) = y(n) / X(n,n);
    for i = n-1:-1:1
        b(i) = (y(i) - sum(X(i, i+1:n) * b(i+1:n))) / X(i,i);
    end
end
