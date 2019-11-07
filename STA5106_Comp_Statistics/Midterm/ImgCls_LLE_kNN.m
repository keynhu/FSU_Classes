% Input:
%   Train: Train Image matrix (m x n, m > n) -- m = #Pixels, n = #Images
%   Test: Test Image matrix (m x n, m > n) -- m = #Pixels, n = #Images
%   K: Number of local neighbors (LLE)
%   k: Number of Neighbors (kNN)
%   d: Dimension of LLE projection
% Output:
%   lle_correct: Prediction accuracy of NN after LLE projection
function lle_correct = ImgCls_LLE_kNN(Train, Test, K, k, d)
    % Step 1: Projection
    [Train_lle, Test_lle] = lle(Train, Test, K, d);
    % Step 2: Classification with Nearest-neighbor
    lle_testpred = [];
    for i = 1:size(Test_lle,2)
        llesample = Test_lle(:,i);
        llenorms = vecnorm(llesample * ones(1, size(Test_lle, 2)) - Train_lle);
        [~, lle_sort_ind] = sort(llenorms);
        lle_count_ind = lle_sort_ind(1:k);
        lle_count_cls = ceil(lle_count_ind / 5);
        lle_testpred = [lle_testpred, mode(lle_count_cls)];
    end
% Step 3: Evaluate the prediction accuracy
lle_correct = pred_accuracy(lle_testpred);
end

% Input:
%   Train: Train Image matrix (m x n, m > n) -- m = #Pixels, n = #Images
%   Test: Test Image matrix (m x n, m > n) -- m = #Pixels, n = #Images
%   K: Number of local neighbors
%   d: Dimension of LLE projection
% Output:
%   Train_lle: Projected train Image matrix (d x n)
%   Test_lle: Projected test Image matrix (d x n)
function [Train_lle, Test_lle] = lle(Train, Test, K, d)
    [~,n] = size(Train); % Dimension; Number of training data
    W = zeros(n); % Weight matrix
    % Step 1: Solve for local neighbors and weights W for later construction
    for i = 1:n
        sample = Train(:, i);
        tmp_norms = vecnorm(sample * ones(1, n) - Train);
        [~, sort_ind] = sort(tmp_norms);
        tmp_neighbors_ind = sort_ind(2:(1+K)); % The closest must be itself
        %neigh_ind(i,:) = tmp_neighbors_ind;
        tmp_neighbors = Train(:, tmp_neighbors_ind);
        tmp_Gsolve = sample * ones(1, K) - tmp_neighbors;
        tmp_G = tmp_Gsolve' * tmp_Gsolve;
        tmp_Ginv = inv(tmp_G);
        tmp_w = sum(tmp_Ginv, 1) / sum(tmp_Ginv, "all");
        W(i, tmp_neighbors_ind) = tmp_w;
    end
    % Step 2: Solve for reduced dimension embedding Y's
    % cite1: http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.110.7308&rep=rep1&type=pdf
    % cite2: https://www-users.cs.umn.edu/~saad/PDF/umsi-2009-31.pdf
    M = (eye(n) - W)' * (eye(n) - W);
    [V, ~] = eig(M);
    Train_lle = V(:, (2: (1+d)))';
    % Step 3: Project test data with LLE
    [~, nt] = size(Test);
    ts_W = zeros(nt, n);
    for i = 1:nt
        ts_sample = Test(:, i);
        ts_tmp_norms = vecnorm(ts_sample * ones(1, n) - Train);
        [~, ts_sort_ind] = sort(ts_tmp_norms);
        ts_tmp_neighbors_ind = ts_sort_ind(2:(1+K)); % The closest must be itself, so start from the 2nd smallest
        %neigh_ind(i,:) = tmp_neighbors_ind;
        ts_tmp_neighbors = Train(:, ts_tmp_neighbors_ind);
        ts_tmp_Gsolve = ts_sample * ones(1, K) - ts_tmp_neighbors;
        ts_tmp_G = ts_tmp_Gsolve' * ts_tmp_Gsolve;
        ts_tmp_Ginv = inv(ts_tmp_G);
        ts_tmp_w = sum(ts_tmp_Ginv, 1) / sum(ts_tmp_Ginv, "all");
        ts_W(i, ts_tmp_neighbors_ind) = ts_tmp_w;
    end
    Test_lle = ts_W * Train_lle';
    Test_lle = Test_lle';
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