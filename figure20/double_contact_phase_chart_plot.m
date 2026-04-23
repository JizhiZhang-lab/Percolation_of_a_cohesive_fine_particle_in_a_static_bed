clc;clear;

A = readmatrix('phase_chart.txt');


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

Bo = 0:0.5:24;              
mu = 0:0.001:0.3;         

A_display = A;
A_display(A < 0) = NaN;
A_display = log(4.605 ./ A_display);

% Filter
for i = 1: length(Bo)
    for j = 1: length(mu)-1
        if A_display(i,j) < A_display(i,j+1)-1
            A_display(i,j) = NaN;
        end
    end
end

A_display = 4.605./exp(A_display);
A_display(A_display(:,:)<0) = NaN;
% set(gca, 'Color', [0.8 0.8 0.8]);  % Light grey
hold on;
[rows, cols] = size(A_display);
dx = mu(end) - mu(1);
dy = Bo(end) - Bo(1);
for i = 1:2:rows
    for j = 1:4:cols
        if isnan(A_display(i,j))  % Marked region
            % Get (x, y) center
            x_center = mu(j);
            y_center = Bo(i);
            dx = (mu(5) - mu(1))*100;   % mu step
            dy = (Bo(3) - Bo(1))*100;   % Bo step
            % Draw diagonal hatch (manual lines)
            x1 = x_center - dx/2;
            x2 = x_center + dx/2;
            y1 = y_center - dy/2;
            y2 = y_center + dy/2;

            % Draw line from bottom-left to top-right
            plot([x1 x2], [y1 y2], 'Color', [0.4,0.4,0.4],'LineWidth', 1);
            % Optional: add cross-line for criss-cross pattern
            plot([x1 x2], [y2 y1], 'Color', [0.4,0.4,0.4], 'LineWidth', 1);
        end
   end
end


single = readmatrix('single_count.txt');
double = readmatrix('double_count.txt');

C_display = single ./ (single + double);
mask_valid = ~isnan(A_display);

% Plot
h = imagesc(mu, Bo, C_display);
set(h, 'AlphaData', mask_valid);  % Make undesired values transparent

set(gca, 'YDir', 'normal');
cb = colorbar;
caxis([0,1]);

n = 256;
r = [(0:n/2-1)'/(n/2); ones(n/2,1)];
g = [(0:n/2-1)'/(n/2); flipud((0:n/2-1)'/(n/2))];
b = [ones(n/2,1); flipud((0:n/2-1)'/(n/2))];

cmap = [r g b];
colormap(cmap);
colorbar;


% 
% set(h, 'AlphaData', A_display ~= -1);
% set(gca, 'YDir', 'normal');
cb = colorbar;
cb.Label.Interpreter = 'latex';
% cb.Label.String = '$\ln L_{99}$';
cb.Label.String = 'Single contact fraction';
cb.Label.FontSize = size_font;
cb.Box = 'off';



% % Create custom colormap: white for NaN, then jet for >= 0
% n_colors = 256;
% jetmap = jet(n_colors);
% colormap([jetmap]);  % Flip jet, prepend white for NaNs


% n_colors = 256;
% hotmap = hot(n_colors);
% colormap([hotmap]);  

% colormap(gray(256))

caxis([0,1]);


text(0.13, 20, '\textbf{Single trapping}', ...
     'color', color1, 'fontsize', size_font1, 'Interpreter', 'latex');

text(0.032, 3.2, '\textbf{Double}', ...
     'color', color1, 'fontsize', size_font1, 'Interpreter', 'latex');
text(0.028, 1.8, '\textbf{trapping}', ...
     'color', color1, 'fontsize', size_font1, 'Interpreter', 'latex');

Bo_curve = linspace(.51, 24, 500); 
mu_curve = 1 ./ sqrt(4 * Bo_curve.^2 - 1);
hold on;
plot(mu_curve, Bo_curve, 'k--', 'LineWidth', line_width);

text(0.1, 10, '\boldmath$\mu\sqrt{4\,Bo^{2}-1}=1$', ...
     'Color','k', 'FontSize', size_font1, 'Interpreter','latex');



x_min = 0; x_max = 0.3;
y_min = 0; y_max = 24;
xlim([x_min, x_max]);
ylim([y_min, y_max]);
xlh =xlabel('$\mu$','fontsize',size_font,'Interpreter','latex');
ylh =ylabel('$Bo$','Interpreter','latex','FontSize',size_font);
ax = gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
set(ax, ...
    'XTick', 0:0.1:0.3, ...
    'YTick', 0:4:24, ...
    'FontSize', size_font, ...
    'LineWidth', line_width2, ...
    'TickLabelInterpreter', 'latex');
% ax.XAxis.Exponent = 0;

annotation('arrow', [0.35 0.28], [0.42 0.35], 'LineWidth', line_width2, 'HeadLength', 4, 'HeadWidth', 4);


box off;

print(f, 'double_contact_phase_chart_new.eps', '-depsc2');
print(f, 'double_contact_phase_chart_new.pdf', '-dpdf', '-r300');
print(f, 'double_contact_phase_chart_new.jpg', '-djpeg', '-r300');
