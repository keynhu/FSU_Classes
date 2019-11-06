% Solve for the principal directions of images
% Input:
%   X: Image matrix (n x m, m > n) -- m = #Pixels, n = #Images
%   d: Number of PCA directions.
% Output:
%   1) Display the first three principal directions of images
%   2) Display the PCA projection of the first image (or any image)

% load hw4_1_data.mat

function [U,U_proj] = pca_image(images, d)
    COV = cov(images);
    [U, ~, ~] = svd(COV);
    U_proj = U(:,1:d);
    %PCA_Image = X(1,:) * U_proj * U_proj';
end
