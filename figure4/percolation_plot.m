clc; clear;

figure_size_x = 3.375;
figure_size_y = 3.375 * 0.65;
size_font1 = 8;
color1 = [0.95 0.95 0.95];

f = figure('Units','inches');
f.Position(3:4) = [figure_size_x, figure_size_y];
f.PaperUnits = 'inches';
f.PaperSize = [figure_size_x, figure_size_y];
f.PaperPosition = [0, 0, figure_size_x, figure_size_y];
f.PaperPositionMode = 'manual';

img1 = imread('distribution_Bo_8_001.jpg');
img2 = imread('distribution_Bo_16_001.jpg');
img3 = imread('distribution_Bo_24_001.jpg');

gap = -0.002;                % white space between images
ax_width = (1 - 2*gap)/3;   % each image width
ax_height = 1;            % height of axes
ax_bottom = 0;             % bottom position

ax1 = axes('Position',[0, ax_bottom, ax_width, ax_height]);
imshow(img1,'Parent',ax1);
axis(ax1,'image'); axis(ax1,'off');
text(0.58,0.98,'$Bo=8$','Units','normalized', ...
    'HorizontalAlignment','center','VerticalAlignment','middle', ...
    'Interpreter','latex','FontSize',7);

ax2 = axes('Position',[ax_width + gap, ax_bottom, ax_width, ax_height]);
imshow(img2,'Parent',ax2);
axis(ax2,'image'); axis(ax2,'off');
text(0.58,0.98,'$Bo=16$','Units','normalized', ...
    'HorizontalAlignment','center','VerticalAlignment','middle', ...
    'Interpreter','latex','FontSize',7);

ax3 = axes('Position',[2*(ax_width + gap), ax_bottom, ax_width, ax_height]);
imshow(img3,'Parent',ax3);
axis(ax3,'image'); axis(ax3,'off');
text(0.58,0.98,'$Bo=24$','Units','normalized', ...
    'HorizontalAlignment','center','VerticalAlignment','middle', ...
    'Interpreter','latex','FontSize',7);


print(f, 'percolation.eps', '-depsc2');
print(f, 'percolation.pdf', '-dpdf', '-r300');
print(f, 'percolation.jpg', '-djpeg', '-r300');
