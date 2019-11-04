% Scatter plot and SSE evolution plot of Kmeans

% Input:
%   data: data matrix (m x n) -- m = #Dim, n = #Samples
%   labels: label vector (1 x n), each corresponds to a sample.
%   sse_seq: Evolution sequence of Sum-of-Squared-Error.
%   name: Name of the dataset.
% Output:
%   1) Scatter plot with labels of given data.
%   2) Evolution of Sum-of-Squared-Error (SSE) v.s. iteration index.
function kmeans_plot(data, labels, sse_seq, name)
    figure(1); clf;
    gscatter(data(1,:), data(2,:), labels);
    title(sprintf("Labelled observations of %s", name), "FontSize", 15);
    xlabel("Yn (dim 1)");
    ylabel("Yn (dim 2)");
    
    figure(2); clf;
    plot(sse_seq, "Color", "red", "LineWidth", 2);
    title(sprintf("Kmeans SSE evolution of %s", name), "FontSize", 15);
    xticks(1:length(sse_seq));
    xlabel("Iteration");
    ylabel("Sum of Squared Error");
end