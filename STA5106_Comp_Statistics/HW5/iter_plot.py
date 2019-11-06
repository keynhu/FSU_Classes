import numpy as np
import matplotlib.pyplot as plt

def simple_iter(fun, x0, eps):
    x = x0;
    seq = [x0];
    while True:
        x1 = x + fun(x)
        seq.append(x1)
        if abs(x1 - x) < eps:
            break
        x = x1;
    return x1, seq

def newton(fun, dfun, x0, eps):
    x = x0;
    seq = [x0];
    while True:
        x1 = x - fun(x) / dfun(x);
        seq.append(x1)
        if abs(x1 - x) < eps:
            break
        x = x1;
    return x1, seq

def iter_plot(fun, dfun, x0, eps):
    [_, seq1] = simple_iter(fun, x0, eps)
    [_, seq2] = newton(fun, dfun, x0, eps)
    plt.figure(1)
    plt.plot(seq1, linestyle="-", color="blue",label="Simple Iteration")
    plt.plot(seq2, linestyle="--", color="red",label="Newton Method")
    plt.xlabel("X")
    plt.ylabel("Sum of Squared Error (SSE)")
    plt.title("SSE of two Converging Sequences",fontsize=15)
    plt.legend(loc="upper right")
    plt.show()
    plt.figure(2)
    t = list(np.arange(0,1,0.01))
    plt.plot(t, fun(t), color="black", linestyle="-")
    plt.scatter(seq1, fun(seq1), marker=".", color="blue",label="Simple Iteration")
    plt.scatter(seq2, fun(seq2), marker="*", color="red",label="Newton Method")
    plt.xlabel("X")
    plt.ylabel("fun")
    plt.title("Converging sequences of two methods",fontsize=15)
    plt.legend(loc="upper right")
    plt.show()

fun = lambda x: 0.9 * np.sin(x) - x
dfun = lambda x: 0.9 * np.cos(x) - 1
iter_plot(fun, dfun, np.pi/4, 1e-6)
