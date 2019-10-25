[x1, x2, x3, x4] = deal(6, 52, 28, 14);
n = x1 + x2 + x3 + x4;
theta = 0;
eps = 1e-6;
seq = theta;

while true
    y = x2 * theta / (2 + theta);
    theta_new = (x1 + y + x4) / (2 * (x1 + y + x3 + x4));
    if abs(theta_new - theta) < eps
        opt_theta = theta_new;
        break;
    end
    theta = theta_new;
    seq = [seq, theta];
end
