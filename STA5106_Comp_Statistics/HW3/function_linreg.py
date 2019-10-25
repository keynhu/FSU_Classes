import numpy as np

# For backsub
# X0 = np.matrix([[6.,3.,9.,2.],[0.,4.,6.,1.],[0.,0.,8.,8.],[0.,0.,0.,5.]])
# y0 = np.array([1,4,6,1])

# For multi_linreg
# X = np.matrix([[5.,0.,9.,3.],[3.,6.,8.,9.],[4.,4.,9.,6.],[0.,3.,1.,8.],[2.,8.,2.,3.]])
# y = np.matrix([20.,17.,32.,10.,12.]).T

def backsub(X,y):
    m,n = X.shape
    b = np.zeros((n,1))
    b[n-1] = y[n-1] / X[n-1,n-1]
    for i in range(n-2,-1,-1):
        b[i] = (y[i] - np.sum(X[i,i+1:n+1] * b[i+1:n+1])) / X[i,i]
    return b

def house(x):
    mu = np.sqrt(np.sum(x**2))
    v = x.copy()
    if mu != 0:
        v[1:] = v[1:] / (v[0] + np.sign(v[0]) * mu)
    v[0] = 1
    return v

def rowhouse(X,v):
    if len(v.shape)==1:
        v = np.expand_dims(v,1)
    X_new = X - 2 / np.sum(v**2) * v * v.T * X
    return X_new, v

def multi_linreg(X,y):
    m,n = X.shape
    X_new = X.copy()
    y_new = y.copy()
    for i in range(n):
        v = house(np.array(X_new[i:m+1,i]))
        X_new[i:m+1,i:n+1],v = rowhouse(X_new[i:m+1,i:n+1], v)
        y_new[i:m+1] = y_new[i:m+1] - 2 / np.sum(v**2) * v * v.T * y_new[i:m+1]
    b = backsub(X_new, y_new);
    return b
