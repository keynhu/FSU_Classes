load hw5_3_data.mat

d_logll = inline("sum(2 ./ (1+exp(-(X-theta))) - 1)", "X", "theta");
dd_logll = inline("-2 * sum(exp(-(X-theta)) ./ (1+exp(-(X-theta)).^2))", "X", "theta");
% d_logll = @(X,theta) sum(2 ./ (1+exp(-(X-theta))) - 1);
% dd_logll = @(X,theta) -2 * sum(exp(-(X-theta)) ./ (1+exp(-(X-theta)).^2));
[opt_theta, seq] = newton_n(d_logll, dd_logll, X, 7, 1e-6);

function [xr,seq] = newton_n(fun, dfun, X, x0, eps)
    x = x0;
    seq = x;
    while true
        x1 = x - fun(X, x) / dfun(X, x);
        seq = [seq, x1];
        if abs(x1-x) < eps
            break;
        end
        x = x1;
    end
    xr = x1;
end

% function l = d_logll(X, theta) 
%     %load("hw5_3_data.mat", "X")
%     l = sum(2 ./ (1+exp(-(X-theta))) - 1);
% end
% 
% function l = dd_logll(X, theta)
%     %load("hw5_3_data.mat", "X")
%     l = -2 * sum(exp(-(X-theta)) ./ (1+exp(-(X-theta)).^2));
% end