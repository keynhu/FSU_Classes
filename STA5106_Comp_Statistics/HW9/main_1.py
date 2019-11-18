import numpy as np
import matplotlib.pyplot as plt

np.random.seed(2019)
m = 100
# (a) Mean
mu_seq = []
var_mu_seq = []
for n in np.arange(1, 5, 0.1):
    mu_ests = []
    for j in range(m): # Generate n samples to estimate. Iterate for m times.
        data = np.random.randn(int(10**n))
        tmp_ests = np.mean(data)
        mu_ests.append(tmp_ests)
    mu_tmp = np.mean(mu_ests)
    var_mu_tmp = np.var(mu_ests)
    mu_seq.append(mu_tmp)
    var_mu_seq.append(var_mu_tmp)    
mu = mu_seq[-1]; # Last estimation is the final estimation
# (b) Variance
var_seq = []
var_var_seq = []
for n in np.arange(1, 5, 0.1):
    var_ests = []
    for j in range(m):
        data = np.random.randn(int(10**n))
        tmp_ests = np.mean((data - mu)**2)
        var_ests.append(tmp_ests)
    var_tmp = np.mean(var_ests)
    var_var_tmp = np.var(var_ests)
    var_seq.append(var_tmp)
    var_var_seq.append(var_var_tmp)  
sigma2 = var_seq[-1];
# (c) Kurtosis
krt_seq = []
var_krt_seq = []
for n in np.arange(1, 5, 0.1):
    krt_ests = []
    for j in range(m):
        data = np.random.randn(int(10**n))
        tmp_ests = np.mean((data - mu)**4 / sigma2**2)
        krt_ests.append(tmp_ests)
    krt_tmp = np.mean(krt_ests)
    var_krt_tmp = np.var(krt_ests)
    krt_seq.append(krt_tmp)
    var_krt_seq.append(var_krt_tmp) 

# Plot
# (a) Mean
plt.figure(1)
plt.suptitle("Estimator for mean")
ax1 = plt.subplot(121)
ax1.plot(np.arange(1, 5, 0.1), np.array(mu_seq)**2, linewidth=3)
ax1.set_title("SSE convergence", fontsize=12)
ax1.set_xlabel("Sample size ($log_{10}$)")
ax1.set_ylabel("SSE")
ax2 = plt.subplot(122)
ax2.plot(np.arange(1, 5, 0.1), np.array(var_mu_seq), linewidth=3)
ax2.set_title("Sample variance", fontsize=12)
ax2.set_xlabel("Sample size ($log_{10}$)")
ax2.set_ylabel("Sample variance")
plt.savefig("p1_new_mean_py.png")
# (b) Variance
plt.figure(2)
plt.suptitle("Estimator for variance")
ax1 = plt.subplot(121)
ax1.plot(np.arange(1, 5, 0.1), (np.array(var_seq) - 1)**2, linewidth=3)
ax1.set_title("SSE convergence", fontsize=12)
ax1.set_xlabel("Sample size ($log_{10}$)")
ax1.set_ylabel("SSE")
ax2 = plt.subplot(122)
ax2.plot(np.arange(1, 5, 0.1), np.array(var_var_seq), linewidth=3)
ax2.set_title("Sample variance", fontsize=12)
ax2.set_xlabel("Sample size ($log_{10}$)")
ax2.set_ylabel("Sample variance")
plt.savefig("p1_new_var_py.png")
# (c) Mean
plt.figure(3)
plt.suptitle("Estimator for kurtosis")
ax1 = plt.subplot(121)
ax1.plot(np.arange(1, 5, 0.1), (np.array(krt_seq)-3)**2, linewidth=3)
ax1.set_title("SSE convergence", fontsize=12)
ax1.set_xlabel("Sample size ($log_{10}$)")
ax1.set_ylabel("SSE")
ax2 = plt.subplot(122)
ax2.plot(np.arange(1, 5, 0.1), np.array(var_krt_seq), linewidth=3)
ax2.set_title("Sample variance", fontsize=12)
ax2.set_xlabel("Sample size ($log_{10}$)")
ax2.set_ylabel("Sample variance")
plt.savefig("p1_new_krt_py.png")