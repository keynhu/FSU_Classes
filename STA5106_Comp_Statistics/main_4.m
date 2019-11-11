% Problem 4, Exponential RNG

% (a)
n = 200;
X = exprnd(1, [1, n]);
Z = 1;
for i = 2:n
    Z = [Z, X(i) == max(X(1:i))];
end
% (b) + (c)
n = 200;
m = 3000;
YK = zeros(9, m); % Each row aligns to k=0,1,..,8
for j = 1:m
    X = exprnd(1, [1, n]);
    Z = 1;
    Dif = []; % Record the seperated time points in each simulation
    d = 0;
    % -- A simpler way without the for-loop below
    % S = diag(X) * triu(ones(n)); 
    % Z = (X == max(S)); % 'max' takes the maximum of each column
    % P = diff(find(Z))-1; 
    % Y(:,j) = hist(P(P<9), 0:8);
    % - 'triu' takes upper triangular part of a matrix
    % - i-th column of S records observations X1,...,Xi.
    % - Z works same as mine, recording whether the event happens for Xi.
    % - find(Z) records locations of all 1's.
    % - P records all the k-seperated event in this simulation.
    for i = 2:n
        log = (X(i) == max(X(1:i)));
        Z = [Z, log];
        if log % Save Dif and update d
            Dif = [Dif, d];
            d = 0;
        end
        d = d + 1;
    end
    for k = 0:8
        YK(k+1, j) = sum(Dif==k);
    end
end
MeanYK = mean(YK,2);

figure(1);
title("Problem 4 plots");
for k = 1:9
    % Poisson
    pd = makedist('Poisson','lambda', 1/(k+1));
    y = pdf(pd, 0:8);
    % Plot
    subplot(3,3,k)
    histogram(YK(k,:)); hold on;
    plot(0:8, m .* y, "LineWidth", 2); hold on;
    title(sprintf("k = %d", k-1));
end