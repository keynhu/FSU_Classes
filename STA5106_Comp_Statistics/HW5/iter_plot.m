% Plot converging sequences of Simple Iteration and Newton-Raphson
% method.
% Input:
%   fun: A real function that we want to find the root.
%   dfun: Real function, 1st order derivative of fun.
%   x0: Initial value of x.
%   eps: Absolute change stopping threshold.
% Output:
%   Display the two converging sequences

% fun = inline("0.9 * sin(x) - x", "x");
% dfun = inline("0.9 * cos(x) - 1", "x");
% iter_plot(fun, dfun, pi/4, 1e-6)

function iter_plot(fun, dfun, x0, eps)
    % SSE v.s. Iteration index
    figure(1); clf;
    title("SSE of two converging sequences","Fontsize",15);
    xlabel("X");
    ylabel("Sum of Squared Error (SSE)");    
    hold on;
    [~,seq1] = simple_iter(fun, x0, eps);
    [~,seq2] = newton(fun, dfun, x0, eps);
    p1 = plot(seq1.^2,"Color","b","MarkerSize",12);
    hold on;
    p2 = plot(seq2.^2,"--","Color","r");
    legend([p1,p2],"Simple Iteration", "Newton Method");
    % Compare the converging sequences on function graph directly
    figure(2); clf;
    t = 0:0.01:1;
    plot(t,fun(t));
    title("Converging sequences of two methods","Fontsize",15);
    xlabel("X");
    ylabel("fun");    
    hold on;
    [~,seq1] = simple_iter(fun, x0, eps);
    [~,seq2] = newton(fun, dfun, x0, eps);
    p1 = plot(seq1, fun(seq1),".","Color","b","MarkerSize",12);
    hold on;
    p2 = plot(seq2, fun(seq2),"*","Color","r");
    legend([p1,p2],"Simple Iteration", "Newton Method");
end