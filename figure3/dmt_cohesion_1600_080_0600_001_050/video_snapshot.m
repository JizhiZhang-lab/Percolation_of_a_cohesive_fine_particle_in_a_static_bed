clear;
clc;

filename = "pour_20000.txt";
data = readtable(filename, 'HeaderLines', 9);
data_matrix = table2array(data);

type_mask = (data_matrix(:, 3) == 2);
type2_heights = data_matrix(type_mask, 6);

num_type2 = length(type2_heights);

x_pos = data_matrix(type_mask, 4);
z_pos = data_matrix(type_mask, 6);
vx = data_matrix(type_mask, 7);
vy = data_matrix(type_mask, 8);
vz = data_matrix(type_mask, 9);


d = 0.004 / 7; % meters
r = d / 2;

% === Box limits ===
x_min = 0;
x_max = 0.064;
z_min = 0;
z_max = 0.128;

% === Color (hex #4d4dff → RGB) ===
hex = '4d4dff';
rgb = sscanf(hex, '%2x%2x%2x', 3)' / 255;
rgb2 = [0.173, 0.627, 0.173];

fig = figure('Color','w');
hold on;
axis equal;
xlim([x_min x_max]);
ylim([z_min z_max]);
set(gca, 'XTick', [], 'YTick', []); % no ticks
box on;

for i = 1:length(x_pos)
    v = sqrt(vx(i)^2+vy(i)^2+vz(i)^2);
    if v < 1e-5
        color = rgb2;
    else
        color = rgb;
    end
    rectangle('Position', [x_pos(i) - r, z_pos(i) - r, d, d], ...
              'Curvature', [1 1], ...
              'FaceColor', color, ...
              'EdgeColor', 'none');
end


% === Draw box boundaries ===
plot([x_min x_min], [z_min z_max], 'k--', 'LineWidth', 1);    % x = 0
plot([x_max x_max], [z_min z_max], 'k--', 'LineWidth', 1);    % x = xmax
plot([x_min x_max], [z_min z_min], 'k-', 'LineWidth', 1);    % z = 0
plot([x_min x_max], [z_max z_max], 'k-', 'LineWidth', 1);    % z = zmax

axis off;

text(0.026,0.005,'$16d_l$','color','k','fontsize',12,'Interpreter','latex');
text(0.002,0.064,'$32d_l$','color','k','fontsize',12,'Interpreter','latex');

% annotation('arrow', [0.4 0.445], [0.15 0.15], 'LineWidth', 1, 'HeadLength', 4, 'HeadWidth', 4);
% annotation('arrow', [0.4 0.4], [0.15 0.21], 'LineWidth', 1, 'HeadLength', 4, 'HeadWidth', 4);
% 
% 
% 


% Print at high resolution
% print(gcf, 'distribution_000_120.jpg', '-djpeg', '-r300');
exportgraphics(gcf, 'distribution_1600_050_020.jpg', 'Resolution', 300, 'BackgroundColor', 'none');
