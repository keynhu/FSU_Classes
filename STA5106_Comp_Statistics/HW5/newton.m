% Do Newton-Raphson method to find root to a given real function
% Input:
%   fun: A real function that we want to find the root.
%   dfun: Real function, 1st order derivative of fun.
%   x0: Initial value of x.
%   eps: Absolute change stopping threshold.
% Output:
%   xr: The root to fun.
%   seq: The converging sequences.

% fun = inline("0.9 * sin(x) - x", "x");
% dfun = inline("0.9 * cos(x) - 1", "x");
% [xr, seq] = newton(fun, dfun, pi/4, 1e-6);

function [xr,seq] = newton(fun, dfun, x0, eps)
    x = x0;
    seq = x;
    while true
        x1 = x - fun(x) / dfun(x);
        seq = [seq, x1];
        if abs(x1-x) < eps
            break;
        end
        x = x1;
    end
    xr = x1;
end
