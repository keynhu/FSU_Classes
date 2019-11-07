% PCA/LLE/LDA/SP + kNN, k=1:5, d=10,20,30,40

clear;

load mid_train.mat
load mid_test.mat

pca_knn_correct = [];
lle_knn_correct = [];
lda_knn_correct = [];
simp_knn_correct = [];
pca_runtimes = [];
lle_runtimes = [];
lda_runtimes = [];
simp_runtimes = [];
k_seq = 1:5; % kNN
d = 40; % Adjust projection dimension
K = 45; % LLE

% PCA + kNN
% Use the commented codes to check whether 1-NN performs best in K-dim projection.
%for d = 2:40
%pca_knn_correct = [];
%lle_knn_correct = [];
%simp_knn_correct = [];
for k = k_seq
    time1 = clock;
    tmp_pca = ImgCls_PCA_kNN(Ytrain, Ytest, k, d);
    pca_knn_correct = [pca_knn_correct, tmp_pca];
    time2 = clock;
    pca_runtimes = [pca_runtimes, etime(time2, time1)];
end
    %if max(pca_knn_k_correct) ~= pca_knn_k_correct(1)
    %     fprintf("%i has best performance when there are >1 neighbors.\n", K);
    %end
%end

% SP + kNN
for k = k_seq
    time1 = clock;
    tmp_simp = ImgCls_Simp_kNN(Ytrain, Ytest, k, d);
    simp_knn_correct = [simp_knn_correct, tmp_simp];
    time2 = clock;
    simp_runtimes = [simp_runtimes, etime(time2, time1)];
end

% LLE + kNN
for k = k_seq
    time1 = clock;
    tmp_lle = ImgCls_LLE_kNN(Ytrain, Ytest, K, k, d);
    lle_knn_correct = [lle_knn_correct, tmp_lle];
    time2 = clock;
    lle_runtimes = [lle_runtimes, etime(time2, time1)];
end

% LDA + kNN
% warning("on","last") % To ignore most warnings
for k = k_seq
    time1 = clock;
    tmp_lda = ImgCls_LDA_kNN(Ytrain, Ytest, k, d);
    lda_knn_correct = [lda_knn_correct, tmp_lda];
    time2 = clock;
    lda_runtimes = [lda_runtimes, etime(time2, time1)];
end

figure(1);
title(sprintf("Accuracy Plot, d=%d, kNN classifier", d),"Fontsize",15);
xlabel("k (Number of Neighbors)");
ylabel("Accuracy");
xticks([1 2 3 4 5]);
ylim([0,1]);
hold on;
p1 = plot(k_seq, pca_knn_correct, '-o', "Color", "red");
hold on;
yline(pca_knn_correct(1), "--", "Color", "red");
hold on;
p2 = plot(k_seq, lle_knn_correct, '-o', "Color", "green");
hold on;
yline(lle_knn_correct(1), "--", "Color", "green");
hold on;
p3 = plot(k_seq, lda_knn_correct, '-o', "Color", "blue");
hold on;
yline(lda_knn_correct(1), "--", "Color", "blue");
hold on;
p4 = plot(k_seq, simp_knn_correct, '-o', "Color", "black");
hold on;
yline(simp_knn_correct(1), "--", "Color", "black");
hold on;
lgd = legend([p1, p2, p3, p4], "PCA", "LLE (K=" + num2str(K) + ")", "LDA", "SP", "Location", "southeast");
lgd.FontSize = 10;

% figure(2);
% title("Runtime Plot, d=40, kNN classifier","Fontsize",12);
% xticks([1 2 3 4 5]);
% xlabel("k (Number of Neighbors)");
% ylabel("Runtimes (sec)");
% hold on;
% p1 = plot(k_seq, pca_runtimes, '-o', "Color", "red");
% hold on;
% p2 = plot(k_seq, lle_runtimes, '-o', "Color", "green");
% hold on;
% p3 = plot(k_seq, simp_runtimes, '-o', "Color", "blue");
% hold on;
% legend([p1, p2, p3], "PCA", "LLE (K=" + num2str(K) + ")", "SP", "Location", "northeast");