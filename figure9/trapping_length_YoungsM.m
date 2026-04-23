clc;clear;

A = readmatrix('trapping_length_YoungsM_010_new.txt');


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
color1 = [0.2 0.2 0.2];
%%

f = figure('Units','inches');
f.Position(3:4) = [figure_size_x, figure_size_y];
f.PaperUnits = 'inches';
f.PaperSize = [figure_size_x, figure_size_y];
f.PaperPosition = [0, 0, figure_size_x, figure_size_y];
f.PaperPositionMode = 'manual';

E = [10^6,10^7,10^8,10^9,10^10];
Bo = 0:0.5:16;
colors = jet(16);
h1 = semilogx(E, A(1,:), '-o', 'color', color1, 'markersize',size_marker,'linewidth',line_width2); hold on;
h2 = semilogx(E, A(9,:), '-^', 'color','b', 'markersize',size_marker,'linewidth',line_width2); hold on;
h3 = semilogx(E, A(17,:), '-square', 'color', '#008656', 'markersize',size_marker,'linewidth',line_width2); hold on;
h4 = semilogx(E, A(25,:), '-p', 'color', '#CA7C1B', 'markersize',size_marker,'linewidth',line_width2); hold on;
h5 = semilogx(E, A(33,:), '-diamond', 'color', 'r', 'markersize',size_marker,'linewidth',line_width2); hold on;

x_min = 4*10^5; x_max = 2*10^10;
y_min = 0; y_max = 0.85;
xlim([x_min, x_max]);
ylim([y_min, y_max]);
xlh =xlabel('$E\,(\mathrm{Pa})$','fontsize',size_font,'Interpreter','latex');
ylh =ylabel('$d_l/\lambda$','Interpreter','latex','FontSize',size_font);
ax = gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
set(ax, ...
    'XScale', 'log', ...
    'XTick', 10.^[6:1:10], ...
    'YTick', 0:0.2:1, ...
    'FontSize', size_font, ...
    'LineWidth', line_width2, ...
    'TickLabelInterpreter', 'latex');
% ax.XAxis.Exponent = 0;
% 

legend([h5, h4, h3, h2, h1], ...
    '$Bo=16$', ...
    '$Bo=12$', ...
    '$Bo=8$', ...
    '$Bo=4$', ...
    '$Bo=0$', ...
    'Interpreter', 'latex', ...
    'FontSize', size_font, ...
    'Location', 'northeast');

legend box off;

text(3e6,0.05,'$Bo=0$','color',color1,'fontsize',size_font1,'Interpreter','latex');
% text(1e6,0.15,'$Bo=4$','color','b','fontsize',size_font1,'Interpreter','latex');
% text(1e6,0.3,'$Bo=8$','color','#008656','fontsize',size_font1,'Interpreter','latex');
% text(4e5,0.5,'$Bo=12$','color','#D85820','fontsize',size_font1,'Interpreter','latex');
text(3e7,0.4,'$Bo=16$','color','r','fontsize',size_font1,'Interpreter','latex');

annotation('arrow', [0.4 0.5], [0.15 0.45], 'LineWidth', line_width2, 'HeadLength', 4, 'HeadWidth', 4);

print(f, 'trapping_length_YoungsM.eps', '-depsc2');
print(f, 'trapping_length_YoungsM.pdf', '-dpdf', '-r300');
print(f, 'trapping_length_YoungsM.jpg', '-djpeg', '-r300');
