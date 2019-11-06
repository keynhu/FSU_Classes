import numpy as np
from iter_plot import newton

fun = lambda x: x**5 - 4.5 * x**4 + 4.55 * x**3 + 2.675 * x**2 - 3.3 * x - 1.4375
dfun = lambda x: 5 * x**4 - 18 * x**3 + 13.65 * x**2 + 5.35 * x - 3.3

[_, seq] = newton(fun, dfun, -0.6, 1e-6)
diff_seq = abs(np.diff(seq))
diff_seq_ratio = [diff_seq[i+1] / diff_seq[i] for i in range(len(diff_seq)-1)]
print(diff_seq_ratio)
