import numpy as np
import matplotlib.pyplot as plt

# Variance reduction by conditioning.

n = 500
X = np.random.exponential(1, n)
Y = np.random.exponential(X)
est_seq = [];
est_xy_seq = [];
for i in range(1,n):
    data = X[:i]
    est_xy = np.mean(data * Y[:i] < 3)
    est = np.mean(1-np.exp(-3 / data**2))
    est_seq.append(est)
    est_xy_seq.append(est_xy)

plt.figure(1)
plt.plot(est_seq, linewidth=3, label="MC Conditioning")
plt.plot(est_xy_seq, linestyle="--", linewidth=3, label="Original MC")
plt.title("Problem 3 estimate of P($XY \leq 3$)")
plt.xlabel("Sample size")
plt.ylabel("Estimate")
plt.legend(loc="lower right")
plt.savefig("p3_py.png")