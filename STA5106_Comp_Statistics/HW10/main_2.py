# Problem 2: Tilted sampling to estimate standard normal tail

import numpy as np

a_range = range(1,6) # Sequence of a
N_range = 10**np.array([3, 5, 7])
est_mat = np.zeros((len(a_range), len(N_range)))
for i,a in enumerate(a_range):
    for j, N in enumerate(N_range):
        data = np.random.randn(N) + a
        est_mat[i, j] = np.mean(np.exp(a**2 / 2 - a * data) * (data >= a))

# Output
for i in range(len(a_range)):
    print("a=%2d, Integral estimate with sample size: \n 1e3: %7.6e, 1e5: %7.6e, 1e7: %7.6e \n" % (a_range[i], *est_mat[i,:]))
