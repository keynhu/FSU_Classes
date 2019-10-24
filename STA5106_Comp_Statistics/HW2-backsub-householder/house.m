% Householder Transformation for a vector
% Input:
%   x: array (m x 1).
% Output:
%   v: array (m x 1). Solution to H * X = norm(X) * e1, where H is the
%   Householder matrix generated by v. (v is normalized s.t. v(1)=1.)
function v = house(x)
    m = size(x,1);
    mu = norm(x,2); % Unify the norm
    v = x;
    if mu ~= 0
        v(2:m) = v(2:m) / (v(1) + sign(v(1)) * mu);
    end
    v(1) = 1;
end
