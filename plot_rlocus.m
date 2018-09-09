clear all;
ctr_type = 'p';

K = 0.90035;
Td = 0.035;
tau = 0.42;

H_s = 1;
beta_deg = 53.77;
beta_rad = deg2rad(beta_deg);

switch ctr_type
    case 'p'
        Kp = 1;
        Kd = 0;
        Ki = 0;
    case 'pd'
        Kp = 1;
        Kd = 10;
        Ki = 0;
    case 'pi'
        Kp = 1;
        Kd = 0;
        Ki = 1;
    case 'pid'
        Kp = 1;
        Kd = 1;
        Ki = 1;
end


s = tf('s');
P_s = K * (2-Td*s) / ((1+tau*s)*(2+Td*s));

C_s = Kp + Kd*s + Ki/s;
G_s = C_s * P_s;

op_tr_fn = G_s * H_s;

rlocus(op_tr_fn);
hold on;
plot([0 -100], [0 100*tan(beta_rad)], 'black', [0 -100], [0 -100*tan(beta_rad)], 'black');
plot([0 -100], [pi/0.7 pi/0.7], 'black', [0 -100], [-pi/0.7 -pi/0.7], 'black');