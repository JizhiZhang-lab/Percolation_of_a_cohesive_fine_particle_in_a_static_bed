clear; clc;

filename = "pour_0.txt";
data = readtable(filename, 'HeaderLines', 9);
data_matrix = table2array(data);

type = data_matrix(:,3);
x = data_matrix(:,4);
y = data_matrix(:,5);
z = data_matrix(:,6);


d1 = 0.004;      % type 1 diameter (meters)
d2 = 0.004 / 7;  % type 2 diameter (meters)
r1 = d1 / 2;
r2 = d2 / 2;

idx1 = find(type == 1);
idx2 = find(type == 2);

hex1  = 'ff6666';
rgb1 = sscanf(hex1,'%2x%2x%2x',3)'/255;
hex2  = '4d4dff';
rgb2 = sscanf(hex2,'%2x%2x%2x',3)'/255;

figure('Color','w');
hold on; axis equal; box on; axis off;
daspect([1 1 1]);
xlim([-0.02 0.08]); 
ylim([-0.02 0.08]); 
zlim([-0.02 0.14]);
view(3);

nSphere = 16;            % resolution: increase for smoother spheres
[XS, YS, ZS] = sphere(nSphere);

for k = 1:numel(idx1)
    i = idx1(k);
    surf( r1*XS + x(i), ...
          r1*YS + y(i), ...
          r1*ZS + z(i), ...
          'FaceColor', rgb1, 'EdgeColor', 'none', 'FaceAlpha', 0.9 );
end

for k = 1:numel(idx2)
    i = idx2(k);
    surf( r2*XS + x(i), ...
          r2*YS + y(i), ...
          r2*ZS + z(i), ...
          'FaceColor', rgb2, 'EdgeColor', 'none', 'FaceAlpha', 0.9 );
end

view(20, 15);
camlight headlight;
camlight right;
% lighting gouraud;
material dull;
camproj('perspective');


x_min=0; 
x_max=0.064; 
y_min=0; 
y_max=0.064; 
z_min=0; 
z_max=0.128;
plot3([x_min x_max x_max x_min x_min],[y_min y_min y_max y_max y_min],[z_min z_min z_min z_min z_min],'k-','LineWidth',1);
plot3([x_min x_max x_max x_min x_min],[y_min y_min y_max y_max y_min],[z_max z_max z_max z_max z_max],'k-','LineWidth',1);
for X=[x_min x_max]
    for Y=[y_min y_max]
        plot3([X X],[Y Y],[z_min z_max],'k--','LineWidth',1);
    end
end


text(0.026,-0.008,-0.005,'$16d_l$','color','k','fontsize',12,'Interpreter','latex');
text(0.068,0.02,0,'$16d_l$','color','k','fontsize',12,'Interpreter','latex');
text(-0.008,0,0.06,'$32d_l$','color','k','fontsize',12,'Interpreter','latex','Rotation',90);

hold on;
% annotation('arrow', [0.396 0.445], [0.255 0.248], 'LineWidth', 1.5, 'HeadLength', 6, 'HeadWidth', 6);
annotation('arrow', [0.395 0.395], [0.78 0.86], 'LineWidth', 1.5, 'HeadLength', 6, 'HeadWidth', 6);

% text(0.01,0, -0.005, '$x$','color','k','fontsize',12,'Interpreter','latex');
text(-0.01,0,0.148,'$z$','color','k','fontsize',12,'Interpreter','latex');

text(-0.01,0,0.126,'$0$','color','k','fontsize',12,'Interpreter','latex');
text(-0.03,0,-0.003,'$-32d_l$','color','k','fontsize',12,'Interpreter','latex');


annotation('arrow', [0.68 0.68], [0.6 0.5], 'LineWidth', 1, 'HeadLength', 4, 'HeadWidth', 4);
text(0.098,0,0.075,'$g$','color','k','fontsize',12,'Interpreter','latex');


% 
% set(gcf,'Renderer','opengl');             
% set(gcf,'Color','w');  
% 
% 
% print(gcf, 'geomoetry.eps', '-depsc2');
% print(gcf, 'geomoetry.pdf', '-dpdf', '-r300');
% print(gcf, 'geomoetry.jpg', '-djpeg', '-r300');

exportgraphics(gcf, 'initial_state.jpg', 'Resolution', 300, 'BackgroundColor', 'none');
