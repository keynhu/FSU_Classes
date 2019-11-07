% Plot a test image and reconstruct it under 4 projections.

clear;

load mid_train.mat
load mid_test.mat

d = 40; % Projection dimension
ind = 56; % Test image index
pca_vec = pca_rec(Ytrain, Ytest, d, ind);
lda_vec = lda_rec(Ytrain, Ytest, d, ind);
sp_vec = sp_rec(Ytrain, Ytest, d, ind);
Image_mat = [Ytest(:, ind), pca_vec, lda_vec, sp_vec];
images_plot(Image_mat, [string(sprintf('Test: %d', ind)),'PCA', 'LDA', 'SP'], [' ', ' ', ' ', ' '], 1);

function rec_vec = pca_rec(Train, Test, d, index)
    Cov_mat = cov(Train');
    [U, ~, ~] = svd(Cov_mat);
    U1 = U(:, 1:d);
    rec_vec = U1 * U1' * Test(:, index);
end

function rec_vec = lda_rec(Train, Test, d, index)
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
    rec_vec = abs(U1' * U1 * Test(:, index)); % Avoid complex values
end

function rec_vec = sp_rec(Train, Test, d, index)
    sample = Test(:, index);
    rec_vec = [sample(1:d); zeros(size(Test,1)-d, 1)];
end