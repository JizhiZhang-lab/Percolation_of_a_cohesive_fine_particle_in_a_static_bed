clc;clear;

A = readmatrix('friction_new.txt');
B = readmatrix("friction_jkr_080.txt");
range = 5.5:0.001:24.8;


%%
figure_size_x=1.08;
figure_size_y=1.08*0.75;
% size_font=18;
line_width=1;
line_width2=0.5;
size_marker=3;
size_font=6;
% size_ax=17.6/2;
size_ax=8;
size_font1=6;
color1 = [0.95 0.95 0.95];
%%

f = figure('Units','inches');
f.Position(3:4) = [figure_size_x, figure_size_y];
f.PaperUnits = 'inches';
f.PaperSize = [figure_size_x, figure_size_y];
f.PaperPosition = [0, 0, figure_size_x, figure_size_y];
f.PaperPositionMode = 'manual';

Bo = 0:1:24;

cols = 1:6;
markers = {'<','d','^','s','o','>'}; 
colors = [
    0/255 134/255 86/255;
    0   0   1;
    202/255 124/255 27/255; 
    1   0   0; 
    123/255 50/255 148/255;
    0.3 0.3 0.3;
    
];             

hold on;

lambda_row = A(:, 2);

valid = lambda_row > 0;
scatter(Bo(valid), lambda_row(valid), size_marker, ...
        markers{2}, ...
        'MarkerEdgeColor', colors(2,:), ...
        'MarkerFaceColor', 'none', 'LineWidth', 0.8);

lambda_new = lambda_row(7:25);
Bo_new     = Bo(7:25);
lambda_new = lambda_new(:);
Bo_new     = Bo_new(:);
p = polyfit(Bo_new, lambda_new, 1);
yfit = polyval(p, range);

% --- R^2 ---
SS_res = sum((lambda_new - polyval(p, Bo_new)).^2);
SS_tot = sum((lambda_new - mean(lambda_new)).^2);
R2     = 1 - SS_res / SS_tot;
% 
% % --- plot fit ---
% plot(range, yfit, '--', ...
%      'Color', colors(2,:), ...
%      'LineWidth', line_width2*2);


lambda_row = B(:, 2);

valid = lambda_row > 0;
scatter(Bo(valid), lambda_row(valid), size_marker, ...
        'o', ...
        'MarkerEdgeColor', colors(3,:), ...
        'MarkerFaceColor', 'none', 'LineWidth', 0.8);

lambda_new = lambda_row(7:25);
Bo_new     = Bo(7:25);
lambda_new = lambda_new(:);
Bo_new     = Bo_new(:);
p = polyfit(Bo_new, lambda_new, 1);
yfit = polyval(p, range);

% --- R^2 ---
SS_res = sum((lambda_new - polyval(p, Bo_new)).^2);
SS_tot = sum((lambda_new - mean(lambda_new)).^2);
R2     = 1 - SS_res / SS_tot;

% % --- plot fit ---
% plot(range, yfit, '--', ...
%      'Color', 'c', ...
%      'LineWidth', line_width2*2);


x_min = 0; x_max = 25;
y_min = 0; y_max = 0.7;
xlim([x_min, x_max]);
ylim([y_min, y_max]);
xlh =xlabel('$Bo=F_c/W$','fontsize',size_font,'Interpreter','latex');
ylh =ylabel('$d_l/\lambda$','Interpreter','latex','FontSize',size_font);
ax = gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
set(ax, ...
    'XTick', 0:10:20, ...
    'YTick', 0:0.2:0.6, ...
    'FontSize', size_font, ...
    'LineWidth', line_width2, ...
    'TickLabelInterpreter', 'latex');
% ax.XAxis.Exponent = 0;
% 

% lgd = legend(h_scatter,'$\mu=0.05$', '$\mu=0.10$', '$\mu=0.15$','$\mu=0.20$','$\mu=0.25$','$\mu=0.30$',...
%     'Interpreter', 'latex', ...
%     'FontSize', size_font);
% lgd.Position = [0.12 0.62 0.25 0.25];
% legend box off;

text(15,0.25,'DMT','color',colors(2,:),'fontsize',size_font1,'Interpreter','latex');
text(6,0.5,'JKR','color',colors(3,:),'fontsize',size_font1,'Interpreter','latex');
% text(9,0.1,'$\mu=0.1$','color','k','fontsize',size_font1,'Interpreter','latex');

% 
% annotation('arrow', [0.8 0.72], [0.4 0.7], 'LineWidth', line_width2, 'HeadLength', 4, 'HeadWidth', 4);
% Make ticks longer and thicker
ax.TickLength = [0.03 0.03];   % default ~[0.01 0.025]
% ax.TickDir    = 'out';         % 'out' looks clearer for small plots
% ax.LineWidth  = 1.0;           % thicker axis box
% ax.XAxis.LineWidth = 1.0;
% ax.YAxis.LineWidth = 1.0;

box on;
print(f, 'trapping_length_Bo_jkr.eps', '-depsc2');
print(f, 'trapping_length_Bo_jkr.pdf', '-dpdf', '-r300');
print(f, 'trapping_length_Bo_jkr.jpg', '-djpeg', '-r300');
