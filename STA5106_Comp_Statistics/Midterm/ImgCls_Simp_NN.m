% Input:
%   Train: Train Image matrix (m x n, m > n) -- m = #Pixels, n = #Images
%   Test: Test Image matrix (m x n, m > n) -- m = #Pixels, n = #Images
%   d: Dimension of Simple projection
% Output:
%   simp_correct: Prediction accuracy of NN after simple projection
function simp_correct = ImgCls_Simp_NN(Train, Test, d)
    % Step 1: Projection
    Train_simp = Train(1:d, :);
    Test_simp = Test(1:d, :);
    % Step 2: Classification with Nearest-neighbor
    simp_testpred = [];
    for i = 1:size(Test,2)
        simpsample = Test_simp(:, i);
        simpnorms = vecnorm(simpsample * ones(1, size(Test,2)) - Train_simp);
        [~, simpmin_ind] = min(simpnorms);
        simp_testpred = [simp_testpred, ceil(simpmin_ind / 5)];
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