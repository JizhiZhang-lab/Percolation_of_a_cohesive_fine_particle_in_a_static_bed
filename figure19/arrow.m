
fig = figure('Color','w', ...
             'Units','pixels', ...
             'Position',[200 200 200 200]);   % [left bottom width height]

hold on;
xlim([-0.002 0.006]);
ylim([-0.002 0.006]);
set(gca, 'XTick', [], 'YTick', []); % no ticks
axis off;
annotation('arrow', [0.68 0.68], [0.6 0.4], 'LineWidth', 1, 'HeadLength', 5, 'HeadWidth', 5);
text(0.0042,0.0015,'$g$','color','k','fontsize',12,'Interpreter','latex');

exportgraphics(gcf, 'arrow.jpg', 'Resolution', 300, 'BackgroundColor', 'none');
