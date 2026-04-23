clc;clear;

A = readmatrix('effective_restitution_coefficient_largerange.txt');
B = readmatrix('effective_restitution_coefficient_2400_1e6.txt');
C = readmatrix('effective_restitution_coefficient_2400_1e8.txt');

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

colors = lines(5);
deltadot0_vals = linspace(1e-8,0.4,1000); 
h1 = plot(deltadot0_vals./sqrt(9.8*0.004),A(1,:),'Color',color1,'LineWidth',line_width2); hold on;
h2 = plot(deltadot0_vals./sqrt(9.8*0.004),A(2,:),'Color','b','LineWidth',line_width2); hold on;
h3 = plot(deltadot0_vals./sqrt(9.8*0.004),A(3,:),'Color','#008656','LineWidth',line_width2); hold on;
% h4 = plot(deltadot0_vals./sqrt(9.8*0.004),A(4,:),'Color','#CA7C1B','LineWidth',line_width2); hold on;
h4 = plot(deltadot0_vals./sqrt(9.8*0.004),A(4,:),'Color','r','LineWidth',line_width2); hold on;

color_B = [123 50 148]/255;
color_C = [202 124 27]/255;
h5 = plot(deltadot0_vals./sqrt(9.8*0.004), B(1,:), '--', 'Color', color_B, 'LineWidth', line_width2); hold on;
% h6 = plot(deltadot0_vals./sqrt(9.8*0.004), C(1,:), '--', 'Color', color_C, 'LineWidth', line_width2); hold on;

x_min = 0; x_max = 0.6;
y_min = 0; y_max = 1;
xlim([x_min, x_max]);
ylim([y_min, y_max]);
xlh =xlabel('$v_0/\sqrt{gd_l}$','fontsize',size_font,'Interpreter','latex');
ylh =ylabel('$e_{\mathrm{eff}}$','Interpreter','latex','FontSize',size_font);
ax = gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
set(ax, ...
    'XTick', 0:0.1:1, ...
    'YTick', 0:0.2:1, ...
    'FontSize', size_font, ...
    'LineWidth', line_width2, ...
    'TickLabelInterpreter', 'latex');
% ax.XAxis.Exponent = 0;
% 

legend([h1, h2, h3, h4, h5], ...
    '$Bo=0,\,E=10^7\,\mathrm{Pa}$', '$Bo=8,\,E=10^7\,\mathrm{Pa}$', '$Bo=16, \,E=10^7\,\mathrm{Pa}$', '$Bo=24, \,E=10^7\,\mathrm{Pa}$', '$Bo=24, \,E=10^6\,\mathrm{Pa}$',...
    'Interpreter', 'latex', ...
    'FontSize', size_font, ...
    'Location', 'southeast');
legend box off;


text(0.1,0.88,'$Bo$','color',color1,'fontsize',size_font1,'Interpreter','latex');
% text(1e6,0.15,'$Bo=4$','color','b','fontsize',size_font1,'Interpreter','latex');
% text(1e6,0.3,'$Bo=8$','color','#008656','fontsize',size_font1,'Interpreter','latex');
% text(4e5,0.5,'$Bo=12$','color','#D85820','fontsize',size_font1,'Interpreter','latex');
% text(0.2,0.55,'$Bo=24$','color','r','fontsize',size_font1,'Interpreter','latex');

annotation('arrow', [0.3 0.4], [0.8 0.6], 'LineWidth', line_width2, 'HeadLength', 4, 'HeadWidth', 4);

print(f, 'effective_restitution_coefficient.eps', '-depsc2');
print(f, 'effective_restitution_coefficient.pdf', '-dpdf', '-r300');
print(f, 'effective_restitution_coefficient.jpg', '-djpeg', '-r300');
