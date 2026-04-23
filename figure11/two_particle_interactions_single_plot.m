clc; clear;

rA = 0.002;
rB = 0.002/7;
theta = linspace(0, 2*pi, 100);
cmap = turbo(226);

%% Figure setup
figure_size_x = 3.375 * 0.3;                      % total figure width (in)
figure_size_y = 3.375 * 0.5 * 0.75 * 1.2;         % total figure height (in)

line_width = 1;
line_width2 = 0.5;
size_marker = 3;
size_font = 8;
size_ax = 8;
size_font1 = 8;
color1 = [0.95 0.95 0.95];

f = figure('Units','inches','Color','w');
f.Position(3:4) = [figure_size_x, figure_size_y];
f.PaperUnits = 'inches';
f.PaperSize = [figure_size_x, figure_size_y];
f.PaperPosition = [0, 0, figure_size_x, figure_size_y];
f.PaperPositionMode = 'manual';


idx = 3;
    A = readmatrix(sprintf('pair_interaction_%d_A.txt', idx));
    B = readmatrix(sprintf('pair_interaction_%d_B.txt', idx));

    nexttile;
    hold on;

    % Draw large particle
    xA = A(1, 4); yA = A(1, 6);
    fill(xA + rA*cos(theta), yA + rA*sin(theta), [0.7 0.7 0.7], 'EdgeColor','none');

    % Draw small particles
    for i = 1:5:min(size(B,1),166)
        xB = B(i,4); yB = B(i,6);
        fill(xB + rB*cos(theta), yB + rB*sin(theta), cmap(i+40,:), 'EdgeColor','none');
    end

    axis equal;
    axis([0, 0.0088, 0.0005, 0.010]);
    axis off;
    

    if idx == 3
        beta = linspace(1.3*pi, 1.7*pi, 100);
        r = 0.0025;  
        x0 = 0.0044;  
        y0 = 0.003;  
        x_curve = x0 + r*cos(beta);
        y_curve = y0 + r*sin(beta);

        plot(x_curve, y_curve, 'k', 'LineWidth', 0.5); hold on;

        % Get axes handle
        ax = gca;

        % Convert data coordinates to normalized figure coordinates
        fig = gcf;
        ax_units = ax.Position;  % axes position in figure units
        xlim_ax = ax.XLim;
        ylim_ax = ax.YLim;

        % Function to map data coords to figure normalized coords
        mapToFigX = @(x) ax_units(1) + (x - xlim_ax(1)) / (xlim_ax(2) - xlim_ax(1)) * ax_units(3);
        mapToFigY = @(y) ax_units(2) + (y - ylim_ax(1)) / (ylim_ax(2) - ylim_ax(1)) * ax_units(4);

        % Arrow at the end of curve
        ah = annotation('arrow', ...
        'Position', [mapToFigX(x_curve(end-1))+0.01, mapToFigY(y_curve(end-1))+0.009, ...
                     mapToFigX(x_curve(end)) - mapToFigX(x_curve(end-1)), ...
                     mapToFigY(y_curve(end)) - mapToFigY(y_curve(end-1))], ...
        'LineWidth',0.4, 'Color','k', 'HeadLength',2, 'HeadWidth',2);

        % Arrow at the start of curve (optional)
        ah2 = annotation('arrow', ...
        'Position', [mapToFigX(x_curve(2))-0.01, mapToFigY(y_curve(2))+0.005, ...
                     mapToFigX(x_curve(1)) - mapToFigX(x_curve(2)), ...
                     mapToFigY(y_curve(1)) - mapToFigY(y_curve(2))], ...
        'LineWidth',0.4, 'Color','k', 'HeadLength',2, 'HeadWidth',2);
    end


% cmap = cmap(40:200,:);
% colormap(cmap);
% cb = colorbar('Position', [0.9 0.2 0.02 0.4]);
% cb.TickDirection = 'out';
% cb.Label.Interpreter = 'latex';
% cb.Label.String = '$t$ (s)';
% cb.Label.FontSize = size_font;
% % cb.Box = 'off'; 
% 
% cb.Label.Position(1) = -2;    % shift left (negative moves left of bar)
% cb.Label.Position(2) = 0.5;     % center vertically
% cb.Label.Rotation = 90;         % vertical label
% cb.Label.VerticalAlignment = 'middle';
% cb.Label.HorizontalAlignment = 'center';
% 
% cb.Ticks = linspace(0, 1, 5);
% cb.TickLabels = {'$0$', '$0.04$', '$0.08$', '$0.12$', '$0.16$'};
% cb.TickLabelInterpreter = 'latex';   % render tick labels as LaTeX



x_start = 0.42; 
y_start = 0.85;
x_end = 0.42;
y_end = 0.77;  % short arrow

% a = annotation('arrow', [x_start, x_end], [y_start, y_end], ...
%     'LineWidth', 0.5, 'Color', 'k', ...
%     'HeadLength', 5, 'HeadWidth', 5);   % smaller arrowhead
% 
% text(-0.26, 1.82, '$g$', 'Units', 'normalized', ...
%     'Interpreter', 'latex', 'FontSize', 8, 'FontWeight', 'bold');



%% Export
print(f, 'two_particle_interactions_3.eps', '-depsc2');
print(f, 'two_particle_interactions_3.pdf', '-dpdf', '-r300');
print(f, 'two_particle_interactions_3.jpg', '-djpeg', '-r600');
