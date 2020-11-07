%% Pozycja znaku
ilosc_iteracji=1000;
mu=0;
sigma=1;
x=eye(ilosc_iteracji,1);
y=eye(ilosc_iteracji,1);
sigma_r=0.05;
sigma_alfa = deg2rad(.5);
r=40;
alfa=deg2rad(0);

xz_0=r*cos(alfa);
yz_0=r*sin(alfa);

for i =1:ilosc_iteracji
    r_0=r+normrnd(0,sigma_r);
    alfa_0=alfa+normrnd(0,sigma_alfa);
    
    x_0(i,1)=r_0*cos(alfa_0);
    y_0(i,1)=r_0*sin(alfa_0);

end
h1 = figure;


hold on
scatter(x_0,y_0,5,'.','red');


covariance=cov(x_0,y_0);
mu(1)=mean(x_0);
mu(2)=mean(y_0);
hold on
Sigma=covariance
p=0.95;
kolor='blue';
skala=1;
plotErrorEllipse_bez_dest(mu, Sigma, p, kolor,skala);
%{
x1 = 20:0.25:36;
x2 = 20:0.25:36;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];
y = mvnpdf(X,mu,Sigma);
y = reshape(y,length(x2),length(x1));
surf(x1,x2,y)
caxis([min(y(:))-0.5*range(y(:)),max(y(:))])
pause(5)
hold off
scatter(x_0,y_0,'+');
hold on
p = mvncdf([0 0],[1 1],mu,Sigma)
y = mvnpdf(X,mu,Sigma);
y = reshape(y,length(x2),length(x1));
contour(x1,x2,y,[0.0001 0.001 0.01 0.05 0.10 0.15 0.20 0.25 0.30 0.35])
%}
%% Pozycja pojazdu
poz_x1=1;
poz_y1=0;

odl_1=eye(ilosc_iteracji,1);
alfa_1=eye(ilosc_iteracji,1);
x_1=eye(ilosc_iteracji,1);
y_1=eye(ilosc_iteracji,1);

odl_rz=sqrt((poz_x1-xz_0)^2+(poz_y1-yz_0)^2);
alfa_rz=atan2(yz_0-poz_y1,xz_0-poz_x1);
if alfa_rz<0
alfa_rz=alfa_rz+2*pi;
end



for i=1:ilosc_iteracji
    odl_1(i,1)=odl_rz+normrnd(0,sigma_r);
    alfa_1(i,1)=alfa_rz+normrnd(0,sigma_alfa);
    
    x_1(i,1)=x_0(i,1)+odl_1(i,1)*cos(alfa_1(i,1)+pi);
    y_1(i,1)=y_0(i,1)+odl_1(i,1)*sin(alfa_1(i,1)+pi);    
end

scatter(x_1,y_1,5,'.','blue');
covariance=cov(x_0,y_0);

mu(1)=mean(x_1);
mu(2)=mean(y_1);
hold on
Sigma=covariance;
p=0.95;
kolor='black';
skala=1;
plotErrorEllipse_bez_dest(mu, Sigma, p, kolor,skala);


min_x1=min(x_1);
max_x1=max(x_1);
min_y1=min(y_1);
max_y1=max(y_1);

min_x0=min(x_0);
max_x0=max(x_0);
min_y0=min(y_0);
max_y0=max(y_0);

%xlim([t(1) t(end)]*1000);
ylim([-22.5 22.5]);
xlim([0 45]);
title('Rozk³ad b³edu pozycji dla znaku na k¹cie kursowym 000^o'); 
xlabel('X [m]')
ylabel('Y [m]')

ax = gca;
ax.FontSize = 15; 
set(ax,'FontSize',15,'FontAngle','italic','FontName','Times');
grid(gca,'minor')
grid on



scatter(0,0,50,'x','black','LineWidth',1);
scatter(1,0,50,'x','black','LineWidth',1);
scatter(r*cos(alfa),r*sin(alfa),50,'x','blue','LineWidth',1);
set(gcf, 'Position', get(0, 'Screensize')/1.5);
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\rozklad000.jpg'];


xa = [xz_0-2 xz_0]; % X-Coordinates in data space
ya = [yz_0-15 yz_0]; % Y-Coordinates in data space
[xaf,yaf] = ds2nfu(xa,ya); % Convert to normalized figure units
a=annotation('textarrow',xaf,yaf,'String','X_z ')
set(a,'FontSize',15,'FontAngle','italic','FontName','Times','HeadStyle','none');

xa = [poz_x1+10 poz_x1]; % X-Coordinates in data space
ya = [poz_y1-8 poz_y1]; % Y-Coordinates in data space
[xaf,yaf] = ds2nfu(xa,ya); % Convert to normalized figure units
a=annotation('textarrow',xaf,yaf,'String','X_1 ')
set(a,'FontSize',15,'FontAngle','italic','FontName','Times','HeadStyle','none');

xa = [0+7 0]; % X-Coordinates in data space
ya = [0-8 0]; % Y-Coordinates in data space
[xaf,yaf] = ds2nfu(xa,ya); % Convert to normalized figure units
a=annotation('textarrow',xaf,yaf,'String','X_0 ')
set(a,'FontSize',15,'FontAngle','italic','FontName','Times','HeadStyle','none');


xa = [15 25]; % X-Coordinates in data space
ya = [0 0]; % Y-Coordinates in data space
[xaf,yaf] = ds2nfu(xa,ya); % Convert to normalized figure units
a=annotation('textarrow',xaf,yaf,'String','','VerticalAlignment','baseline');

xa = [23 33]; % X-Coordinates in data space
ya = [0 0]; % Y-Coordinates in data space
[xaf,yaf] = ds2nfu(xa,ya); % Convert to normalized figure units
%a=annotation('textarrow',xaf,yaf,'String','Kurs Rzeczywisty','VerticalAlignment','baseline','LineWidth',0.00001);
%set(a,'FontSize',15,'FontAngle','italic','FontName','Times','HeadStyle','plain');
text(16,0.8,'Kierunek ruchu','FontSize',15,'FontAngle','italic','FontName','Times')

diff_x=max_x1-min_x1;
diff_y=max_y1-min_y1;
skala1=5.5;
diff_x1=diff_x*skala1;
diff_y1=diff_y*skala1;
lgd=legend('wyznaczona pozycja znaku X_z','elipsa b³êdu pozycji znaku dla p=0,95%','wyznaczona pozycja pojazdu X_1','elipsa b³êdu pozycji pojazdu p=0,95%','location','southwest')

MagInset(h1, -1, [min_x1 max_x1 min_y1 max_y1], [10 10+diff_x1 5 5+diff_y1], {'NW','NW';'SE','SE'});
set(gca,'FontSize',8,'FontAngle','italic','FontName','Times');

diff_x=max_x0-min_x0;
diff_y=max_y0-min_y0;
diff_x1=diff_x*skala1;
diff_y1=diff_y*skala1;

MagInset(h1, -1, [min_x0 max_x0 min_y0 max_y0], [25 25+diff_x1 5 5+diff_y1], {'NW','NW';'SE','SE'});

set(gca,'FontSize',8,'FontAngle','italic','FontName','Times');


print(ax.Parent,filename,'-djpeg', '-r500')


