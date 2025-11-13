tau_s = 5.0;
t_vals = linspace(0, 25, 1000);

spikes1 = [1, 6];
spikes2 = [2, 8, 11];

% Calculate postsynaptic responses
P1 = P_b(t_vals, spikes1, tau_s);
P2 = P_b(t_vals, spikes2, tau_s);
Is = P1 + 0.5 * P2;

% Plotting
figure;

% Spike trains
subplot(3, 1, 1);
hold on;
for i = 1:length(spikes1)
    line([spikes1(i) spikes1(i)], [0.5 1.5], 'Color', 'blue', 'LineWidth', 2);
end
for i = 1:length(spikes2)
    line([spikes2(i) spikes2(i)], [1.5 2.5], 'Color', 'red', 'LineWidth', 2);
end
ylim([0 3]);
ylabel('Spike trains');
set(gca, 'YTick', [1, 2], 'YTickLabel', {'ρ₁', 'ρ₂'});
title('Input spike trains');
grid on;

% Postsynaptic responses
subplot(3, 1, 2);
plot(t_vals, P1, 'b-', 'LineWidth', 1.5);
hold on;
plot(t_vals, P2, 'r-', 'LineWidth', 1.5);
ylabel('P_b(t)');
legend('P₁(t)', 'P₂(t)', 'Location', 'best');
title('Postsynaptic responses');
grid on;

% Total input current
subplot(3, 1, 3);
plot(t_vals, Is, 'g-', 'LineWidth', 1.5);
ylabel('I_s(t)');
xlabel('Time (ms)');
legend('I_s(t)', 'Location', 'best');
title('Total input current');
grid on;

% Adjust layout
sgtitle('Synaptic Input Current Analysis');


% Define the P_b function
function result = P_b(t, spikes, tau_s)
    result = zeros(size(t));
    for i = 1:length(spikes)
        spike_time = spikes(i);
        result = result + (t > spike_time) .* exp(-(t - spike_time) / tau_s);
    end
end
