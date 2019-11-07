% Given a test image, plot its 5 nearest neighbors with PCA projection.

clear;

load mid_train.mat
load mid_test.mat

d = 40; % Reduced dimension
k = 5; % For KNN
ind = 152; % Test image index
[k_vecs,k_inds] = pca_k_pred(Ytrain, Ytest, d, k, ind);
Image_mat = [Ytest(:, ind), k_vecs];
images_plot(Image_mat, [string('Test:'),'1st:', '2nd:', '3rd:', '4th:', '5th:'], [ind, k_inds], 1);

function [min_vecs, min_inds] = pca_k_pred(Train, Test, d, k, index)
    Cov_mat = cov(Train');
    [U, ~, ~] = svd(Cov_mat);
    U1 = U(:, 1:d);
    Train_pca = U1' * Train;
    Test_pca = U1' * Test;
    sample = Test_pca(:, index);
    norms = vecnorm(sample * ones(1, size(Test,2)) - Train_pca);
    [~, sort_ind] = sort(norms);
    min_inds = sort_ind(1:k);
    min_vecs = Train(:, min_inds);
end