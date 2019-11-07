% PCA/LLE/LDA/SP + Nearest-Neighbor, d=1:40

clear;

load mid_train.mat
load mid_test.mat

pca_nn_correct = [];
lle_nn_correct = [];
lda_nn_correct = [];
simp_nn_correct = [];
pca_runtimes = [];
lle_runtimes = [];
lda_runtimes = [];
simp_runtimes = [];
%d_seq = 41:30:644;
d_seq = 1:40;
K = 45; % For LLE

% PCA + NN
for d = d_seq
    time1 = clock;
    tmp_pca =ImgCls_PCA_NN(Ytrain, Ytest, d);
    pca_nn_correct = [pca_nn_correct, tmp_pca];
    time2 = clock;
    pca_runtimes = [pca_runtimes, etime(time2,time1)];
end
% Simple + NN
for d = d_seq
    time1 = clock;
    tmp_simp = ImgCls_Simp_NN(Ytrain, Ytest, d);
    simp_nn_correct = [simp_nn_correct, tmp_simp];
    time2 = clock;
    simp_runtimes = [simp_runtimes, etime(time2,time1)];
end
% LLE + NN
for d = d_seq(d_seq<size(Ytrain, 2)) % LLE cannot reduce to d>200
    time1 = clock;
    tmp_lle = ImgCls_LLE_NN(Ytrain, Ytest, K, d);
    lle_nn_correct = [lle_nn_correct, tmp_lle];
    time2 = clock;
    lle_runtimes = [lle_runtimes, etime(time2,time1)];
end
% LDA + NN
% warning("on","last") % To ignore most warnings
for d = d_seq
    time1 = clock;
    tmp_lda = ImgCls_LDA_NN(Ytrain, Ytest, d);
    lda_nn_correct = [lda_nn_correct, tmp_lda];
    time2 = clock;
    lda_runtimes = [lda_runtimes, etime(time2, time1)];
end

figure(1); clf;
title("Accuracy Plot, NN classifier","Fontsize",20);
%title("Accuracy Plot (High dim), NN classifier","Fontsize",20);
xlabel("d (Projected dimension)");
ylabel("Accuracy");
ylim([0,1]);
hold on;
p1 = plot(d_seq, pca_nn_correct, '-o', "Color", "red");
hold on;
p2 = plot(d_seq(d_seq<size(Ytrain,2)), lle_nn_correct, '-o', "Color", "green");
hold on;
p3 = plot(d_seq, lda_nn_correct, '-o', "Color", "blue");
hold on;
p4 = plot(d_seq, simp_nn_correct, '-o', "Color", "black");
hold on;
lgd = legend([p1, p2, p3, p4], "PCA", "LLE (K=" + num2str(K) + ")", "LDA", "SP", "Location", "southeast");
lgd.FontSize = 14;

figure(2); clf;
title("Runtime Plot, NN classifier","Fontsize",20);
%title("Runtime Plot (High dim), NN classifier","Fontsize",20);
xlabel("d");
ylabel("Runtimes (sec)");
hold on;
p1 = plot(d_seq, pca_runtimes, '-o', "Color", "red");
hold on;
p2 = plot(d_seq(d_seq<size(Ytrain,2)), lle_runtimes, '-o', "Color", "green");
hold on;
p3 = plot(d_seq, lda_runtimes, '-o', "Color", "blue");
hold on;
p4 = plot(d_seq, simp_runtimes, '-o', "Color", "black");
hold on;
lgd = legend([p1, p2, p3, p4], "PCA", "LLE (K=" + num2str(K) + ")", "LDA", "SP", "Location", "northeast");
lgd.FontSize = 14;