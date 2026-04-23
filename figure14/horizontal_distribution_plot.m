clc;clear;

A = readmatrix('horizontal_distribution_080_000.txt');
B = readmatrix('horizontal_distribution_080_800.txt');
C = readmatrix('horizontal_distribution_080_1600.txt');
D = readmatrix('horizontal_distribution_080_2400.txt');
E = readmatrix('horizontal_distribution_040_800.txt');
F = readmatrix('horizontal_distribution_060_800.txt');
%%
figure_size_x=3.375;
figure_size_y=3.375*0.75;
% size_font=18;
line_width=1;
line_width2=0.5;
size_marker=3;
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

colors = lines(6);
h1 = plot(A(1:100)./sqrt(0.004*9.8),A(101:200),'-','Color','#008656','LineWidth',line_width2); hold on;
h2 = plot(B(1:100)./sqrt(0.004*9.8),B(101:200),'-','Color','k','LineWidth',line_width2); hold on;
h3 = plot(C(1:100)./sqrt(0.004*9.8),C(101:200),'-','Color','#CA7C1B','LineWidth',line_width2); hold on;
h4 = plot(D(1:100)./sqrt(0.004*9.8),D(101:200),'-','Color','#765DA0','LineWidth',line_width2); hold on;
h5 = plot(E(1:100)./sqrt(0.004*9.8),E(101:200),'--','Color','r','LineWidth',line_width2); hold on;
h6 = plot(F(1:100)./sqrt(0.004*9.8),F(101:200),'-.','Color','b','LineWidth',line_width2); hold on;
xline(1/3, 'k--', 'LineWidth', line_width2);

x_min = 0; x_max = 1.5;
y_min = 0; y_max = 11;
xlim([x_min, x_max]);
ylim([y_min, y_max]);
xlh =xlabel('$v_{\mathrm{hor}}/\sqrt{gd_l}$','fontsize',size_font,'Interpreter','latex');
ylh =ylabel('PDF','Interpreter','latex','FontSize',size_font);
ax = gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
set(ax, ...
    'XTick', 0:0.2:1.4, ...
    'YTick', 0:2:10, ...
    'FontSize', size_font, ...
    'LineWidth', line_width2, ...
    'TickLabelInterpreter', 'latex');
% ax.XAxis.Exponent = 0;
% 

legend([h1, h2, h3, h4, h5, h6], ...
    '$Bo=0,\,e_n=0.8$', '$Bo=8,\,e_n=0.8$', '$Bo=16,\,e_n=0.8$', '$Bo=24,\,e_n=0.8$','$Bo=8,\,e_n=0.4$', '$Bo=8,\,e_n=0.6$', ...
    'Interpreter', 'latex', ...
    'FontSize', size_font, ...
    'Location', 'northeast');
legend box off;

print(f, 'horizontal_distribution.eps', '-depsc2');
print(f, 'horizontal_distribution.pdf', '-dpdf', '-r300');
print(f, 'horizontal_distribution.jpg', '-djpeg', '-r300');
