# Problem 1: Importance sampling to estimate an integral

import numpy as np
import matplotlib.pyplot as plt

np.random.seed(2019)
y = 0.5
N_range = 10 ** np.arange(1, 7, 0.1)
est_seq = [];
for i in range(len(N_range)):
    data = np.random.exponential(1/3, int(N_range[i]))
    Z_est = np.mean(np.exp(-(y - data)**2/2)) / 3
    theta_est = np.mean(data * np.exp(-(y - data)**2/2)) / (3 * Z_est)
    est_seq.append(theta_est)

plt.figure(1)
plt.plot(np.log10(N_range), est_seq, linewidth=2);
plt.xlabel("Sample size ($log_{10}$)")
plt.ylabel("Estimate")
plt.title("Problem 4 - Importance sampling estimate", fontsize=10)
plt.savefig("p1_py.png")