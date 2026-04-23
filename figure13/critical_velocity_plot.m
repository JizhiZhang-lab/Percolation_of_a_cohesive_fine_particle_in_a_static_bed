clc;clear;

A = readmatrix('critical_velocity_largerange.txt');
B = readmatrix('critical_velocity_080_1e6.txt');
C = readmatrix('critical_velocity_080_1e8.txt');

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
color1 = [0.4 0.4 0.4];
%%

f = figure('Units','inches');
f.Position(3:4) = [figure_size_x, figure_size_y];
f.PaperUnits = 'inches';
f.PaperSize = [figure_size_x, figure_size_y];
f.PaperPosition = [0, 0, figure_size_x, figure_size_y];
f.PaperPositionMode = 'manual';

colors = lines(4);
Bo = 0:1:24;
h1 = plot(Bo,A(1:25,1)./sqrt(9.8*0.004),'Color',colors(1,:),'markersize',size_marker,'LineWidth',line_width2); hold on;
h2 = plot(Bo,A(1:25,2)./sqrt(9.8*0.004),'Color',colors(2,:),'markersize',size_marker,'LineWidth',line_width2); hold on;
h3 = plot(Bo,A(1:25,3)./sqrt(9.8*0.004),'Color','#008656','markersize',size_marker,'LineWidth',line_width2); hold on;
h4 = plot(Bo,A(1:25,4)./sqrt(9.8*0.004),'Color',colors(4,:),'markersize',size_marker,'LineWidth',line_width2); hold on;
% h4 = plot(Bo,B(1:25,1)./sqrt(9.8*0.004),'Color',colors(5,:),'markersize',size_marker,'LineWidth',line_width2); hold on;
% h4 = plot(Bo,C(1:25,1)./sqrt(9.8*0.004),'Color',colors(6,:),'markersize',size_marker,'LineWidth',line_width2); hold on;



x_min = 0; x_max = 25;
y_min = 0; y_max = 0.6;
xlim([x_min, x_max]);
ylim([y_min, y_max]);
xlh =xlabel('$Bo$','fontsize',size_font,'Interpreter','latex');
ylh =ylabel('$v_{\mathrm{cr}}/\sqrt{gd_l}$','Interpreter','latex','FontSize',size_font);
ax = gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
set(ax, ...
    'XTick', 0:5:25, ...
    'YTick', 0:0.1:1, ...
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

text(10,0.255,'$e_n=0.2$','color',colors(1,:),'fontsize',size_font1,'Interpreter','latex');
text(12,0.2,'$e_n=0.4$','color',colors(2,:),'fontsize',size_font1,'Interpreter','latex');
text(16,0.14,'$e_n=0.6$','color','#008656','fontsize',size_font1,'Interpreter','latex');
text(18,0.03,'$e_n=0.8$','color',colors(4,:),'fontsize',size_font1,'Interpreter','latex');


print(f, 'critical_velocity.eps', '-depsc2');
print(f, 'critical_velocity.pdf', '-dpdf', '-r300');
print(f, 'critical_velocity.jpg', '-djpeg', '-r300');
