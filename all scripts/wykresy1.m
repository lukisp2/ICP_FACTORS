%load symulacja.mat\\
clear all
close all
%test3x3y1690fig2_20iter_poprawione_pozycje
load('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\dane\wiecej_iter_ok.mat');

%load('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\dane\wiecej_iter_ok_obrot.mat');
%load('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\dane\test3x3y1690fig2_20iter.mat');



kopia_icp1k=icp1k;
kopia_icp2k=icp2k;
kopia_icp3k=icp3k;
kopia_icp4k=icp4k;

kopia_icp1o=icp1o;
kopia_icp2o=icp2o;
kopia_icp3o=icp3o;
kopia_icp4o=icp4o;
for z=1:476
icp1k(:,1,z)=kopia_icp1k(:,2,z);
icp1k(:,2,z)=kopia_icp1k(:,1,z);
icp2k(:,1,z)=kopia_icp2k(:,2,z);
icp2k(:,2,z)=kopia_icp2k(:,1,z);
icp3k(:,1,z)=kopia_icp3k(:,2,z);
icp3k(:,2,z)=kopia_icp3k(:,1,z);
icp4k(:,1,z)=kopia_icp4k(:,2,z);
icp4k(:,2,z)=kopia_icp4k(:,1,z);

icp1o(:,1,z)=kopia_icp1o(:,2,z);
icp1o(:,2,z)=kopia_icp1o(:,1,z);
icp2o(:,1,z)=kopia_icp2o(:,2,z);
icp2o(:,2,z)=kopia_icp2o(:,1,z);
icp3o(:,1,z)=kopia_icp3o(:,2,z);
icp3o(:,2,z)=kopia_icp3o(:,1,z);
icp4o(:,1,z)=kopia_icp4o(:,2,z);
icp4o(:,2,z)=kopia_icp4o(:,1,z);
end


ilosc_powtorzen = 100;
c=1;
while ilosc_powtorzen <=1000
cov_zwy_o=cov(icp0o(:,1:2,c));
cov_hub_o=cov(icp1o(:,1:2,c));
cov_kier_o=cov(icp2o(:,1:2,c));
cov_sre_o=cov(icp3o(:,1:2,c));
cov_wek_o=cov(icp4o(:,1:2,c));

KOWo1x(c)=sqrt(cov_hub_o(1,1));
KOWo1y(c)=sqrt(cov_hub_o(2,2));

KOWo2x(c)=sqrt(cov_kier_o(1,1));
KOWo2y(c)=sqrt(cov_kier_o(2,2));

KOWo3x(c)=sqrt(cov_sre_o(1,1));
KOWo3y(c)=sqrt(cov_sre_o(2,2));

KOWo4x(c)=sqrt(cov_wek_o(1,1));
KOWo4y(c)=sqrt(cov_wek_o(2,2));



ax1 = subplot(1,1,1); % top subplot
dest=ax1;
%plotErrorEllipse([mean(icp0o(:,1,c)),mean(icp0o(:,2,c))], cov_zwy_o, 0.95, 'black',1,dest)
plotErrorEllipse([mean(icp1o(:,1,c)),mean(icp1o(:,2,c))], cov_hub_o, 0.95, 'red',1,dest)
hold on
plotErrorEllipse([mean(icp2o(:,1,c)),mean(icp2o(:,2,c))], cov_kier_o, 0.95, 'blue',1,dest)
plotErrorEllipse([mean(icp3o(:,1,c)),mean(icp3o(:,2,c))], cov_sre_o, 0.95, 'yellow',1,dest)
plotErrorEllipse([mean(icp4o(:,1,c)),mean(icp4o(:,2,c))], cov_wek_o, 0.95, 'green',1,dest)
%% wykres liniowy okr¹g
sigma_x_zwy_o(c) =sqrt(cov_zwy_o(1,1));
sigma_y_zwy_o(c)=sqrt(cov_zwy_o(2,2));

sigma_x_hub_o(c) =sqrt(cov_hub_o(1,1));
sigma_y_hub_o(c)=sqrt(cov_hub_o(2,2));

sigma_x_sre_o(c) =sqrt(cov_sre_o(1,1));
sigma_y_sre_o(c)=sqrt(cov_sre_o(2,2));

sigma_x_kier_o(c) =sqrt(cov_kier_o(1,1));
sigma_y_kier_o(c)=sqrt(cov_kier_o(2,2));

sigma_x_wek_o(c) =sqrt(cov_wek_o(1,1));
sigma_y_wek_o(c)=sqrt(cov_wek_o(2,2));
%% kó³ko
xmean=0;
ymean=0;
X = (xmean-0.005):0.001:(xmean+0.005);
Y = (ymean-0.005):0.001:(ymean+0.005);
ang=-90;
xtickangle(ang)
%axis([X(1) X(end) Y(1) Y(end)])
grid on
%xticks(-0.015:0.005:0.015)
%yticks(-0.04:0.005:0.04)
%axis([-0.03 0.03 -0.035 0.035])

if ilosc_powtorzen>=200
set(ax1,'DataAspectRatio',[1 1 1],'FontAngle','italic','FontName',...
    'Times','FontSize',15,'XTick',[-1.5:0.01:1.5],...
    'XTickLabelRotation',-90,'YTick',...
    [-15:0.01:15]);
end

if ilosc_powtorzen>350 
set(ax1,'DataAspectRatio',[1 1 1],'FontAngle','italic','FontName',...
    'Times','FontSize',15,'XTick',[-1.5:0.005:1.5],...
    'XTickLabelRotation',-90,'YTick',...
    [-15:0.005:15]);    
end
if ilosc_powtorzen <150  
 set(ax1,'DataAspectRatio',[1 1 1],'FontAngle','italic','FontName',...
    'Times','FontSize',15,'XTick',[-1.5:0.02:1.5],...
    'XTickLabelRotation',-90,'YTick',...
    [-15:0.02:15]);     
end
if ilosc_powtorzen>=800 
set(ax1,'DataAspectRatio',[1 1 1],'FontAngle','italic','FontName',...
    'Times','FontSize',15,'XTick',[-1.5:0.005:1.5],...
    'XTickLabelRotation',-90,'YTick',...
    [-5:0.0025:5]);    
end
newStr=strrep(gca,',',',');
xlabel('\Delta x [m]','fontsize',15,'FontName','Times','FontAngle','italic')
ylabel('\Delta y [m]','fontsize',15,'FontName','Times','FontAngle','italic')
%title=[int2str(ilosc_powtorzen) 'punktów w skanie']

%title(ax1,[int2str(ilosc_powtorzen) ' punktów w skanie'],'fontsize',15,'FontName','Times New Roman','FontAngle','normal')
tytul=([int2str(ilosc_powtorzen) ' punktów w skanie']);
%tytul=([int2str(ilosc_powtorzen) ' points in single scan']);

%title(ax1,'Wariant II - kwadrat','fontsize',15,'FontName','Times New Roman','FontAngle','normal')
ax1.Title.String= tytul;
ax1.Title.FontName='Times New Roman';
ax1.Title.FontSize=15;
ax1.Title.FontAngle='italic';


LineH = get(gca, 'children');
Valuey = get(LineH, 'YData');
Valuex = get(LineH, 'XData');
maxx =max(max(cell2mat(Valuex)));
maxy =max(max(cell2mat(Valuey)));
minx=min(min(cell2mat(Valuex)));
miny=min(min(cell2mat(Valuey)));
rozpietosc_x=(maxx)-(minx);
rozpietosc_y=(maxy)-(miny);
if rozpietosc_x>=rozpietosc_y
    X_min=minx;
    X_max=maxx;
    Y_min=(mean(mean(cell2mat(Valuey))))-rozpietosc_x/2;
    Y_max=(mean(mean(cell2mat(Valuey))))+rozpietosc_x/2;
else
    Y_min=miny;
    Y_max=maxy;
    X_min=(mean(mean(cell2mat(Valuex))))-rozpietosc_y/2;
    X_max=(mean(mean(cell2mat(Valuex))))+rozpietosc_y/2;
end
axis([X_min X_max Y_min Y_max])
scatter(0,1,'x','black');
%l=legend('ICP odporny','ICP odporny - wsp. b³¹d œredni w kierunku','ICP odporny- wsp. b³¹d œredni','ICP odporny - wsp. b³¹d œredni wektorowy','Pozycja oczekiwana - referencyjna')
%legend('Location','southoutside')
%l.NumColumns=1;
%set(gcf, 'Position', get(0, 'Screensize'));
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\' 'o'  int2str(ilosc_powtorzen) '.jpg'];
%set(gcf, 'Position', get(0, 'Screensize'));


print(dest.Parent,filename,'-djpeg', '-r500')
hold off
close all

ax2 = subplot(1,1,1); % middle subplot
dest=ax2;

cov_zwy_k=cov(icp0k(:,1:2,c));
cov_hub_k=cov(icp1k(:,1:2,c));
cov_kier_k=cov(icp2k(:,1:2,c));
cov_sre_k=cov(icp3k(:,1:2,c));
cov_wek_k=cov(icp4k(:,1:2,c));

KOWk1x(c)=sqrt(cov_hub_k(1,1));
KOWk1y(c)=sqrt(cov_hub_k(2,2));

KOWk2x(c)=sqrt(cov_kier_k(1,1));
KOWk2y(c)=sqrt(cov_kier_k(2,2));

KOWk3x(c)=sqrt(cov_sre_k(1,1));
KOWk3y(c)=sqrt(cov_sre_k(2,2));

KOWk4x(c)=sqrt(cov_wek_k(1,1));
KOWk4y(c)=sqrt(cov_wek_k(2,2));

%plotErrorEllipse([mean(icp0k(:,1,c)),mean(icp0k(:,2,c))], cov_zwy_k, 0.95, 'black',1,dest)
plotErrorEllipse([mean(icp1k(:,1,c)),mean(icp1k(:,2,c))], cov_hub_k, 0.95, 'red',1,dest)
hold on
plotErrorEllipse([mean(icp2k(:,1,c)),mean(icp2k(:,2,c))], cov_kier_k, 0.95, 'blue',1,dest)
plotErrorEllipse([mean(icp4k(:,1,c)),mean(icp4k(:,2,c))], cov_wek_k, 0.95, 'green',1,dest)
plotErrorEllipse([mean(icp3k(:,1,c)),mean(icp3k(:,2,c))], cov_sre_k, 0.95, 'yellow',1,dest)
daspect([1 1 1])

%% wykres liniowy kwadrat
sigma_x_zwy_k(c) =sqrt(cov_zwy_k(1,1));
sigma_y_zwy_k(c)=sqrt(cov_zwy_k(2,2));

sigma_x_hub_k(c) =sqrt(cov_hub_k(1,1));
sigma_y_hub_k(c)=sqrt(cov_hub_k(2,2));

sigma_x_sre_k(c) =sqrt(cov_sre_k(1,1));
sigma_y_sre_k(c)=sqrt(cov_sre_k(2,2));

sigma_x_kier_k(c) =sqrt(cov_kier_k(1,1));
sigma_y_kier_k(c)=sqrt(cov_kier_k(2,2));

sigma_x_wek_k(c) =sqrt(cov_wek_k(1,1));
sigma_y_wek_k(c)=sqrt(cov_wek_k(2,2));

%% kwadrat
X = (xmean-0.025):0.001:(xmean+0.025);
Y = (ymean-0.045):0.001:(ymean+0.045);
%l=legend('ICP klasyczny','ICP odporny','ICP odp.- wsp. b³¹d œredni','ICP odporny - wsp. kierunkowy b³¹d œredni w kierunku','ICP odporny - wsp. b³¹d œredni wektorowy')
%legend('Location','southoutside')
%l.NumColumns=1;
grid on
%%axis([-0.035 0.035 -0.055 0.055])
hold off
%title(ax2,'RUCH WEWN¥TRZ OKRÊGU')
xlabel(ax2,'\Delta x [m]','fontsize',15,'FontName','Times New Roman','FontAngle','italic')
ylabel(ax2,'\Delta y [m]','fontsize',15,'FontName','Times New Roman','FontAngle','italic')
set(ax2,'DataAspectRatio',[1 1 1],'FontAngle','italic','FontName',...
    'Times','FontSize',15);
%title(ax2,'Wariant II - kwadrat','fontsize',15,'FontName','Times New Roman','FontAngle','normal')
if ilosc_powtorzen>=200
set(ax2,'DataAspectRatio',[1 1 1],'FontAngle','italic','FontName',...
    'Times','FontSize',15,'XTick',[-1.5:0.01:1.5],...
    'XTickLabelRotation',-90,'YTick',...
    [-15:0.01:15]);
end

if ilosc_powtorzen>350 
set(ax2,'DataAspectRatio',[1 1 1],'FontAngle','italic','FontName',...
    'Times','FontSize',15,'XTick',[-1.5:0.005:1.5],...
    'XTickLabelRotation',-90,'YTick',...
    [-15:0.005:15]);    
end
if ilosc_powtorzen <150  
 set(ax2,'DataAspectRatio',[1 1 1],'FontAngle','italic','FontName',...
    'Times','FontSize',15,'XTick',[-1.5:0.1:1.5],...
    'XTickLabelRotation',-90,'YTick',...
    [-25:0.1:25]);     
end
ax2.Title.String= tytul;
ax2.Title.FontName='Times New Roman';
ax2.Title.FontSize=15;
ax2.Title.FontAngle='italic';

LineH = get(gca, 'children');
Valuey = get(LineH, 'YData');
Valuex = get(LineH, 'XData');
maxx =max(max(cell2mat(Valuex)));
maxy =max(max(cell2mat(Valuey)));
minx=min(min(cell2mat(Valuex)));
miny=min(min(cell2mat(Valuey)));
rozpietosc_x=(maxx)-(minx);
rozpietosc_y=(maxy)-(miny);
if rozpietosc_x>=rozpietosc_y
    X_min=minx;
    X_max=maxx;
    Y_min=(mean(mean(cell2mat(Valuey))))-rozpietosc_x/2;
    Y_max=(mean(mean(cell2mat(Valuey))))+rozpietosc_x/2;
else
    Y_min=miny;
    Y_max=maxy;
    X_min=(mean(mean(cell2mat(Valuex))))-rozpietosc_y/2;
    X_max=(mean(mean(cell2mat(Valuex))))+rozpietosc_y/2;
end
hold on
scatter(0,1,'x','black');
axis([X_min X_max Y_min Y_max])
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\' 'k' int2str(ilosc_powtorzen) '.jpg'];
%set(gcf, 'Position', get(0, 'Screensize'));
%saveas(gcf,filename);
print(dest.Parent,filename,'-djpeg', '-r500')
ilosc_powtorzen=ilosc_powtorzen+2;
c=c+1;
hold off
c
close all
end
%saveLegendToImage(ax1, l, 'testImage', 'jpg');
ax3 = subplot(1,1,1); % middle subplot
nbins=40
h1 = histogram(theta0k,nbins,'FaceColor','black');
hold on
h2 = histogram(theta1k,nbins);
hold on
h3 = histogram(theta2k,nbins);
%}