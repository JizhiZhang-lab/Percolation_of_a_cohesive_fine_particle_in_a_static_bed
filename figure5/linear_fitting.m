clear; clc;


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
hold on;

folders = {
    'dmt_cohesion_1600_080_0600_001_050', ...
    'dmt_cohesion_1600_080_0600_010_050', ...
    'dmt_cohesion_2400_080_0600_001_050' ...
};

file = "pour_1000000.txt";


colors = [
    202/255 124/255 27/255;               % k = 1 → red
    0 0 1;                 % k = 2 → blue
    0/255 134/255 86/255;  % k = 3 → hex #008656
];


for k = 1:length(folders)
    folder = folders{k};
    filename = fullfile(folder, file);
    
    % --- Read data ---
    data = readtable(filename, 'HeaderLines', 9);
    data_matrix = table2array(data);
    
    % --- Type 2 particle heights ---
    type_mask = (data_matrix(:, 3) == 2);
    type2_heights = data_matrix(type_mask, 6);
    
    % --- Histogram-based distribution ---
    x_pos = data_matrix(type_mask, 4);
    z_pos = type2_heights;
    
    num_bins = 80; % histogram bins
    [counts, edges] = histcounts(z_pos, num_bins, 'Normalization', 'pdf');
    z_centers = edges(1:end-1) + diff(edges)/2;
    
    counts_normalize = counts * 0.004;
    z_center_normalize = 32 - z_centers / 0.004;
    

    % Determine marker using if-block
    if k == 1
        marker = 'o';
        h1 = scatter(z_center_normalize, counts_normalize, ...
                size_marker*3, colors(k,:), marker);
    elseif k == 2
        marker = 's';
        h2 = scatter(z_center_normalize, counts_normalize, ...
                size_marker*4, colors(k,:), marker);
    else
        marker = 'd';
        h3 = scatter(z_center_normalize, counts_normalize, ...
                size_marker*3, colors(k,:), marker);
    end

    % --- Exponential tail fitting ---
    d1 = 10; d2 = 160;
    bin_edges = 0.2 * (d1 + 1) : 0.2 : 0.2 * d2;
    bin_count = length(bin_edges);
    count_per_bin = zeros(1, bin_count);
    
    num_type2 = length(type2_heights);
    for i = 1:num_type2
        h = type2_heights(i);
        if h < 0.128 - 0.0008 * d1 && h > 0.128 - 0.0008 * d2
            bin_idx = floor((0.128 - 0.0008 * d1 - h) / 0.0008) + 1;
            if bin_idx >= 1 && bin_idx <= bin_count
                count_per_bin(bin_idx) = count_per_bin(bin_idx) + 1;
            end
        end
    end
    
    frequency = (count_per_bin / 10000) / 0.2;
    first_low_idx = find(frequency < 0.001, 1, 'first');
    
    if isempty(first_low_idx)
        z_filtered = bin_edges;
        f_filtered = frequency;
    else
        z_filtered = bin_edges(1:first_low_idx - 1);
        f_filtered = frequency(1:first_low_idx - 1);
    end
    
    y_vals = -log(f_filtered);
    p_fit = polyfit(z_filtered, y_vals, 1);
    z_new = 2:0.01:20;
    y_fit = polyval(p_fit, z_new);
    f_fit = exp(-y_fit);
    
    % Plot fitted PDF (dashed line)
    plot(z_new, f_fit, '--', 'LineWidth', line_width2, 'Color', colors(k,:));
    
end

x_min = 0; x_max = 20;
y_min = 8e-4; y_max = 0.5;
xlim([x_min, x_max]);
ylim([y_min, y_max]);
xlh =xlabel('$-z/d_l$','fontsize',size_font,'Interpreter','latex');
ylh =ylabel('Trapped particles PDF','Interpreter','latex','FontSize',size_font);
ax = gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
base_xticks = 0:5:30;
xticks = unique([base_xticks, 2]);

set(ax, ...
    'XTick', xticks, ...
    'YScale','log', ...
    'YTick', [1e-3 1e-2 1e-1 1], ...
    'FontSize', size_font, ...
    'LineWidth', line_width2, ...
    'TickLabelInterpreter', 'latex');

base_xticks = 0:5:30;
xticks = unique([base_xticks, 2]);
% ax.XAxis.Exponent = 0;
% 
xline(2,'-.r','LineWidth',line_width2*1.2);
legend([h1,h2,h3],...
    '$Bo=16, \mu=0.01$', '$Bo=16, \mu=0.10$', '$Bo=24, \mu=0.01$', ...
    'Interpreter', 'latex', ...
    'FontSize', size_font, ...
    'Location', 'northeast');
legend box off;
box on;

text(2.1,2e-3,'$-z/d_l=2$','color',color1,'fontsize',size_font1,'Interpreter','latex');
% % text(1e6,0.15,'$Bo=4$','color','b','fontsize',size_font1,'Interpreter','latex');
% % text(1e6,0.3,'$Bo=8$','color','#008656','fontsize',size_font1,'Interpreter','latex');
% % text(4e5,0.5,'$Bo=12$','color','#D85820','fontsize',size_font1,'Interpreter','latex');
% text(0.2,0.55,'$Bo=24$','color','r','fontsize',size_font1,'Interpreter','latex');
% 
% annotation('arrow', [0.3 0.4], [0.8 0.6], 'LineWidth', line_width2, 'HeadLength', 4, 'HeadWidth', 4);


print(f, 'exponential_distribution_cutoff.eps', '-depsc2');
print(f, 'exponential_distribution_cutoff.pdf', '-dpdf', '-r300');
print(f, 'exponential_distribution_cutoff.jpg', '-djpeg', '-r300');
