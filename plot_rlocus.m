% Plots root locus for different types of controllers

clear all;
ctr_type = 'pd';

[K, Td, tau] = get_values();

H_s = 1;
beta_deg = 53.77;
beta_rad = deg2rad(beta_deg);

switch ctr_type
    case 'p'
        Kd_Kp = 0;
        Ki_Kp = 0;
    case 'pd'
        Kd_Kp = 0.01;
        Ki_Kp = 0;
    case 'pi'
        Kd_Kp = 0;
        Ki_Kp = 1/tau;
    case 'pid'
        Kd_Kp = 0.001;
        Ki_Kp = 1/tau;
end


s = tf('s');
P_s = K * (2-Td*s) / ((1+tau*s)*(2+Td*s));

C_s = 1 + Kd_Kp*s + Ki_Kp/s;
G_s = C_s * P_s;

op_tr_fn = G_s * H_s;

rlocus(op_tr_fn);
title('')
hold on;
plot([0 -100], [0 100*tan(beta_rad)], 'black', [0 -100], [0 -100*tan(beta_rad)], 'black');
plot([0 -100], [pi/0.7 pi/0.7], 'black', [0 -100], [-pi/0.7 -pi/0.7], 'black');