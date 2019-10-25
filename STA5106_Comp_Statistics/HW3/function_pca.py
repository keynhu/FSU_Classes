import numpy as np
import matplotlib.pyplot as plt
import scipy.io
from function_linreg import multi_linreg

# x = np.matrix([[15.,16.,12.,14.,13.,15.,16.,21.,12.,11.,19.,14.,13.,14.,16.,17.,12.,16.], [13.,11.,13.,12.,9.,14.,12.,16.,9.,8.,15.,13.,15.,13.,12.,16.,11.,9.]])

def pca_disp(x):
    c = np.cov(x)
    u,sig,_ = np.linalg.svd(c)
    first_pc_len = 2 * np.sqrt(sig[0])
    second_pc_len = 2 * np.sqrt(sig[1])
    m_x = np.mean(x,axis=1)
    # Plot
    plt.figure(1)
    plt.scatter(x[0,:].tolist(), x[1,:].tolist(), marker=".",color="black")
    plt.plot((first_pc_len * np.matrix([-u[0,0],u[0,0]]) + m_x[0]).tolist()[0], (first_pc_len * np.matrix([-u[1,0],u[1,0]]) + m_x[1]).tolist()[0],color="green", linestyle="-")
    #plt.plot((second_pc_len * np.matrix([-u[0,1],u[0,1]]) + m_x[0]).tolist()[0], (second_pc_len * np.matrix([-u[1,1],u[1,1]]) + m_x[1]).tolist()[0],color="green", linestyle="-")
    plt.xlabel("First Trial (min)")
    plt.ylabel("Second Trial (min)")
    plt.title("Student Experiment Data",fontsize=15)
    plt.show()

    total_var = np.trace(c)
    first_var = sig[0]
    first_ratio = first_var / total_var
    return first_var, first_ratio

def pca_linreg(X,y,d):
    c = np.cov(X, rowvar=False)
    u,sig,_ = np.linalg.svd(c)
    u1 = u[:,0:d]
    X1 = X * u1
    b1 = multi_linreg(X1, y)
    sse = np.sum(np.array(y - X1 * b1)**2)
    cumvar = np.cumsum(sig)
    return b1, sse, cumvar

mat_contents = scipy.io.loadmat('hw3_3_data.mat')
X = np.mat(mat_contents['X'])
y = np.mat(mat_contents['y'])
b1, sse, cumvar = pca_linreg(X,y,10)

def pca_linreg_test(X,y):
    s_sse = np.zeros((10,1))
    for i in range(10):
        [b1, sse, _] = pca_linreg(X,y,10*(i+1))
        s_sse[i] = sse
    plt.plot(np.arange(10,110,10),s_sse)
    plt.xlabel("PCA dimensions")
    plt.ylabel("SSE")
    plt.title("SSE of different PCA dimensions")
    plt.show()
