K = 0.90035;
Td = 0.035;
tau = 0.42;
Kp = 1;
H_s = 1;
beta_deg = 53.77;
beta_rad = deg2rad(beta_deg);

s = tf('s');
P_s = K * (2-Td*s) / ((1+tau*s)*(2+Td*s));
C_s = Kp;

G_s = C_s * P_s;

cl_tr_fn = G_s*H_s / (1 + G_s*H_s);
cl_cr_pl = 1 + G_s*H_s;

op_tr_fn = G_s*H_s;

rlocus(op_tr_fn);
hold on;
plot([0 -100], [0 100*tan(beta_rad)], 'black', [0 -100], [0 -100*tan(beta_rad)], 'black');