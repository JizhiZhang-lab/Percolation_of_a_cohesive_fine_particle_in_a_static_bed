clc;clear;

hertz_theory = readmatrix("hertz_theory.txt");
hertz_simulation = readmatrix("hertz_simulation.txt");
dmt_theory = readmatrix("dmt_theory.txt");
dmt_simulation = readmatrix("dmt_simulation.txt");
jkr_theory = readmatrix("jkr_theory.txt");
jkr_simulation = readmatrix("jkr_simulation.txt");
sjkr_theory = readmatrix("sjkr_theory.txt");
sjkr_simulation = readmatrix("sjkr_simulation.txt");

x = hertz_simulation(1,:);
y = hertz_simulation(2,:);
diffs = diff(x);
last_idx = find(diffs < 0, 1);
hertz_simulation = hertz_simulation(:,1:last_idx);

x = dmt_simulation(1,:);
y = dmt_simulation(2,:);
diffs = diff(x);
last_idx = find(diffs < 0, 1);
dmt_simulation = dmt_simulation(:,1:last_idx);

x = jkr_simulation(1,:);
y = jkr_simulation(2,:);
diffs = diff(x);
last_idx = find(diffs < 0, 1);
jkr_simulation1 = jkr_simulation(:,1:last_idx);
start_idx = find(x(last_idx:end) < 0, 1, 'first') + last_idx - 1;
end_idx = find(y(start_idx:end) == 0, 1, 'first') + start_idx - 1;
jkr_simulation2 = jkr_simulation(:, start_idx:end_idx);

x = sjkr_simulation(1,:);
y = sjkr_simulation(2,:);
diffs = diff(x);
last_idx = find(diffs < 0, 1);
sjkr_simulation = sjkr_simulation(:,1:last_idx);


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
color1 = [150, 150, 150]/255;
color2 = [37, 37, 37]/255;
color3 = [0, 1, 0];
% color4 = [35, 139, 69]/255;
% color4 = '#008656';
color4 = 'b';
% color5 = [1, 0.4, 0.4];
color5 = 'r';
color6 = [160, 30, 20]/255;
% color7 = [0.4, 0.4, 1];
% color7 = 'b';
% color8 = [2, 56, 88]/255;

%%

f = figure('Units','inches');
f.Position(3:4) = [figure_size_x, figure_size_y];
f.PaperUnits = 'inches';
f.PaperSize = [figure_size_x, figure_size_y];
f.PaperPosition = [0, 0, figure_size_x, figure_size_y];
f.PaperPositionMode = 'manual';

% plot(dmt_theory(1,:), dmt_theory(2,:), 'color', color3, 'linewidth',line_width2); hold on;
plot(dmt_simulation(1,:), dmt_simulation(2,:), '-', 'color', color4, 'linewidth',2*line_width2); hold on;

% plot(jkr_theory(1,:), jkr_theory(2,:), 'color', color5, 'linewidth',line_width2); hold on;
plot(jkr_simulation1(1,:), jkr_simulation1(2,:), '-', 'color', color5, 'linewidth',2*line_width2); hold on;
plot(jkr_simulation2(1,:), jkr_simulation2(2,:), '-', 'color', color5, 'linewidth',2*line_width2); hold on;

% plot(sjkr_theory(1,:), sjkr_theory(2,:), 'color', color7, 'linewidth',line_width2); hold on;
% plot(sjkr_simulation(1,:), sjkr_simulation(2,:), '-', 'color', color7, 'linewidth',2*line_width2); hold on;

% plot(hertz_theory(1,:), hertz_theory(2,:), 'color', color1, 'linewidth',line_width2); hold on;
plot(hertz_simulation(1,:), hertz_simulation(2,:),'-', 'color', color2, 'linewidth',2*line_width2);

% figure('units','inch','position',[2,2,figure_size_x/2/0.8*1.1,figure_size_y]);
% plot(R,fzn,'o','color',color_total,'markersize',size_marker,'linewidth',line_width2)
% hold on;
% plot(R,fb,'o','color',color_buoy,'markersize',size_marker,'linewidth',line_width2)
% plot(R_YK,fzn_YK,'pentagram','color',color_total,'markersize',size_marker,'linewidth',line_width2*2)
% plot([0 5],[1 1],'k--','linewidth',line_width2)
% plot([0 5],[1 1]*0,'k--','linewidth',line_width2)
% % plot(plx2,ply3,'b-','linewidth',1)
% plot(plx,ply1,'--','color',color_total,'markersize',size_marker,'linewidth',line_width2)
% plot(plx,ply1+ply2,'-','color',color_total,'markersize',size_marker,'linewidth',line_width2)
% 
% 
% plot(R,fzn-fb,'o','color',color_lift,'markersize',size_marker,'linewidth',line_width2)
% plot(R(R>=1),F4(R(R>=1),theta),'x','color',color_lift,'markersize',size_marker*1.5,'linewidth',line_width2)
text(0.00045,12,'Hertz','color',color2,'fontsize',size_font1,'Interpreter','latex');
text(0.0008,8,'DMT','color',color4,'fontsize',size_font1,'Interpreter','latex');
text(0.00102,12.75,'JKR','color',color5,'fontsize',size_font1,'Interpreter','latex');
% text(0.0011,5,'SJKR','color',color7,'fontsize',size_font1,'Interpreter','latex');

text(0.00045,-4,'$\delta/d_f$','color','k','fontsize',size_font1,'Interpreter','latex');
text(-0.00025,14.5,'$F/m_f g$','color','k','fontsize',size_font1,'Interpreter','latex');
text(0.00091,3.5,'repulsive','color','k','fontsize',size_font1,'Interpreter','latex');
text(0.00093,-3.5,'cohesive','color','k','fontsize',size_font1,'Interpreter','latex');
annotation('arrow', [0.78 0.78], [0.32 0.42], 'LineWidth', line_width2, 'HeadLength', 4, 'HeadWidth', 4);
annotation('arrow', [0.78 0.78], [0.32 0.22], 'LineWidth', line_width2, 'HeadLength', 4, 'HeadWidth', 4);


x_min = -0.00035; x_max = 0.0013;
y_min = -5.5; y_max = 15.5;
xlim([x_min, x_max]);
ylim([y_min, y_max]);
% xlh =xlabel('$\delta/d_s$','fontsize',size_font,'Interpreter','latex');
% ylh =ylabel('$F/m_sg$','Interpreter','latex','FontSize',size_font);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(ax, ...
    'XTick', -0.0004:0.0004:0.0016, ...
    'YTick', -4:4:24, ...
    'FontSize', size_font, ...
    'LineWidth', line_width2, ...
    'TickLabelInterpreter', 'latex');
ax.XAxis.Exponent = 0;

dx = 0.00003;
dy = 0.4;
dl = sqrt((dx*10000)^2+(dy/2)^2)*1.2;

plot([x_max-dx, x_max], [-dy/2, 0], 'k', 'LineWidth', line_width2);hold on;
plot([x_max-dx, x_max], [dy/2, 0], 'k', 'LineWidth', line_width2);hold on;
plot([-dx/2, 0], [y_max-dy, y_max], 'k', 'LineWidth', line_width2);hold on;
plot([dx/2, 0], [y_max-dy, y_max], 'k', 'LineWidth', line_width2);hold on;

x1 = -0.00003;
y1 = 0;
plot([x1-dx, x1], [y1-dy/2, y1], 'Color', color2, 'LineWidth', 1.5*line_width2);hold on;
plot([x1-dx, x1], [y1+dy/2, y1], 'Color', color2, 'LineWidth', 1.5*line_width2);hold on;

x2 = -0.00023;
y2 = 0;
plot([x2+dx, x2], [y2-dy/2, y2], 'Color', color2, 'LineWidth', 1.5*line_width2);hold on;
plot([x2+dx, x2], [y2+dy/2, y2], 'Color', color2, 'LineWidth', 1.5*line_width2);hold on;

x3 = 0;
y3 = -1.8;
plot([x3-dx/2, 0], [y3-dy, y3], 'Color', color4, 'LineWidth', 1.5*line_width2);hold on;
plot([x3+dx/2, 0], [y3-dy, y3], 'Color', color4, 'LineWidth', 1.5*line_width2);hold on;

x4 = 0;
y4 = -3.8;
plot([x4-dx/2, 0], [y4+dy, y4], 'Color', color4, 'LineWidth', 1.5*line_width2);hold on;
plot([x4+dx/2, 0], [y4+dy, y4], 'Color', color4, 'LineWidth', 1.5*line_width2);hold on;

x5 = -0.000095575;
y5 = -1.1;
plot([x5-dx/2, x5], [y5-dy, y5], 'Color', color5, 'LineWidth', 1.5*line_width2);hold on;
plot([x5+dx/2, x5], [y5-dy, y5], 'Color', color5, 'LineWidth', 1.5*line_width2);hold on;

x6 = 0;
y6 = -1.2;
plot([x6-dx/2, 0], [y6+dy, y6], 'Color', color5, 'LineWidth', 1.5*line_width2);hold on;
plot([x6+dx/2, 0], [y6+dy, y6], 'Color', color5, 'LineWidth', 1.5*line_width2);hold on;

x7 = 0.000721325;
y7 = 12.0022;
theta71 = -90;
theta72 = -145;
plot([x7+dl*cosd(theta71)/10000*0.75, x7], [y7+dl*sind(theta71), y7], 'Color', color2, 'LineWidth', 1.5*line_width2);hold on;
plot([x7+dl*cosd(theta72)/10000*0.75, x7], [y7+dl*sind(theta72), y7], 'Color', color2, 'LineWidth', 1.5*line_width2);hold on;

x8 = 0.000579925;
y8 = 8.65024;
theta81 = -90;
theta82 = -150;
plot([x8-dl*cosd(theta81)/10000*0.75, x8], [y8-dl*sind(theta81), y8], 'Color', color2, 'LineWidth', 1.5*line_width2);hold on;
plot([x8-dl*cosd(theta82)/10000*0.75, x8], [y8-dl*sind(theta82), y8], 'Color', color2, 'LineWidth', 1.5*line_width2);hold on;

x9 = 0.000796575;
y9 = 11.7583;
theta91 = -90;
theta92 = -145;
plot([x9+dl*cosd(theta91)/10000*0.75, x9], [y9+dl*sind(theta91), y9], 'Color', color5, 'LineWidth', 1.5*line_width2);hold on;
plot([x9+dl*cosd(theta92)/10000*0.75, x9], [y9+dl*sind(theta92), y9], 'Color', color5, 'LineWidth', 1.5*line_width2);hold on;

x10 = 0.000655875;
y10 = 8.2213;
theta101 = -90;
theta102 = -145;
plot([x10-dl*cosd(theta101)/10000*0.75, x10], [y10-dl*sind(theta101), y10], 'Color', color5, 'LineWidth', 1.5*line_width2);hold on;
plot([x10-dl*cosd(theta102)/10000*0.75, x10], [y10-dl*sind(theta92), y10], 'Color', color5, 'LineWidth', 1.5*line_width2);hold on;

x11 = 0.00084925;
y11 = 11.3311;
theta111 = -90;
theta112 = -145;
plot([x11+dl*cosd(theta111)/10000*0.75, x11], [y11+dl*sind(theta111), y11], 'Color', color4, 'LineWidth', 1.5*line_width2);hold on;
plot([x11+dl*cosd(theta112)/10000*0.75, x11], [y11+dl*sind(theta112), y11], 'Color', color4, 'LineWidth', 1.5*line_width2);hold on;

x12 = 0.000717825;
y12 = 7.9141;
theta121 = -90;
theta122 = -145;
plot([x12-dl*cosd(theta121)/10000*0.75, x12], [y12-dl*sind(theta121), y12], 'Color', color4, 'LineWidth', 1.5*line_width2);hold on;
plot([x12-dl*cosd(theta122)/10000*0.75, x12], [y12-dl*sind(theta122), y12], 'Color', color4, 'LineWidth', 1.5*line_width2);hold on;

x13 = 0.00156185;
y13 = 7.29955;
theta131 = -105;
theta132 = -150;
% plot([x13+dl*cosd(theta131)/10000*0.75, x13], [y13+dl*sind(theta131), y13], 'Color', color7, 'LineWidth', 1.5*line_width2);hold on;
% plot([x13+dl*cosd(theta132)/10000*0.75, x13], [y13+dl*sind(theta132), y13], 'Color', color7, 'LineWidth', 1.5*line_width2);hold on;

x14 = 0.00137128;
y14 = 4.29435;
theta141 = -110;
theta142 = -155;
% plot([x14-dl*cosd(theta141)/10000*0.75, x14], [y14-dl*sind(theta141), y14], 'Color', color7, 'LineWidth', 1.5*line_width2);hold on;
% plot([x14-dl*cosd(theta142)/10000*0.75, x14], [y14-dl*sind(theta142), y14], 'Color', color7, 'LineWidth', 1.5*line_width2);hold on;

plot([0.000835425, 0.001], [12.7965,12.7965], 'Color', color5, 'LineWidth', 1.5*line_width2);hold on;

box off;

print(f, 'static_cohesion.eps', '-depsc2');
print(f, 'static_cohesion.jpg', '-djpeg', '-r300');
print(f, 'static_cohesion.pdf', '-dpdf', '-r300');

