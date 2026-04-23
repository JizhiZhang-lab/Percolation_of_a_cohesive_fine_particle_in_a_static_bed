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
valid = lambda_row > 0;
h1 = scatter(mu(valid)*sqrt(4*4^2-1), lambda_row(valid), size_marker^2, [13 45 108]/255, 'o','LineWidth',line_width2); hold on;

lambda_row = A(2,:);
valid = lambda_row > 0;
h2 = scatter(mu(valid)*sqrt(4*8^2-1), lambda_row(valid),size_marker^2,'b','s','LineWidth', line_width2);hold on;

lambda_row = A(3,:);
valid = lambda_row > 0;
h3 = scatter(mu(valid)*sqrt(4*12^2-1), lambda_row(valid), size_marker^2, [0 134 86]/255, 'd','LineWidth',line_width2); hold on;

lambda_row = A(4,:);
valid = lambda_row > 0;
h4 = scatter(mu(valid)*sqrt(4*16^2-1), lambda_row(valid), size_marker^2, colors(6,:), '^','LineWidth',line_width2); hold on;

lambda_row = A(5,:);
valid = lambda_row > 0;
h5 = scatter(mu(valid)*sqrt(4*20^2-1), lambda_row(valid), size_marker^2, colors(7,:), 'p','LineWidth',line_width2); hold on;

lambda_row = A(6,:);
valid = lambda_row > 0;
h6 = scatter(mu(valid)*sqrt(4*24^2-1), lambda_row(valid), size_marker^2, colors(8,:), '<','LineWidth', line_width2); hold on;

plot([1 1],[0 0.6],'--k','LineWidth',line_width2);

x_min = 0; x_max = 2.2;
y_min = 0; y_max = 0.95;
xlim([x_min, x_max]);
ylim([y_min, y_max]);
xlh =xlabel('$\mu\sqrt{4Bo^2-1}$','fontsize',size_font,'Interpreter','latex');
ylh =ylabel('$d_l/\lambda$','Interpreter','latex','FontSize',size_font);
ax = gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
set(ax, ...
    'XTick', 0:0.5:2, ...
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

annotation('arrow', [0.75 0.73], [0.25 0.55], 'LineWidth', line_width2, 'HeadLength', 4, 'HeadWidth', 4);
text(1.7,0.1,'$Bo$','color','k','fontsize',size_font1,'Interpreter','latex');
box on;

print(f, 'critical_friction.eps', '-depsc2');
print(f, 'critical_friction.pdf', '-dpdf', '-r300');
print(f, 'critical_friction.jpg', '-djpeg', '-r300');
