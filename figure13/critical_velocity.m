clear; clc;
tic

% Define parameter ranges
Bo_val = (0:1:24).';
e_val = (0.8).';
critical = zeros(size(Bo_val,1), size(e_val,1));

% Precompute values that don’t depend on Bo or e
r1 = 0.002;
r2 = 0.002/7;
reff = r1*r2/(r1+r2);

E = 1e8;
nu = 0.17;

m1 = 4/3*2500*pi*r1^3;
m2 = 4/3*2500*pi*r2^3;
meff = m1*m2/(m1+m2);
Eeff = E/(2*(1 - nu^2));

tspan = [0 0.004];
dt = 1e-8;
num_steps = round((tspan(2) - tspan(1)) / dt);
t_vv = linspace(tspan(1), tspan(2), num_steps)';

num_vel_steps = 100000;
deltadot0_vals = linspace(1e-8, 5 + 1e-8, num_vel_steps);

for l = 1:length(e_val)
    e = e_val(l);
    % Precompute B
    B_const = -2 * sqrt(5/6) * log(e) / sqrt(pi^2 + (log(e))^2) * sqrt(2 * Eeff * sqrt(reff) * meff);

    % Use parfor for Bo loop
    parfor k = 1:length(Bo_val)
        Bo = Bo_val(k);
        gamma = (1/3) * 2500 * 9.8 * r2^3 / reff * Bo;

        A = meff;
        B = B_const;
        C = 4/3 * Eeff * sqrt(reff);
        D = 4 * pi * gamma * reff;

        e_eff = zeros(num_vel_steps, 1);

        for j = 1:num_vel_steps
            deltadot0 = deltadot0_vals(j);
            delta_vv = zeros(num_steps, 1);
            vel_vv = zeros(num_steps, 1);
            delta_vv(1) = 0;
            vel_vv(1) = deltadot0;

            for i = 1:num_steps-1
                acc_n = (D - B * vel_vv(i) * delta_vv(i)^(1/4) - C * delta_vv(i)^(3/2)) / A;
                v_half = vel_vv(i) + 0.5 * acc_n * dt;
                delta_vv(i+1) = delta_vv(i) + v_half * dt;

                if delta_vv(i+1) < 0
                    break;
                end

                acc_np1 = (D - B * v_half * delta_vv(i+1)^(1/4) - C * delta_vv(i+1)^(3/2)) / A;
                vel_vv(i+1) = v_half + 0.5 * acc_np1 * dt;
            end

            if i == num_steps - 1
                e_eff(j) = 0;
            else
                e_eff(j) = abs(vel_vv(i) / deltadot0);
            end
        end

        % Store critical velocity
        critical(k, l) = (find(e_eff > 0, 1) - 1) * 5e-5 + 1e-8;
    end

    % % Plot after each e_val loop
    % plot(Bo_val, critical(:, l), '-o', 'LineWidth', 2, 'MarkerSize', 4); hold on;
    % xlabel('$Bo$', 'Interpreter', 'latex');
    % ylabel('$v_{\mathrm{critical}}$', 'Interpreter', 'latex');
    % box on;
    % set(gca, 'LineWidth', 2);
end
writematrix(critical, 'critical_velocity_080_1e8.txt', 'Delimiter', 'tab');
toc
