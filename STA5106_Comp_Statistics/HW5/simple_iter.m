% Do simple iteration to find root to a given real function
% Input:
%   fun: A real function that we want to find the root.
%   x0: Initial value of x.
%   eps: Absolute change stopping threshold.
% Output:
%   xr: The root to fun.
%   seq: The converging sequences.

% fun = inline("0.9 * sin(x) - x", "x");
% [xs, seq] = simple_iter(fun, pi/4, 1e-6)

function [xr,seq] = simple_iter(fun, x0, eps)
    x = x0;
    seq = [x];
    while true
        x1 = x + fun(x);
        seq = [seq, x1];
        if abs(x1-x) < eps
            break
        end
        x = x1;
    end
    xr = x1;
end