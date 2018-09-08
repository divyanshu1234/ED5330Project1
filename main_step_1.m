delay = zeros(4,1);
tau_expt = zeros(4,1);
gain = zeros(4,1);
t1_i = zeros(4,1);

for i = 1:4
    step_i = eval(strcat('step_', num2str(i+4), ';'));
    [delay(i), tau_expt(i), gain(i), t1_i(i)] = get_expt_delay_tau_gain(step_i);
end

K = mean(gain);
Td = mean(delay);
t1_i = max(t1_i) + 10;


tau = 0.3: 0.01 :0.8;
tau_len = length(tau);
mape = zeros(tau_len, 4);
sim_time = 0:0.002:5;
sim_time_len = length(sim_time);
s = tf('s');

for i = 1:4
    step_i = eval(strcat('step_', num2str(i+4), ';'));
    step_res_expt_i = step_i(:,3);
    opt_i = stepDataOptions('InputOffset', 0, 'StepAmplitude', i+4);
        
    for j = 1:tau_len
        sys_i_j = K * (2-Td*s) / ((1+tau(j)*s) * (2+Td*s));
        step_res_sim_i_j = step(sys_i_j, sim_time, opt_i);
        
        mape(j,i) = mean(abs(step_res_expt_i(t1_i:sim_time_len) - step_res_sim_i_j(t1_i:sim_time_len)));
    end
    
    disp(i);
end

avg_mape = mean(mape')';

[min_avg_mape, min_avg_mape_i] = min(avg_mape);
disp(tau(min_avg_mape_i));