% Plot a test image and its closest neighbor under 4 projections.

clear;

load mid_train.mat
load mid_test.mat

d = 20; % Reduced dimension
K = 45; % For LLE
ind = 56; % Test image index
[pca_vec,pca_ind] = pca_pred(Ytrain, Ytest, d, ind);
[lle_vec, lle_ind] = lle_pred(Ytrain, Ytest, d, K, ind);
[lda_vec, lda_ind] = lda_pred(Ytrain, Ytest, d, ind);
[sp_vec, sp_ind] = sp_pred(Ytrain, Ytest, d, ind);
Image_mat = [Ytest(:, ind), pca_vec, lle_vec, lda_vec, sp_vec];
images_plot(Image_mat, [string('Test'),'PCA', 'LLE', 'LDA', 'SP'], [ind, pca_ind, lle_ind, lda_ind, sp_ind], 1);

function [min_vec, min_ind] = pca_pred(Train, Test, d, index)
    Cov_mat = cov(Train');
    [U, ~, ~] = svd(Cov_mat);
    U1 = U(:, 1:d);
    Train_pca = U1' * Train;
    Test_pca = U1' * Test;
    sample = Test_pca(:, index);
    norms = vecnorm(sample * ones(1, size(Test,2)) - Train_pca);
    [~, min_ind] = min(norms);
    min_vec = Train(:, min_ind);
end

function [min_vec, min_ind] = lle_pred(Train, Test, d, K, index)
    [~,n] = size(Train); % Dimension; Number of training data
    W = zeros(n); % Weight matrix
    for i = 1:n
        sample = Train(:, i);
        tmp_norms = vecnorm(sample * ones(1, n) - Train);
        [~, sort_ind] = sort(tmp_norms);
        tmp_neighbors_ind = sort_ind(2:(1+K)); % The closest must be itself
        tmp_neighbors = Train(:, tmp_neighbors_ind);
        tmp_Gsolve = sample * ones(1, K) - tmp_neighbors;
        tmp_G = tmp_Gsolve' * tmp_Gsolve;
        tmp_Ginv = inv(tmp_G);
        tmp_w = sum(tmp_Ginv, 1) / sum(tmp_Ginv, "all");
        W(i, tmp_neighbors_ind) = tmp_w;
    end
    M = (eye(n) - W)' * (eye(n) - W);
    [V, ~] = eig(M);
    Train_lle = V(:, (2: (1+d)))';
    [~, nt] = size(Test);
    ts_W = zeros(nt, n);
    for i = 1:nt
        ts_sample = Test(:, i);
        ts_tmp_norms = vecnorm(ts_sample * ones(1, n) - Train);
        [~, ts_sort_ind] = sort(ts_tmp_norms);
        ts_tmp_neighbors_ind = ts_sort_ind(2:(1+K)); % The closest must be itself, so start from the 2nd smallest
        ts_tmp_neighbors = Train(:, ts_tmp_neighbors_ind);
        ts_tmp_Gsolve = ts_sample * ones(1, K) - ts_tmp_neighbors;
        ts_tmp_G = ts_tmp_Gsolve' * ts_tmp_Gsolve;
        ts_tmp_Ginv = inv(ts_tmp_G);
        ts_tmp_w = sum(ts_tmp_Ginv, 1) / sum(ts_tmp_Ginv, "all");
        ts_W(i, ts_tmp_neighbors_ind) = ts_tmp_w;
    end
    Test_lle = ts_W * Train_lle';
    Test_lle = Test_lle';
    sample = Test_lle(:, index);
    norms = vecnorm(sample * ones(1, size(Test,2)) - Train_lle);
    [~, min_ind] = min(norms);
    min_vec = Train(:, min_ind);
end

function [min_vec, min_ind] = lda_pred(Train, Test, d, index)
    Train_pack = reshape(Train, [size(Train,1), 5, 40]); % Not good to put it here, just for convenience
    [~, n1, n2] = size(Train_pack); % (m, n1, n2)
    mu = squeeze(mean(Train_pack, 2)); % (m, n2) Means per class
    S_B = (n2-1) * cov(mu'); % (m, m), between-class scatter matrix
    S_W = 0; % (m, m), within-class scatter matrix
    for i = 1:n2
       S_W = S_W + (n1-1) * cov(squeeze(Train_pack(:,:,i))'); % Each (m,n1)
    end
    [U,~] = eig(S_W \ S_B);
    U1 = U(1:d, :);
    Train_lda = U1 * Train;
    Test_lda = U1 * Test;
    sample = Test_lda(:, index);
    norms = vecnorm(sample * ones(1, size(Test,2)) - Train_lda);
    [~, min_ind] = min(norms);
    min_vec = Train(:, min_ind);
end

function [min_vec,min_ind] = sp_pred(Train, Test, d, index)
    Train_sp = Train(1:d, :);
    Test_sp = Test(1:d, :);
    sample = Test_sp(:, index);
    norms = vecnorm(sample * ones(1, size(Test,2)) - Train_sp);
    [~, min_ind] = min(norms);
    min_vec = Train(:, min_ind);
end