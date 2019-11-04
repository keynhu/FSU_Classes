clear;

% load hw6_2_data1.mat
load hw6_2_data2.mat

k = 2;
%rng(2019);
[labels, sse_seq] = kmeans(Y, k);
cat_Y = [1:500;Y];
% kmeans_plot(cat_Y, labels, sse_seq, "Data 1 (HW6)");
% kmeans_plot(cat_Y, labels, sse_seq, "Data 2 (HW6)");
% name = "Data 1";
name = "Data 2";
Y1 = Y(labels==1);
Y2 = Y(labels==2);
mu1 = mean(Y1);
mu2 = mean(Y2);
var1 = var(Y1);
var2 = var(Y2);
alp1 = length(Y1) / length(Y);
alp2 = length(Y2) / length(Y);
sprintf("%s -- Kmeans: \nClass 1: mean %.4f, variance %.4f, proportion %.4f,\nClass 2: mean %.4f, variance %.4f, proportion %.4f", name, mu1, var1, alp1, mu2, var2, alp2)

% load hw7_1_data1.mat
% load hw7_1_data2.mat

% k = 5;
% rng(2019);
% [labels, sse_seq] = kmeans(Yn, k);
% kmeans_plot(Yn, labels, sse_seq, "Data 1");
% kmeans_plot(Yn, labels, sse_seq, "Data 2");