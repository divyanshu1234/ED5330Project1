clear all;
load('material_proj1/frequency_response_data_final.mat')

max_in = zeros(12,1);
max_out = zeros(12,1);
max_in_f = zeros(12,1);
max_out_f = zeros(12,1);

for i = 1:12
    F_i = eval(strcat('F_', num2str(floor(i/10)), '_', num2str(mod(i,10))));
    [max_in(i), max_out(i), max_in_f(i), max_out_f(i)] = spectrum2(F_i);
end

plot(log10(max_out_f), 20*log10(max_out ./ max_in));