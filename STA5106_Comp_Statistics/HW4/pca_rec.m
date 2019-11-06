% Recover the input image with PCA
% Input:
%   X: The original image.
%   U: PCA directions.
%   d: The number of PCA bases used in reconstruction.
%   img_index: Index of the image we want to reconstruct.
% Output:
%   X_rec: The recovered image.

function X_rec = pca_rec(X, U, d)
    U_proj = U(:, 1:d);
    X_rec = X * U_proj * U_proj';
end