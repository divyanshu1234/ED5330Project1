% Finds Kp value that give the least steady state error

clear all;

[K, Td, tau] = get_values();

H_s = 1;
s = tf('s');
P_s = K * (2-Td*s) / ((1+tau*s)*(2+Td*s));
Kp_vals = 4.7:0.1:9.3;
err = zeros(length(Kp_vals), 1);

for i = 1:length(Kp_vals)

    C_s = Kp_vals(i);
    G_s = C_s * P_s;

    cl_tr_fn = G_s*H_s / (1 + G_s*H_s);

    sim_time = 0:0.002:8;
    unit_step_opt = stepDataOptions('InputOffset', 0, 'StepAmplitude', 1);
    sys = cl_tr_fn;
    step_res_sim = step(sys, sim_time, unit_step_opt);
    
    err(i) = abs(step_res_sim(3000)-1);
    disp(Kp_vals(i));
end

[min_err, min_err_i] = min(err);
printf('Kp with min std. err.', Kp_vals(min_err_i));
printf('Steady state error', min(err));
printf('MP', max(step_res_sim) - step_res_sim(3000));