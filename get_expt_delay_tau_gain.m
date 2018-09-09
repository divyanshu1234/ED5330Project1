function [delay, tau, gain, t1_i] = get_expt_delay_tau_gain(step_i)
time = step_i(:,1);
pressure = step_i(:,3);
t0 = time(1);
input = step_i(4000,2);

[~, min_t1_i] = min(abs(pressure - 0.005));

avg_final_pressure = mean(pressure(4000:6000));
[~, min_t2_i] = min(abs(pressure - avg_final_pressure*0.632));

t1 = time(min_t1_i);
t2 = time(min_t2_i);

delay = t1 - t0;
tau = t2 - t1;
gain = avg_final_pressure / input;
t1_i = min_t1_i;
end