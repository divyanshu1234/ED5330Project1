% Simulates the closed loop control output

clear all;
ctr_type = 'pi';

[K, Td, tau] = get_values();

switch ctr_type
    case 'p'
        Kp = 9.3;
        Kd = 0;
        Ki = 0;
    case 'pd'
        Kp = 15.5;
        Kd = Kp * 0.01;
        Ki = 0;
    case 'pi'
        Kp = 6.2;
        Kd = 0;
        Ki = Kp * 1/tau;
    case 'pid'
        Kp = 6.0;
        Kd = Kp * 0.001;
        Ki = Kp * 1/tau;
end


H_s = 1;
s = tf('s');
P_s = K * (2-Td*s) / ((1+tau*s)*(2+Td*s));

C_s = Kp + Kd*s + Ki/s;
G_s = C_s * P_s;

cl_tr_fn = G_s*H_s / (1 + G_s*H_s);

sim_time = 0:0.002:8;
unit_step_opt = stepDataOptions('InputOffset', 0, 'StepAmplitude', 1);
sys = cl_tr_fn;
step_res_sim = step(sys, sim_time, unit_step_opt);

plot_step([sim_time', ones(length(sim_time), 1), step_res_sim]);
xlim([-1 9]);
ylim([-0.2 1.2]);
legend('Reference Value', 'Output Value');
grid on;