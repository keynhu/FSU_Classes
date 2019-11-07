% Input:
%   Train: Train Image matrix (m x n, m > n) -- m = #Pixels, n = #Images
%   Test: Test Image matrix (m x n, m > n) -- m = #Pixels, n = #Images
%   k: Number of neighbors for classification
%   d: Dimension of Simple projection
% Output:
%   simp_correct: Prediction accuracy of NN after simple projection
function simp_correct = ImgCls_Simp_kNN(Train, Test, k, d)
    % Step 1: Projection
    Train_simp = Train(1:d, :);
    Test_simp = Test(1:d, :);
    % Step 2: Classification with Nearest-neighbor
    simp_testpred = [];
    for i = 1:size(Test,2)
        simpsample = Test_simp(:, i);
        simpnorms = vecnorm(simpsample * ones(1, size(Test,2)) - Train_simp);
        [~, simp_sort_ind] = sort(simpnorms);
        simp_count_ind = simp_sort_ind(1:k);
        simp_count_cls = ceil(simp_count_ind / 5);
        simp_testpred = [simp_testpred, mode(simp_count_cls)];
    end
% Step 3: Evaluate the prediction accuracy    
simp_correct = pred_accuracy(simp_testpred);
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