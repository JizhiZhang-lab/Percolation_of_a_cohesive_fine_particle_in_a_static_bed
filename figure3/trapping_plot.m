clc; clear;

%% Figure settings
figure_size_x = 3.375;
figure_size_y = 3.375 * 0.75;
size_font1 = 8;
color1 = [0.95 0.95 0.95];

f = figure('Units','inches');
f.Position(3:4) = [figure_size_x, figure_size_y];
f.PaperUnits = 'inches';
f.PaperSize = [figure_size_x, figure_size_y];
f.PaperPosition = [0, 0, figure_size_x, figure_size_y];
f.PaperPositionMode = 'manual';

img1 = imread('distribution_1600_050_020.jpg');
img2 = imread('distribution_1600_050_120.jpg');
img3 = imread('distribution_1600_050_220.jpg');

gap = 0.028;                % white space between images
ax_width = (1 - 3*gap)/3;   % each image width
ax_height = 0.85;            % height of axes
ax_bottom = 0.05;             % bottom position

ax1 = axes('Position',[gap, ax_bottom, ax_width, ax_height]);
imshow(img1,'Parent',ax1);
axis(ax1,'image'); axis(ax1,'off');
% text(0.5,1.05,'$t\sqrt{g/d_l}=10$','Units','normalized', ...
%     'HorizontalAlignment','center','VerticalAlignment','middle', ...
%     'Interpreter','latex','FontSize',7);

ax2 = axes('Position',[ax_width + 2*gap, ax_bottom, ax_width, ax_height]);
imshow(img2,'Parent',ax2);
axis(ax2,'image'); axis(ax2,'off');
% text(0.5,1.05,'$t\sqrt{g/d_l}=60$','Units','normalized', ...
%     'HorizontalAlignment','center','VerticalAlignment','middle', ...
%     'Interpreter','latex','FontSize',7);

ax3 = axes('Position',[gap+2*(ax_width + gap), ax_bottom, ax_width, ax_height]);
imshow(img3,'Parent',ax3);
axis(ax3,'image'); axis(ax3,'off');
% text(0.5,1.05,'$t\sqrt{g/d_l}=110$','Units','normalized', ...
%     'HorizontalAlignment','center','VerticalAlignment','middle', ...
%     'Interpreter','latex','FontSize',7);

annotation(f, 'textbox', [0.005, 0.96, 0.05, 0.05], ...
    'String', '(b)', 'Interpreter', 'latex', ...
    'FontSize', 8, 'FontWeight', 'bold', ...
    'EdgeColor', 'none', 'VerticalAlignment', 'top');

print(f, 'trapping.eps', '-depsc2');
print(f, 'trapping.pdf', '-dpdf', '-r300');
print(f, 'trapping.jpg', '-djpeg', '-r300');
