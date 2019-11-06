fun = inline("x^5 - 4.5 * x^4 + 4.55 * x^3 + 2.675 * x^2 - 3.3 * x - 1.4375", "x");
dfun = inline("5 * x^4 - 18 * x^3 + 13.65 * x^2 + 5.35 * x - 3.3", "x");
[xr, seq] = newton(fun, dfun, -0.6, 1e-6);

diff_seq = abs(diff(seq));
diff_seq_ratio = [];
for i = 1:length(diff_seq)-1
    diff_seq_ratio = [diff_seq_ratio, diff_seq(i+1)/diff_seq(i)];
end
diff_seq_ratio