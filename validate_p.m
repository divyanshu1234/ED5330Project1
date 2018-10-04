% Finds Kp value that give the least steady state error

ctr_type = 'pi';

[K, Td, tau] = get_values();

switch ctr_type
    case 'p'
        Kp_vals = 4.7:0.1:9.3;
        Kd_vals = Kp_vals * 0;
        Ki_vals = Kp_vals * 0;
    case 'pd'
        Kp_vals = 6.6:0.1:15.5;
        Kd_vals = Kp_vals * 0.01;
        Ki_vals = Kp_vals * 0;
    case 'pi'
        Kp_vals = 5.7:0.1:9.4;
        Kd_vals = Kp_vals * 0;
        Ki_vals = Kp_vals * 1/tau;
    case 'pid'
        Kp_vals = 5.3:0.1:9.8;
        Kd_vals = Kp_vals * 0.001;
        Ki_vals = Kp_vals * 1/tau;
end

H_s = 1;
s = tf('s');
P_s = K * (2-Td*s) / ((1+tau*s)*(2+Td*s));
err = zeros(length(Kp_vals), 1);
mp = zeros(length(Kp_vals), 1);

for i = 1:length(Kp_vals)

    C_s = Kp_vals(i) + s * Kd_vals(i) + Ki_vals(i) / s;
    G_s = C_s * P_s;

    cl_tr_fn = G_s / (1 + G_s*H_s);

    sim_time = 0:0.002:8;
    unit_step_opt = stepDataOptions('InputOffset', 0, 'StepAmplitude', 1);
    sys = cl_tr_fn;
    step_res_sim = step(sys, sim_time, unit_step_opt);
    
    err(i) = abs(step_res_sim(3000)-1);
    mp(i) = max(step_res_sim) - step_res_sim(3000);
    disp(Kp_vals(i));
end

[min_err, min_err_i] = min(err);
printf('Kp with min std. err.', Kp_vals(min_err_i));
printf('Steady state error', min(err));
printf('MP', mp(min_err_i));