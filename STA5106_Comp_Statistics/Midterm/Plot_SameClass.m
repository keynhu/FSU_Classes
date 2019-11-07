% Given a test image, plot the 5 images from its class.

clear;

load mid_train.mat
load mid_test.mat

ind = 182; % Test image index
cls_ind = ceil(ind / 5);
train_inds = (5*cls_ind-4):(5*cls_ind);
Image_mat = [Ytest(:, ind), Ytrain(:, train_inds)];
images_plot(Image_mat, [string('Test:'),'1st:', '2nd:', '3rd:', '4th:', '5th:'], [ind, train_inds], 1);