function plot_step(step_i)
plot(step_i(:,1), step_i(:,2), step_i(:,1), step_i(:,3));
xlabel('Time');
ylabel('Pressure');
end