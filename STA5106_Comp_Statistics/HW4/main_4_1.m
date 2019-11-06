% Problem 4.1, show images of PCA directions and reconstructions

% (a)
load hw4_1_data.mat
d = 3;
[U,U_proj] = pca_image(X, d);
for i = 1:d
    figure(i); clf;
    image_vec_show(U_proj(:,i)); hold on;
    title(sprintf("Image of PCA direction %d", i), "FontSize", 15);
end
% (b)
img_index = 1;
img_rec1 = pca_rec(X(img_index, :), U, 50);
figure(d+1); clf;
image_vec_show(img_rec1); hold on;
title(sprintf("Reconstruction of Image %d with d = %d", img_index, 50), "FontSize", 15);
img_rec2 = pca_rec(X(img_index, :), U, 100);
figure(d+2); clf;
image_vec_show(img_rec2); hold on;
title(sprintf("Reconstruction of Image %d with d = %d", img_index, 100), "FontSize", 15);