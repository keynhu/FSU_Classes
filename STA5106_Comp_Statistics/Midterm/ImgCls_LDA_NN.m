% Input:
%   Train: Train Image matrix (m x n, m > n) -- m = #Pixels, n = #Images
%   Test: Test Image matrix (m x n, m > n) -- m = #Pixels, n = #Images
%   d: Dimension of PCA projection and LDA projection
% Output:
%   lda_correct: Prediction accuracy of NN after LDA projection
function lda_correct = ImgCls_LDA_NN(Train, Test, d)
    % Step 1: LDA Projection
    [Train_lda, Test_lda] = lda(Train, Test, d);
    % Step 2: Classification with Nearest-neighbor
    lda_testpred = [];
    for i = 1:size(Test,2)
        ldasample = Test_lda(:, i);
        ldanorms = vecnorm(ldasample * ones(1, size(Test,2)) - Train_lda);
        [~, ldamin_ind] = min(ldanorms);
        lda_testpred = [lda_testpred, ceil(ldamin_ind / 5)];
    end

lda_correct = pred_accuracy(lda_testpred);
end

% Input:
%   Train_pack: Train Image matrix (m x n1 x n2) -- m = #Pixels,
%   n1 = #Images_per_class, n2 = #Classes
%   Test: Test Image matrix (m x n1n2) -- m = #Pixels, n1n2 = #Images
%   d: How many principal components are used for recontruction
% Output:
%   Train_lda: Projected train Image matrix (d x n1n2)
%   Test_lda: Projected test Image matrix (d x n1n2)
function [Train_lda, Test_lda] = lda(Train, Test, d)
    Train_pack = reshape(Train, [size(Train,1), 5, 40]); % Not good to put it here, just for convenience
    [~, n1, n2] = size(Train_pack); % (m, n1, n2)
    mu = squeeze(mean(Train_pack, 2)); % (m, n2) Means per class
    S_B = (n2-1) * cov(mu'); % (m, m), between-class scatter matrix
    S_W = 0; % (m, m), within-class scatter matrix
    for i = 1:n2
       S_W = S_W + (n1-1) * cov(squeeze(Train_pack(:,:,i))'); % Each (m,n1)
    end
    [U,D] = eig(S_W \ S_B);
    U1 = U(1:d, :); % (d,m)
    Train_lda = U1 * Train; % (d, n1n2)
    Test_lda = U1 * Test; % (d, n1n2)
end

% Input:
%   correct_ratio: A number in [0,1]. Indicate how many prediction results
%   are correct.
%   k: How many principal components are used for recontruction
% Output:
%   U: Principal component matrix (m x k)
function correct_ratio = pred_accuracy(pred)
    col_num = size(pred,2);
    target = ceil((1:col_num) / 5);
    correct_ratio = sum(pred == target) / col_num;
end