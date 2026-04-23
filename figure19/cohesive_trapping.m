clear;
clc;


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
large_pos = [0,0;0.002,0.003464];
small_pos = [0.001958,0.001179];
for i = 1:2
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




% text(-0.014,0.032,'$16d_l$','color','k','fontsize',12,'Interpreter','latex');
% 
% text(0.01,-0.004,'$x$','color','k','fontsize',12,'Interpreter','latex');
% text(-0.006,0.012,'$y$','color','k','fontsize',12,'Interpreter','latex');
% 
% annotation('arrow', [0.235 0.37], [0.18 0.18], 'LineWidth', 1.5, 'HeadLength', 6, 'HeadWidth', 6);
% annotation('arrow', [0.235 0.235], [0.18 0.32], 'LineWidth', 1.5, 'HeadLength', 6, 'HeadWidth', 6);





% Print at high resolution
% print(gcf, 'distribution_000_120.jpg', '-djpeg', '-r300');
exportgraphics(gcf, 'cohesive_trapping.jpg', 'Resolution', 300, 'BackgroundColor', 'none');
