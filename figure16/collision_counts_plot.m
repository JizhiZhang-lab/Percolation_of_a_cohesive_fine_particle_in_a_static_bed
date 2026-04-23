clc;clear;

Bo = 0:1:24;
collision_counts_040 = readmatrix("collision_times_040");
collision_counts_060 = readmatrix("collision_times_060");
collision_counts_080 = readmatrix("collision_times_080");


%%
figure_size_x=3.375;
figure_size_y=3.375*0.75;
% size_font=18;
line_width=1;
line_width2=0.5;
size_marker=10;
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

h1 = scatter(Bo, collision_counts_040, size_marker, '^', ...
    'MarkerEdgeColor', 'b', ...
    'MarkerFaceColor', 'none', ...
    'LineWidth', 0.5); hold on;

h2 = scatter(Bo, collision_counts_060, size_marker*1.5, 'square', ...
    'MarkerEdgeColor', 'r', ...
    'MarkerFaceColor', 'none', ...
    'LineWidth', 0.5); hold on;

h3 = scatter(Bo, collision_counts_080, size_marker, 'o', ...
    'MarkerEdgeColor', 'k', ...
    'MarkerFaceColor', 'none', ...
    'LineWidth', 0.5); hold on;

box on;

x_min = 0; x_max = 25;
y_min = 0; y_max = 18;
xlim([x_min, x_max]);
ylim([y_min, y_max]);
xlh =xlabel('$Bo$','fontsize',size_font,'Interpreter','latex');
ylh =ylabel('$kd_l$ (collision counts)','Interpreter','latex','FontSize',size_font);
ax = gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
set(ax, ...
    'XTick', 0:5:25, ...
    'YTick', 0:5:15, ...
    'FontSize', size_font, ...
    'LineWidth', line_width2, ...
    'TickLabelInterpreter', 'latex');
% ax.XAxis.Exponent = 0;
% 

% legend([h1, h2, h3, h4,], ...
%     '$e_n=0.2$', '$e_n=0.4$', '$e_n=0.6$', '$e_n=0.8$', ...
%     'Interpreter', 'latex', ...
%     'FontSize', size_font, ...
%     'Location', 'northwest');
% legend box off;

text(10.5,5,'$e_n=0.4$','color','b','fontsize',size_font1,'Interpreter','latex');
text(10.5,10,'$e_n=0.6$','color','r','fontsize',size_font1,'Interpreter','latex');
text(10.5,14,'$e_n=0.8$','color','k','fontsize',size_font1,'Interpreter','latex');


print(f, 'collision_counts.eps', '-depsc2');
print(f, 'collision_counts.pdf', '-dpdf', '-r300');
print(f, 'collision_counts.jpg', '-djpeg', '-r300');
