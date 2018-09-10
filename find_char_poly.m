% Used to find and simplify closed loop characteristic polynomial

clear all;

syms s Kp Kd Ki
ctr_type = 'pd';

[K, Td, tau] = get_values();


switch ctr_type
    case 'p'
        C_s = Kp;
    case 'pd'
        C_s = Kp + Kd*s;
    case 'pi'
        C_s = Kp + Ki/s;
    case 'pid'
        C_s = Kp + Kd*s + Ki/s;
end


H_s = 1;
P_s = K * (2-Td*s) / ((1+tau*s)*(2+Td*s));

G_s = C_s * P_s;

% cl_tr_fn = G_s*H_s / (1 + G_s*H_s);
cl_ch_pl = 1 + G_s*H_s;

[n, d] = numden(cl_ch_pl);
cs = coeffs(n, s);
c1 = coeffs(cs(end), Kp);
c2 = coeffs(c1(1), Kd);
c3 = coeffs(c2(1), Ki);

vpa(cs'/c3, 5)
