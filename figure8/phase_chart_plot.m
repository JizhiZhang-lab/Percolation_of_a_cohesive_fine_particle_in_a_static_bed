clc;clear;

A = readmatrix('phase_chart.txt');
B = readmatrix('phase_chart_large.txt');
C = B(1:25,31:51);

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

Bo_A = 0:0.5:24;              
mu_A = 0:0.001:0.3;           

Bo_C = 0:1:24;                
mu_C = 0.3:0.01:0.5;         

mu = 0:0.001:0.5; 
Bo = Bo_A;

A_full = NaN(length(Bo), length(mu));

idxA = mu <= 0.3;
A_full(:,idxA) = A;

C_Bo_interp = zeros(length(Bo), length(mu_C));
for j = 1:length(mu_C)
    C_Bo_interp(:,j) = interp1(Bo_C, C(:,j), Bo, 'linear');
end

idxC = mu >= 0.3;
mu_target = mu(idxC);

C_mu_interp = zeros(length(Bo), length(mu_target));
for i = 1:length(Bo)
    C_mu_interp(i,:) = interp1(mu_C, C_Bo_interp(i,:), ...
                               mu_target, 'linear');
end

A_full(:,idxC) = C_mu_interp;

A = A_full;

% Bo = 0:0.5:24;              
% mu = 0:0.001:0.3;         

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
for i = 1:3:rows
    for j = 1:6:cols
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

h = imagesc(mu, Bo, A_display);  
A_display(isnan(A_display(:,:))) = -1;

n = 256; r = [(0:n/2-1)'/(n/2); ones(n/2,1)]; 
g = [(0:n/2-1)'/(n/2); flipud((0:n/2-1)'/(n/2))]; 
b = [ones(n/2,1); flipud((0:n/2-1)'/(n/2))]; 
cmap = [r g b]; 
colormap(cmap); 
colorbar;

set(h, 'AlphaData', A_display ~= -1);
set(gca, 'YDir', 'normal');
cb = colorbar;
cb.Label.Interpreter = 'latex';
% cb.Label.String = '$\ln L_{99}$';
cb.Label.String = '$d_l/\lambda$';
cb.Label.FontSize = size_font;
cb.Box = 'off';



% Create custom colormap: white for NaN, then jet for >= 0
% n_colors = 256;
% jetmap = jet(n_colors);
% colormap([jetmap]);  % Flip jet, prepend white for NaNs

% n_colors = 256;
% turbomap = 0.95*turbo(n_colors);
% colormap([turbomap]);  % Flip jet, prepend white for Na
% colorbar;



% n_colors = 256;
% hotmap = hot(n_colors);
% colormap([hotmap]);  

% colormap(gray(256))
% Adjust color axis to start at 0
caxis([0,0.7]);


text(0.2, 22, '\textbf{Shallow penetration}', ...
     'color', color1, 'fontsize', size_font1, 'Interpreter', 'latex');

text(0.05, 2, '\textbf{Deep penetration}', ...
     'color', color1, 'fontsize', size_font1, 'Interpreter', 'latex');


x_min = 0; x_max = 0.5;
y_min = 0; y_max = 24;
xlim([x_min, x_max]);
ylim([y_min, y_max]);
xlh =xlabel('$\mu$','fontsize',size_font,'Interpreter','latex');
ylh =ylabel('$Bo$','Interpreter','latex','FontSize',size_font);
ax = gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
set(ax, ...
    'XTick', 0:0.1:0.5, ...
    'YTick', 0:4:24, ...
    'FontSize', size_font, ...
    'LineWidth', line_width2, ...
    'TickLabelInterpreter', 'latex');
% ax.XAxis.Exponent = 0;



box off;

print(f, 'phase_chart_new.eps', '-depsc2');
print(f, 'phase_chart_new.pdf', '-dpdf', '-r300');
print(f, 'phase_chart_new.jpg', '-djpeg', '-r300');
