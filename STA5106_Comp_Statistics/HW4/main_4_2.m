% Problem 4.2, project labeled data with LDA

load hw4_2_data.mat
[~, m, k] = size(X);

% Plot original data
color = ["r", "g", "b", "k", "c"]; % Length m
figure(1); clf;
for i = 1:m
    plot3(squeeze(X(1,i,:)),squeeze(X(2,i,:)),squeeze(X(3,i,:)),"o","Color", color(i));
    hold on;
end
title("3D plot of original data", "FontSize", 15);
% LDA Projection
[U1,Z] = lda(X, 1);
figure(2); clf;
for i = 1:m
    plot(Z(i,:), 1:k, "o", "Color", color(i));
    hold on;
end
title("2D plot of projected data", "FontSize", 15);
ylabel("Sample Index");
xlabel("Value");