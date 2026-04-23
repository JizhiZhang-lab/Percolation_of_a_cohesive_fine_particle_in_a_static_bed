clc;clear;

Bo = 0:1:24;
p_trap_040 = readmatrix('p_trap_040.txt');
p_trap_060 = readmatrix('p_trap_060.txt');
p_trap_080 = readmatrix('p_trap_080.txt');

% p_trap([2, 3, 4]) = [];

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
% h1 = plot(Bo,p_trap_040,'-^','Color','b','markersize',size_marker,'LineWidth',line_width2); hold on;
% h2 = plot(Bo,p_trap_060,'-s','Color','r','markersize',size_marker*1.2,'LineWidth',line_width2); hold on;
% h3 = plot(Bo,p_trap_080,'-o','Color','k','markersize',size_marker,'LineWidth',line_width2); hold on;


h1 = scatter(Bo, p_trap_040, size_marker, '^', ...
    'MarkerEdgeColor', 'b', ...
    'MarkerFaceColor', 'none', ...
    'LineWidth', 0.5); hold on;

h2 = scatter(Bo, p_trap_060, size_marker*1.5, 'square', ...
    'MarkerEdgeColor', 'r', ...
    'MarkerFaceColor', 'none', ...
    'LineWidth', 0.5); hold on;

h3 = scatter(Bo, p_trap_080, size_marker, 'o', ...
    'MarkerEdgeColor', 'k', ...
    'MarkerFaceColor', 'none', ...
    'LineWidth', 0.5); hold on;


x_min = 0; x_max = 25;
y_min = 0; y_max = 0.25;
xlim([x_min, x_max]);
ylim([y_min, y_max]);
xlh =xlabel('$Bo$','fontsize',size_font,'Interpreter','latex');
ylh =ylabel('$P_t$','Interpreter','latex','FontSize',size_font);
ax = gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
set(ax, ...
    'XTick', 0:5:25, ...
    'YTick', 0:0.05:0.25, ...
    'FontSize', size_font, ...
    'LineWidth', line_width2, ...
    'TickLabelInterpreter', 'latex');
% ax.XAxis.Exponent = 0;
% 

legend([h1, h2, h3], ...
    '$e_n=0.4$', '$e_n=0.6$', '$e_n=0.8$', ...
    'Interpreter', 'latex', ...
    'FontSize', size_font, ...
    'Location', 'northwest');
legend box off;
box on
annotation('arrow', [0.61 0.7], [0.6 0.125], 'LineWidth', line_width2, 'HeadLength', 4, 'HeadWidth', 4);
text(14.6,0.165,'$e_n$','color','k','fontsize',size_font1*1.2,'Interpreter','latex');

print(f, 'trapping_probability.eps', '-depsc2');
print(f, 'trapping_probability.pdf', '-dpdf', '-r300');
print(f, 'trapping_probability.jpg', '-djpeg', '-r300');
