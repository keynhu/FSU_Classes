Human face recognition with dimension reduction techniques.  
(Train images: 40 classes, 5 samples each, size: 28 x 23. Same as test images.)  
(Dimension Reduction: PCA, LLE, LDA, Simple.)  
(Classification: NN, kNN.)  

**ImgCls_LDA_NN.m:** Function. Reduce data dimension with Linear Discriminant Analysis (LDA), then classify with NN.  
**ImgCls_LDA_kNN.m:**	Function. Reduce data dimension with LDA, then classify with kNN (k given).  
**ImgCls_LLE_NN.m:** Function. Reduce data dimension with Locally Linear Embedding (LLE) (#Neighbor K given), then classify with NN.  
**ImgCls_LLE_kNN.m:** Function. Reduce data dimension with LLE (#Neighbor K given), then classify with kNN (k given).  
**ImgCls_PCA_NN.m:** Function. Reduce data dimension with Principal Component Analysis (PCA), then classify with NN.  
**ImgCls_PCA_kNN.m:** Function. Reduce data dimension with PCA, then classify with kNN (k given).  
**ImgCls_Simp_NN.m:** Function. Reduce data dimension with Simple Projection (SP), then classify with NN.  
**ImgCls_Simp_kNN.m:** Function. Reduce data dimension with SP, then classify with kNN (k given).  
**P1_1_LLE_K.m:** Compare the effect of hyper-parameter, #Neighbor K, on classification accuracy with NN, dim d=1,...,40.  
**P1_Projection_Compares.m:** Compare the effect of PCA, LLE, LDA, SP on classification accuracy with NN, dim d=1,...,40.  
**P2_Classification_Compares.m:** Compare the effect of NN and kNN (k=1,...,5), dim d=10,20,30,40.  
**Plot_KNeighbor.m:** Given a test image, plot the k (k=1,...,5) nearest train images based on PCA.  
**Plot_PCA_Reconstruction.m:** Given a test image, plot the nearest train images based on PCA's different dim d.  
**Plot_Projection_Neighbor.m:** Given a test image, plot the nearest train images based on PCA, LLE, LDA, SP.  
**Plot_Projection_Reconstruction.m:** Given a test image, plot its reconstructions based on PCA, LLE, LDA, SP.  
**Plot_SameClass.m:** Given a test image, plot the 5 train images in its class.  
**cumvar.mat:** Cumulative variances w.r.t. #PCs (from 1 to 40).  
**image_vec_show.m:** Function. Given a image vector (dim 644), show them as a 28x23 image.  
**images_plot.m:** Function. Plot several images on one row, with specific topic above each image.  
**mid_test.mat:** Test dataset (644 x 200), 40 classes, 5 samples per class.  
**mid_train.mat:** Train dataset (644 x 200), 40 classes, 5 samples per class.  
