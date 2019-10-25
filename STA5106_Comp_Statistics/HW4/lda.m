% Dimension Reduction by Linear Discriminant Analysis (LDA)
% Input:
%   X: Data (n x m x k) -- n = #Dim, m = #Groups, k = #Samples (per group)
% Output:
%   U1: First principal component (first column of U)
%   Z: Projection of X by U1

% load hw4_2_data.mat

function [U1,Z] = lda(X)
    [n,m,k] = size(X); 
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
    U1 = U(:,1);
    Z = zeros(size(X));
    for i = 1:m
        for j = 1:k
            Z(:,i,j) = project(X(:,i,j), U, 1);
        end
    end
end
