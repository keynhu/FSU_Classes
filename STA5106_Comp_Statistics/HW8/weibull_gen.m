% Generate samples from Weibull(a,b) distribution.

% Input:
% n: Number of Weibull(a,b) random samples.
% a: Parameter 1 of Weibull distribution.
% b: Parameter 2 of Weibull distribution.
% Output:
% Y: A length-n vector, generated psuedo-random numbers.
function Y = weibull_gen(n, a, b)
    U = rand(1,n);
    Y = (1/a * log(1 ./ U)).^(1/b);
end
