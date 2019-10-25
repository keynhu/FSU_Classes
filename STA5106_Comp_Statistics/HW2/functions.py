import numpy as np

def backsub(X,y):
    m,n = X.shape
    b = np.zeros((n,1))
    b[-1] = y[-1] / X[-1,-1]
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
    X_new = X - 2 / np.sum(v**2) * v * np.transpose(v) * X
    return X_new

def householder(X):
    m,n = X.shape
    X_new = X.copy()
    for i in range(n):
        v = house(np.array(X_new[i:m+1,i]))
        X_new[i:m+1,i:n+1] = rowhouse(X_new[i:m+1,i:n+1], v)
    return X_new
