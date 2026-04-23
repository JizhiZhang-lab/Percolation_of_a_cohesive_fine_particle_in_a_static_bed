clear;
clc;

filename = "pour_1000000.txt";
data = readtable(filename, 'HeaderLines', 9);
data_matrix = table2array(data);

type_mask = (data_matrix(:, 3) == 2);
type2_heights = data_matrix(type_mask, 6);

num_type2 = length(type2_heights);

d1 = 10;
d2 = 160;
bin_edges = 0.2 * (d1 + 1) : 0.2 : 0.2 * d2;
bin_count = length(bin_edges);
count_per_bin = zeros(1, bin_count);

for i = 1:num_type2
    h = type2_heights(i);
    if h < 0.128 - 0.0008 * d1 && h > 0.128 - 0.0008 * d2
        bin_idx = floor((0.128 - 0.0008 * d1 - h) / 0.0008) + 1;
        if bin_idx >= 1 && bin_idx <= bin_count
            count_per_bin(bin_idx) = count_per_bin(bin_idx) + 1;
        end
    end
end

frequency = (count_per_bin / 10000) / 0.2;
first_low_idx = find(frequency < 0.001, 1, 'first');

if isempty(first_low_idx)
    z_filtered = bin_edges;
    f_filtered = frequency;
else
    z_filtered = bin_edges(1:first_low_idx - 1);
    f_filtered = frequency(1:first_low_idx - 1);
end


y_vals = -log(f_filtered);
p_fit = polyfit(z_filtered, y_vals, 1);
y_fit = polyval(p_fit, z_filtered);

if p_fit(1) > 0
    lambda = p_fit(1);
else
    lambda = -1;
end



x_pos = data_matrix(type_mask, 4);
z_pos = data_matrix(type_mask, 6);

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

fig = figure('Color','w');
hold on;
axis equal;
xlim([x_min x_max]);
ylim([z_min z_max]);
set(gca, 'XTick', [], 'YTick', []); % no ticks
box on;

% === Plot each particle as a filled circle in data units ===
for i = 1:length(x_pos)
    rectangle('Position', [x_pos(i) - r, z_pos(i) - r, d, d], ...
              'Curvature', [1 1], ...
              'FaceColor', rgb, ...
              'EdgeColor', 'none');
end

% === Draw box boundaries ===
plot([x_min x_min], [z_min z_max], 'k--', 'LineWidth', 1);    % x = 0
plot([x_max x_max], [z_min z_max], 'k--', 'LineWidth', 1);    % x = xmax
plot([x_min x_max], [z_min z_min], 'k-', 'LineWidth', 1);    % z = 0
plot([x_min x_max], [z_max z_max], 'k-', 'LineWidth', 1);    % z = zmax

axis off;

% text(0.018,0.007,'$x$','color','k','fontsize',12,'Interpreter','latex');
% text(0.006,0.019,'$z$','color','k','fontsize',12,'Interpreter','latex');
% 
% annotation('arrow', [0.4 0.445], [0.15 0.15], 'LineWidth', 1, 'HeadLength', 4, 'HeadWidth', 4);
% annotation('arrow', [0.4 0.4], [0.15 0.21], 'LineWidth', 1, 'HeadLength', 4, 'HeadWidth', 4);





% Print at high resolution
% print(gcf, 'distribution_000_120.jpg', '-djpeg', '-r300');
exportgraphics(gcf, 'distribution_Bo_16_001.jpg', 'Resolution', 300, 'BackgroundColor', 'none');
