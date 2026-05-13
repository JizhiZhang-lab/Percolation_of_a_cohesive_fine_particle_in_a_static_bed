clear;
clc;

filename = "pour_1000000.txt";
data = readtable(filename, 'HeaderLines', 9);
data_matrix = table2array(data);

color2 = [0 0 1];
colors = [
    0/255 134/255 86/255;
    0   0   1;
    202/255 124/255 27/255; 
    1   0   0; 
    123/255 50/255 148/255;
    0.3 0.3 0.3;
    
];  
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
% hex = '4d4dff';
% rgb = sscanf(hex, '%2x%2x%2x', 3)' / 255;

rgb = [0.173, 0.627, 0.173];

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

yline((32-1/lambda)*0.004, ':', 'Color', color2, 'LineWidth', 2.5);
yline((32-3/lambda)*0.004, ':', 'Color', colors(5,:), 'LineWidth', 2.5);


% text(0.018,0.007,'$x$','color','k','fontsize',12,'Interpreter','latex');
% text(0.006,0.019,'$z$','color','k','fontsize',12,'Interpreter','latex');
% 
% annotation('arrow', [0.4 0.445], [0.15 0.15], 'LineWidth', 1, 'HeadLength', 4, 'HeadWidth', 4);
% annotation('arrow', [0.4 0.4], [0.15 0.21], 'LineWidth', 1, 'HeadLength', 4, 'HeadWidth', 4);


plot([x_min x_max], [0.12 0.12], 'r-.', 'LineWidth', 1.2);    % y = 0.12

annotation('ellipse', [0.29 1 0.0001 0.0001], ...
    'Color', 'k', 'FaceColor', 'k');


h = annotation('doublearrow', [0.355 0.355], [0.63 0.87]);

h.LineWidth    = 1.2;
h.Head1Length  = 6;
h.Head2Length  = 6;
h.Head1Width   = 6;
h.Head2Width   = 6;

text(-0.01,0.1,'$\lambda$','color',color2,'fontsize',16,'Interpreter','latex');


% Print at high resolution
% print(gcf, 'distribution_000_120.jpg', '-djpeg', '-r300');
exportgraphics(gcf, 'distribution_Bo_16_001.jpg', 'Resolution', 300, 'BackgroundColor', 'none');
