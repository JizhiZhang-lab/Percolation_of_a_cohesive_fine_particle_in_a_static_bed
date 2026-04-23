clc;clear;

A = readmatrix('critical_fricton.txt');


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

mu = 0:0.001:0.3;
colors = jet(8);
lambda_row = A(1,:);
idx = 1:5:length(mu);
valid = lambda_row(idx) > 0;
h1 = scatter(mu(idx(valid)), lambda_row(idx(valid)), size_marker^2, [13 45 108]/255, 'o','LineWidth',line_width2); hold on;

lambda_row = A(2,:);
idx = 1:5:length(mu);
valid = lambda_row(idx) > 0;
h2 = scatter(mu(idx(valid)), lambda_row(idx(valid)), size_marker^2, 'b', 's','LineWidth',line_width2); hold on;

lambda_row = A(3,:);
idx = 1:5:length(mu);
valid = lambda_row(idx) > 0;
h3 = scatter(mu(idx(valid)), lambda_row(idx(valid)), size_marker^2, [0 134 86]/255, 'd','LineWidth',line_width2); hold on;

lambda_row = A(4,:);
idx = 1:5:length(mu);
valid = lambda_row(idx) > 0;
h4 = scatter(mu(idx(valid)), lambda_row(idx(valid)), size_marker^2, colors(6,:), '^','LineWidth',line_width2); hold on;

lambda_row = A(5,:);
idx = 1:5:length(mu);
valid = lambda_row(idx) > 0;
h5 = scatter(mu(idx(valid)), lambda_row(idx(valid)), size_marker^2, colors(7,:), 'p','LineWidth',line_width2); hold on;

lambda_row = A(6,:);
idx = 1:5:length(mu);
valid = lambda_row(idx) > 0;
h6 = scatter(mu(idx(valid)), lambda_row(idx(valid)), size_marker^2, colors(8,:), '<','LineWidth', line_width2); hold on;

x_min = 0; x_max = 0.3;
y_min = 0; y_max = 0.95;
xlim([x_min, x_max]);
ylim([y_min, y_max]);
xlh =xlabel('$\mu$','fontsize',size_font,'Interpreter','latex');
ylh =ylabel('$d_l/\lambda$','Interpreter','latex','FontSize',size_font);
ax = gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
set(ax, ...
    'XTick', 0:0.05:0.3, ...
    'YTick', 0:0.2:1, ...
    'FontSize', size_font, ...
    'LineWidth', line_width2, ...
    'TickLabelInterpreter', 'latex');
% ax.XAxis.Exponent = 0;
% 

legend([h6, h5, h4, h3, h2, h1], ...
    '$Bo=24$', '$Bo=20$', '$Bo=16$', '$Bo=12$', '$Bo=8$', '$Bo=4$', ...
    'Interpreter', 'latex', ...
    'FontSize', size_font, ...
    'Position',[0.22 0.64 0.06 0.2]);

legend box off;

% text(0.102,0.1,'$Bo=4$','color','#0D2D6C','fontsize',size_font1,'Interpreter','latex');
% text(0.12,0.22,'$8$','color','b','fontsize',size_font1,'Interpreter','latex');
% text(0.118,0.3,'$12$','color','#008656','fontsize',size_font1,'Interpreter','latex');
% text(0.118,0.37,'$16$','color',colors(6,:),'fontsize',size_font1,'Interpreter','latex');
% text(0.118,0.452,'$20$','color',colors(7,:),'fontsize',size_font1,'Interpreter','latex');
% text(0.1,0.63,'$Bo=24$','color',colors(8,:),'fontsize',size_font1,'Interpreter','latex');

annotation('arrow', [0.75 0.71], [0.25 0.75], 'LineWidth', line_width2, 'HeadLength', 4, 'HeadWidth', 4);
text(0.235,0.1,'$Bo$','color','k','fontsize',size_font1,'Interpreter','latex');
box on;
print(f, 'friction.eps', '-depsc2');
print(f, 'friction.pdf', '-dpdf', '-r300');
print(f, 'friction.jpg', '-djpeg', '-r300');
