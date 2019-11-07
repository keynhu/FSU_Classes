clear;

load mid_train.mat
load mid_test.mat

d = 29;
ind = 132;
Cov_mat = cov(Ytrain');
[U, ~, ~] = svd(Cov_mat);
U1 = U(:, 1:d);
sample = Ytest(:, ind);
Image_mat = [sample, U1 * U1' * sample];

figure(1); clf;
set(gcf, 'position', [50, 50, 500, 400]);

subplot(1,2,1); 
I = reshape(Image_mat(:,1),28,23);
imagesc(I);
colormap(gray);
axis equal;   
title(sprintf("Test %d Original", ind), 'fontsize',15);

subplot(1,2,2); 
I = reshape(Image_mat(:,2),28,23);
imagesc(I);
colormap(gray);
axis equal;   
title(sprintf("Test %d Proj (d=%d)", ind, d), 'fontsize',15);