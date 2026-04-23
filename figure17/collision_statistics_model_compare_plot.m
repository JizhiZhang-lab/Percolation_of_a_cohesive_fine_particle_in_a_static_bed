clc;clear;

trapping_depth_040 = readmatrix("trapping_depth_040_005.txt")';
trapping_depth_060 = readmatrix("trapping_depth_060_005.txt")';
trapping_depth_080 = readmatrix("trapping_depth_080_005.txt")';
collision_times_040 = readmatrix("collision_times_040.txt")';
collision_times_060 = readmatrix("collision_times_060.txt")';
collision_times_080 = readmatrix("collision_times_080.txt")';
p_trap_040 = readmatrix("p_trap_040.txt")';
p_trap_060 = readmatrix("p_trap_060.txt")';
p_trap_080 = readmatrix("p_trap_080.txt")';

% Bo = 6:1:24;
% p = polyfit(Bo, lambda, 1);  
% x = 7:0.1:49;
% lambda_fit = polyval(p, x);


%%
figure_size_x=3.375;
figure_size_y=3.375*0.75;
% size_font=18;
line_width=1;
line_width2=0.5;
size_marker=15;
size_font=8;
% size_ax=17.6/2;
size_ax=8;
size_font1=8;
color1 = [0.95 0.95 0.95];
%%

f = figure('Units','inches');
f.Position(3:4) = [figure_size_x, figure_size_y];
f.PaperUnits = 'inches';
f.PaperSize = [figure_size_x, figure_size_y];
f.PaperPosition = [0, 0, figure_size_x, figure_size_y];
f.PaperPositionMode = 'manual';

% colors = lines(4);
% h1 = plot(A(1:100),A(101:200),'-','Color',colors(1,:),'LineWidth',line_width2); hold on;
% h2 = plot(B(1:100),B(101:200),'-','Color',colors(2,:),'LineWidth',line_width2); hold on;
% h3 = plot(C(1:100),C(101:200),'-','Color',colors(3,:),'LineWidth',line_width2); hold on;
% h4 = plot(D(1:100),D(101:200),'-','Color',colors(4,:),'LineWidth',line_width2); hold on;
collision_040 = -collision_times_040'.*(log(1-p_trap_040));
h1 = scatter(collision_040(1:25), trapping_depth_040(1:25), size_marker, '^', ...
    'MarkerEdgeColor', 'b', ...
    'MarkerFaceColor', 'none', ...
    'LineWidth', 0.5); hold on;

collision_060 = -collision_times_060'.*(log(1-p_trap_060));
h2 = scatter(collision_060(1:25), trapping_depth_060(1:25), size_marker*1.5, 'square', ...
    'MarkerEdgeColor', 'r', ...
    'MarkerFaceColor', 'none', ...
    'LineWidth', 0.5); hold on;

collision_080 = -collision_times_080'.*(log(1-p_trap_080));
h3 = scatter(collision_080(1:25), trapping_depth_080(1:25), size_marker, 'o', ...
    'MarkerEdgeColor', 'k', ...
    'MarkerFaceColor', 'none', ...
    'LineWidth', 0.5); hold on;





% p = polyfit(collision, lambda, 1); 
% x_fit = linspace(min(collision), max(collision), 100); 
% % plot(x_fit, polyval(p, x_fit), 'k--', 'LineWidth', line_width2);
% 
plot(0.15:0.01:0.6, (0.15:0.01:0.6) + 0.1, 'k--', 'LineWidth', line_width2);


% Coordinates of the angle corner
x0 = 0.35; 
y0 = 0.45;

% Length of the short lines
len = 0.1;
% 
% Draw the two short lines forming an angle
plot([x0, x0+len], [y0, y0], 'k-', 'LineWidth', line_width2);      % horizontal line
plot([x0+len, x0+len], [y0, y0 + len], 'k-', 'LineWidth', line_width2);      % vertical line

% Label the slope near the angle
text(x0 + 0.13, y0 + len/2, '$1$', 'Interpreter', 'latex', ...
    'FontSize', size_font, 'Color', 'k');

x_min = 0; x_max = 0.8;
y_min = 0; y_max = 1;
xlim([x_min, x_max]);
ylim([y_min, y_max]);
xlh =xlabel('$-kd_l\ln(1-P_t)$','fontsize',size_font,'Interpreter','latex');
ylh =ylabel('$d_l/\lambda$','Interpreter','latex','FontSize',size_font);
ax = gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
set(ax, ...
    'XTick', 0:0.2:0.8, ...
    'YTick', 0:0.2:1, ...
    'FontSize', size_font, ...
    'LineWidth', line_width2, ...
    'TickLabelInterpreter', 'latex');
% ax.XAxis.Exponent = 0;
% 

legend([h1, h2, h3], ...
    '$e_n=0.4$', '$e_n=0.6$', '$e_n=0.8$', ...
    'Interpreter', 'latex', ...
    'FontSize', size_font, ...
    'Location', 'southeast');
legend box off;
box on;

print(f, 'collision_statistics_model_compare.eps', '-depsc2');
print(f, 'collision_statistics_model_compare.pdf', '-dpdf', '-r300');
print(f, 'collision_statistics_model_compare.jpg', '-djpeg', '-r300');
