% for LLE's grid search of hyper-parameter K

clear;

load mid_train.mat
load mid_test.mat

d_seq = 1:40;
% K_seq = [10 15 20 25 30 35 40 45 50];
% K_seq = [10 20 30 40 50];
K_seq = [30 35 40 45 50];
lle_K_correct = zeros(length(d_seq), length(K_seq));
lle_K_runtimes = zeros(length(d_seq), length(K_seq));

for i = 1:length(d_seq)
    for j = 1:length(K_seq)
        d = d_seq(i);
        K = K_seq(j);
        time1 = clock;
        tmp_lle = LLE_NN_ImgCls(Ytrain, Ytest, K, d);
        lle_K_correct(i,j) = tmp_lle;
        time2 = clock;
        lle_K_runtimes(i,j) = etime(time2,time1);
    end
    
end

figure(1); clf;
title("Accuracy Plot of LLE with different K's","Fontsize",12);
xlabel("d (Projected dimension)");
ylabel("Accuracy");
ylim([0,1]);
hold on;
plot(repelem(d_seq,length(K_seq),1)', lle_K_correct);
% legend('K=10', 'K=15', 'K=20', 'K=25', 'K=30', 'K=35', 'K=40', 'K=45', 'K=50');
% legend('K=10', 'K=20', 'K=30', 'K=40', 'K=50');
legend('K=30', 'K=35', 'K=40', 'K=45', 'K=50');

% figure(2);
% title("Runtime Plot of LLE with different K's","Fontsize",12);
% xlabel("d");
% ylabel("Runtimes (sec)");
% hold on;
% p1 = plot(d_seq, pca_runtimes, '-o', "Color", "red");
% hold on;
% p2 = plot(d_seq(d_seq<size(Ytrain,2)), lle_runtimes, '-o', "Color", "green");
% hold on;
% p3 = plot(d_seq, simp_runtimes, '-o', "Color", "blue");
% hold on;
% legend([p1, p2, p3], "PCA", "LLE (K=" + num2str(K) + ")", "SP", "Location", "northeast");