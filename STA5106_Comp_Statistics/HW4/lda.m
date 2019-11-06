% Dimension Reduction by Linear Discriminant Analysis (LDA)
% Input:
%   X: Data (n x m x k). -- n = #Dim, m = #Groups, k = #Samples (per group)
%   d: Number of LDA base.
% Output:
%   U: :LDA base matrix.
%   Z: Projection of X by the first d columns of U.

% load hw4_2_data.mat

function [U,Z] = lda(X, d)
    [~,m,k] = size(X); 
    mu = mean(X,3); % Mean of each class, (n x m)
    tot_mu = mean(mu,2); % Total mean (n x 1)
    S_B = 0;
    S_W = 0;
    for i = 1:m
        S_B = S_B + (mu(:,i) - tot_mu) * (mu(:,i) - tot_mu)';
    end
    for i = 1:m
        for j = 1:k
            S_W = S_W + (X(:,i,j) - mu(:,i)) * (X(:,i,j) - mu(:,i))';
        end
    end
% Another way to write
%     S_B = (m-1) * cov(mu');
%     S_W = 0;
%     for i = 1:m
%        S_W = S_W + (k-1) * cov(squeeze(X(:,i,:))');
%     end
    [U,~] = eigs(S_B, S_W);
    U1 = U(:,1:d);
    Z = zeros(size(X,2), size(X,3));
    for i = 1:m
        for j = 1:k
            Z(i,j) = U1' * X(:,i,j);
        end
    end
end
