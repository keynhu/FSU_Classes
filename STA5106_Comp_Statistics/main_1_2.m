% Problem 1,2, Uniform RNG

x0 = 100;
Y1 = unif_gen(500, 2^13-1, 17, x0);
Y2 = unif_gen(500, 2^13-1, 85, x0);

figure(1); clf;
%histogram(Y1);
hist(Y1);
title("Histogram of samples with m = 2^{13}-1, a = 17");
figure(2); clf;
scatter(Y1(1:end-1), Y1(2:end), ".");
xlabel("Y_i");
ylabel("Y_{i+1}");
title("Plot of (Y_i, Y_{i+1}) with m = 2^{13}-1, a = 17");
figure(3); clf;
%histogram(Y2);
hist(Y2);
title("Histogram of samples with m = 2^{13}-1, a = 85");
figure(4); clf;
scatter(Y2(1:end-1), Y2(2:end), ".");
xlabel("Y_i");
ylabel("Y_{i+1}");
title("Plot of (Y_i, Y_{i+1}) with m = 2^{13}-1, a = 85");