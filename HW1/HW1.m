% Izhikevich Neuron Model - Regular Spiking
% Parameters
alpha = -5;
beta  = 0.04;
gamma = 150;
a = 0.02;
b = 0.2;
c = -50;
d = 2;
I = 10;   % input current (us(t)=1)

% Simulation settings
dt = 0.1;       % time step (ms)
T  = 1000;      % total time (ms)
steps = T/dt;

% Initialize variables
V = -65;        % membrane potential
u = b*V;        % recovery variable
Vs = zeros(1,steps);
us = zeros(1,steps);
ts = (0:steps-1)*dt;

% Dynamics functions
dVdt = @(V,u) -alpha*V + beta*V.^2 + gamma - u + I;
dudt = @(V,u) a*(-u + b*V);

% Simulation loop
for i = 1:steps
    V = V + dt*dVdt(V,u);
    u = u + dt*dudt(V,u);
    
    % Threshold condition
    if V >= 30
        V = c;
        u = u + d;
    end
    
    Vs(i) = V;
    us(i) = u;
end

% Plot membrane potential
figure;
plot(ts, Vs, 'k', 'LineWidth', 1);
xlabel('Time (ms)');
ylabel('Membrane potential V (mV)');
title('Izhikevich Regular Spiking Neuron: $V(t)$', Interpreter='latex');
grid("minor");

% Plot recovery variable
figure;
plot(ts, us, 'b', 'LineWidth', 1);
xlabel('Time (ms)');
ylabel('Recovery variable u');
title('Recovery variable $u(t)$ over time', Interpreter='latex');
grid("minor");

%%
% Parameters for Fast Spiking
alpha = -5; beta = 0.04; gamma = 150;
a = 0.1; b = 0.2; I = 10;

dVdt = @(V,u) -alpha*V + beta*V.^2 + gamma - u + I;
dudt = @(V,u) a*(-u + b*V);

[V,U] = meshgrid(-90:5:40, -30:5:30);
dV = dVdt(V,U);
dU = dudt(V,U);

quiver(V,U,dV,dU);
xlabel('V (mV)'); ylabel('u');
title('Vector Field for Fast Spiking Neuron');

