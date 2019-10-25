% Linear Regression with Householder Transformation & Back Substitution
% Input:
%   X: Feature, Matrix (m x n, m > n)
%   y: Response, Vector (n x 1)
% Output:
%   b: Solution to equation y = X * b.

% X = [5 0 9 3; 3 6 8 9; 4 4 9 6; 0 3 1 8; 2 8 2 3];
% y = [20 17 32 10 12]';

function b = multilinreg(X,y)
    [m,n] = size(X);
    X_new = X;
    y_new = y;
    for i = 1:n
        v = house(X_new(i:m, i));
        X_new(i:m, i:n) = rowhouse(X_new(i:m, i:n), v);
        y_new(i:m) = y_new(i:m) - 2/norm(v)^2 * v' * y_new(i:m) * v; 
    end
    b = backsub(X_new,y_new);
end
