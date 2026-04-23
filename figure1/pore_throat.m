clear;
clc;

filename = "pour_0.txt";
data = readtable(filename, 'HeaderLines', 9);
data_matrix = table2array(data);

type_mask = (data_matrix(:, 3) == 2);


x_pos = data_matrix(type_mask, 4);
y_pos = data_matrix(type_mask, 5);

dl = 0.004;
rl = dl / 2;

ds = 0.004/7;
rs = ds / 2;

hex1  = 'ff6666';
rgb1 = sscanf(hex1,'%2x%2x%2x',3)'/255;
hex2  = '4d4dff';
rgb2 = sscanf(hex2,'%2x%2x%2x',3)'/255;


fig = figure('Color','w', ...
             'Units','pixels', ...
             'Position',[200 200 200 200]);   % [left bottom width height]

hold on;
axis equal;
xlim([-0.002 0.006]);
ylim([-0.002 0.006]);
set(gca, 'XTick', [], 'YTick', []); % no ticks
box on;
large_pos = [0,0;0.004,0;0.002,0.003464];
small_pos = [0.002,0.001155];
for i = 1:3
    rectangle('Position', [large_pos(i,1) - rl, large_pos(i,2) - rl, dl, dl], ...
              'Curvature', [1 1], ...
              'FaceColor', rgb1, ...
              'EdgeColor', 'none');
end

rectangle('Position', [small_pos(1,1) - rs, small_pos(1,2) - rs, ds, ds], ...
              'Curvature', [1 1], ...
              'FaceColor', rgb2, ...
              'EdgeColor', 'none');
axis off;


% scatter(large_pos(3,1),large_pos(3,2), 2);


% Left-facing head
annotation('arrow', [0.34 0.7], [0.72 0.6], ...
    'LineWidth', 1, ...
    'HeadLength', 4, ...
    'HeadWidth', 4, ...
    'Color', 'k');

% Right-facing head
annotation('arrow', [0.7 0.34], [0.6 0.72], ...
    'LineWidth', 1, ...
    'HeadLength', 4, ...
    'HeadWidth', 4, ...
    'Color', 'k');


annotation('arrow', [0.75 0.54], [0.56 0.45], 'LineWidth', 1, 'HeadLength', 4, 'HeadWidth', 4);


text(0.002,0.004,'$d_l$','color','k','fontsize',12,'Interpreter','latex');
text(0.0045,0.0025,'$d_s$','color','k','fontsize',12,'Interpreter','latex');

% text(-0.014,0.032,'$16d_l$','color','k','fontsize',12,'Interpreter','latex');
% 
% text(0.01,-0.004,'$x$','color','k','fontsize',12,'Interpreter','latex');
% text(-0.006,0.012,'$y$','color','k','fontsize',12,'Interpreter','latex');
% 
% annotation('arrow', [0.235 0.37], [0.18 0.18], 'LineWidth', 1.5, 'HeadLength', 6, 'HeadWidth', 6);
% annotation('arrow', [0.235 0.235], [0.18 0.32], 'LineWidth', 1.5, 'HeadLength', 6, 'HeadWidth', 6);





% Print at high resolution
% print(gcf, 'distribution_000_120.jpg', '-djpeg', '-r300');
exportgraphics(gcf, 'pore_throat.jpg', 'Resolution', 300, 'BackgroundColor', 'none');
