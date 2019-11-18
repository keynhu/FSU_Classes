import numpy as np
import matplotlib.pyplot as plt

# Estimate an integral with two different MC estimators.

np.random.seed(0)

est_1_seq = []
est_2_seq = []
for i in np.arange(1,6,0.1):
    n = int(10**i)
    data_1 = np.random.random(n) # Estimator 1: Unif(0,1)
    data_2_U = np.random.random(n)
    data_2 = np.sqrt(data_2_U) # Estimator 2: f(x)=2x, 0<x<1.
    est_1 = np.mean(np.exp(-data_1))
    est_2 = np.mean(np.exp(-data_2) / data_2) * 0.5
    est_1_seq.append(est_1)
    est_2_seq.append(est_2)

plt.figure(1)
p1 = plt.plot(np.arange(1,6,0.1), est_1_seq, linestyle="--", linewidth=3, label="Uniform(0,1)")
p2 = plt.plot(np.arange(1,6,0.1), est_2_seq, linewidth=3, label="$f(x)=2x, 0 \leq x \leq 1$")
plt.legend(loc="lower right")
plt.title("Problem 2 estimates of two MC estimators", fontsize=12);
plt.xlabel("Sample size ($log_{10}$)")
plt.ylabel("Estimate")
plt.savefig("p2_py.png")