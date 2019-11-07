% Input:
%   Train: Train Image matrix (m x n, m > n) -- m = #Pixels, n = #Images
%   Test: Test Image matrix (m x n, m > n) -- m = #Pixels, n = #Images
%   k: Number of neighbors for classification
%   d: Dimension of PCA projection
% Output:
%   pca_correct: Prediction accuracy of NN after PCA projection
%   simp_correct: Prediction accuracy of NN after simple projection
function pca_correct = ImgCls_PCA_kNN(Train, Test, k, d)
    % Step 1: Projection
    [Train_pca, Test_pca] = pca(Train, Test, d);
    % Step 2: Classification with Nearest-neighbor
    pca_testpred = [];
    for i = 1:size(Test,2)
        pcasample = Test_pca(:, i);
        pcanorms = vecnorm(pcasample * ones(1, size(Test,2)) - Train_pca);
        [~, pca_sort_ind] = sort(pcanorms);
        pca_count_ind = pca_sort_ind(1:k);
        pca_count_cls = ceil(pca_count_ind / 5);
        pca_testpred = [pca_testpred, mode(pca_count_cls)];
        % [~, pcamin_ind] = min(pcanorms);
        % pca_testpred = [pca_testpred, pcamin_ind];
    end

pca_correct = pred_accuracy(pca_testpred);
end

% Input:
%   Train: Train Image matrix (m x n, m > n) -- m = #Pixels, n = #Images
%   Test: Test Image matrix (m x n, m > n) -- m = #Pixels, n = #Images
%   d: Dimension of PCA projection
% Output:
%   Train_pca: Projected train Image matrix (d x n)
%   Test_pca: Projected test Image matrix (d x n)
function [Train_pca, Test_pca] = pca(Train, Test, d)
    Cov_mat = cov(Train');
    [U, ~, ~] = svd(Cov_mat);
    U1 = U(:, 1:d);
    Train_pca = U1' * Train;
    Test_pca = U1' * Test;
end

% Input:
%   pred: Predictions towards test data
% Output:
%   correct_ratio: A number in [0,1]. Indicate how many prediction results
%   are correct.
function correct_ratio = pred_accuracy(pred)
    col_num = size(pred,2);
    target = ceil((1:col_num) / 5);
    correct_ratio = sum(pred == target) / col_num;
end