% K-means clustering

% load hw7_1_data1.mat
% load hw7_1_data2.mat

% Input: 
%   data: data matrix (m x n) -- m = #Dim, n = #Samples
%   k:  #Clusters given by the user
% Output:
%   labels: label vector (1 x n), each corresponds to a sample.
%   sse_seq: Evolution sequence of Sum-of-Squared-Error.
function [labels, sse_seq] = kmeans(data, k)
    [m, n] = size(data);
    labels = zeros(1,n);
    sse_seq = [];
    mul_data = repmat(data, 1, 1, k); % (m, n) -> (m, n, k)
    centers = randn(m,k);
    % centers = randn(m,k) + mean(data,2);
    % centers = var(data,0,2) .* randn(m,k) + mean(data,2); % (), follow variances and means along each dim of original data
    while true
        mul_centers = repmat(reshape(centers, [m,1,k]), 1, n, 1); % (m,k) -> (m, n, k)
        distances = vecnorm(mul_data - mul_centers, 2, 1); % (1,n,k). 2 is L2-norm, 1 is first dimension.
        [~, label_new] = min(distances, [], 3); % (1, n)
        if label_new == labels
            break;
        end
        labels = label_new;
        sse = 0;
        for ks = 1:k
            data_k = data(:,label_new==ks);
            centers(:,ks) = mean(data_k, 2);
            sse = sse + sum(vecnorm(data_k - centers(:,ks)).^2);
        end 
        sse_seq = [sse_seq, sse];
    end
end
