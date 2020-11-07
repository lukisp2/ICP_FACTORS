close all
clear all

load('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\dane\wiecej_iter_ok.mat')
%load symulacja.mat
ilosc_powtorzen = 50;
c=1;
while ilosc_powtorzen <=1000
cov_zwy_o=cov(icp0o(:,1:2,c));
cov_hub_o=cov(icp1o(:,1:2,c));
cov_kier_o=cov(icp2o(:,1:2,c));
cov_sre_o=cov(icp3o(:,1:2,c));
cov_wek_o=cov(icp4o(:,1:2,c));

ax1 = subplot(1,1,1); % top subplot
dest=ax1;
plotErrorEllipse([mean(icp2o(:,1,c)),mean(icp2o(:,2,c))], cov_kier_o, 0.95, 'blue',1,dest)
hold on
plotErrorEllipse([mean(icp1o(:,1,c)),mean(icp1o(:,2,c))], cov_hub_o, 0.95, 'red',1,dest)
plotErrorEllipse([mean(icp2o(:,1,c)),mean(icp2o(:,2,c))], cov_zwy_o, 0.95, 'black',1,dest)
plotErrorEllipse([mean(icp4o(:,1,c)),mean(icp4o(:,2,c))], cov_wek_o, 0.95, 'green',1,dest)
plotErrorEllipse([mean(icp3o(:,1,c)),mean(icp3o(:,2,c))], cov_sre_o, 0.95, 'yellow',1,dest)
daspect([1 1 1])
scatter(1,0,'black','filled')
%% wykres liniowy okr¹g
sigma_x_zwy_o(c) =sqrt(cov_zwy_o(1,1));
sigma_y_zwy_o(c)=sqrt(cov_zwy_o(2,2));

sigma_x_hub_o(c) =sqrt(cov_hub_o(1,1));
sigma_y_hub_(c)=sqrt(cov_hub_o(2,2));

sigma_x_sre_o(c) =sqrt(cov_sre_o(1,1));
sigma_y_sre_o(c)=sqrt(cov_sre_o(2,2));

sigma_x_kier_o(c) =sqrt(cov_kier_o(1,1));
sigma_y_kier_o(c)=sqrt(cov_kier_o(2,2));

sigma_x_wek_o(c) =sqrt(cov_wek_o(1,1));
sigma_y_wek_o(c)=sqrt(cov_wek_o(2,2));
%% kó³ko
ang=-90;
xtickangle(ang)
grid on

if ilosc_powtorzen ==100 
    axis([-0.15 0.15 -0.15 0.15])
end

if ilosc_powtorzen>=200 && ilosc_powtorzen<400
    axis([-0.05 0.05 -0.05 0.05])
end

if ilosc_powtorzen>=400 
    axis([-0.035 0.035 -0.035 0.035])
end
if ilosc_powtorzen>=200
set(ax1,'DataAspectRatio',[1 1 1],'FontAngle','italic','FontName',...
    'Times','FontSize',15,'XTick',[-0.15 -0.145 -0.14 -0.135 -0.13 -0.125 -0.12 -0.115 -0.11 -0.105 -0.1 -0.095 -0.09 -0.085 -0.08 -0.075 -0.070 -0.065 -0.060 -0.055 -0.050 -0.045 -0.040 -0.035 -0.030 -0.025 -0.020 -0.015 -0.010 -0.005 0 0.005 0.010 0.015 0.020 0.025 0.030 0.035 0.040 0.045 0.050 0.055 0.060 0.065 0.070 0.075 0.08 0.085 0.09 0.095 0.1 0.105 0.11 0.115 0.12 0.125 0.13 0.135 0.14 0.145 0.15],...
    'XTickLabelRotation',-90,'YTick',...
    [-0.15 -0.145 -0.14 -0.135 -0.13 -0.125 -0.12 -0.115 -0.11 -0.105 -0.1 -0.095 -0.09 -0.085 -0.08 -0.075 -0.070 -0.065 -0.060 -0.055 -0.050 -0.045 -0.040 -0.035 -0.030 -0.025 -0.020 -0.015 -0.010 -0.005 0 0.005 0.010 0.015 0.020 0.025 0.030 0.035 0.040 0.045 0.050 0.055 0.060 0.065 0.070 0.075 0.08 0.085 0.09 0.095 0.1 0.105 0.11 0.115 0.12 0.125 0.13 0.135 0.14 0.145 0.15]);
end

if ilosc_powtorzen<350 && ilosc_powtorzen>150
set(ax1,'DataAspectRatio',[1 1 1],'FontAngle','italic','FontName',...
    'Times','FontSize',15,'XTick',[-0.15 -0.14 -0.13 -0.12 -0.11 -0.1 -0.09 -0.08 -0.070 -0.060 -0.050 -0.040 -0.030 -0.020 -0.010 0 0.010 0.020 0.030 0.040 0.050 0.060 0.070 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15],...
    'XTickLabelRotation',-90,'YTick',...
    [-0.15 -0.14 -0.13 -0.12 -0.11 -0.1 -0.09 -0.08 -0.070 -0.060 -0.050 -0.040 -0.030 -0.020 -0.010 0 0.010 0.020 0.030 0.040 0.050 0.060 0.070 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15]);    
end
if ilosc_powtorzen <150  
 set(ax1,'DataAspectRatio',[1 1 1],'FontAngle','italic','FontName',...
    'Times','FontSize',15,'XTick',[-0.17 -0.15 -0.13 -0.11 -0.09 -0.070 -0.050 -0.030 -0.010 0.010 0.030 0.050 0.070 0.09 0.11 0.13 0.15 0.17],...
    'XTickLabelRotation',-90,'YTick',...
    [-0.17 -0.15 -0.13 -0.11 -0.09 -0.070 -0.050 -0.030 -0.010 0.010 0.030 0.050 0.070 0.09 0.11 0.13 0.15 0.17]);     
end
xlabel('\Delta x [m]','fontsize',15,'FontName','Times','FontAngle','italic')
ylabel('\Delta y [m]','fontsize',15,'FontName','Times','FontAngle','italic')
%title=[int2str(ilosc_powtorzen) 'punktów w skanie']
%title(ax1,[int2str(ilosc_powtorzen) ' punktów w skanie'],'fontsize',15,'FontName','Times New Roman','FontAngle','normal')
tytul=([int2str(ilosc_powtorzen) ' punktów w skanie']);
%title(ax1,'Wariant II - kwadrat','fontsize',15,'FontName','Times New Roman','FontAngle','normal')
ax1.Title.String= tytul;
ax1.Title.FontName='Times New Roman';
ax1.Title.FontSize=15;
ax1.Title.FontAngle='italic';
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\' 'o'  int2str(ilosc_powtorzen) '.jpg'];
%set(gcf, 'Position', get(0, 'Screensize'));
%saveas(gcf,filename);
%print(dest.Parent,filename,'-djpeg', '-r500')
hold off
close all

ax2 = subplot(1,1,1); % middle subplot
dest=ax2;

cov_zwy_k=cov(icp0k(:,1:2,c));
cov_hub_k=cov(icp1k(:,1:2,c));
cov_kier_k=cov(icp2k(:,1:2,c));
cov_sre_k=cov(icp3k(:,1:2,c));
cov_wek_k=cov(icp4k(:,1:2,c));

plotErrorEllipse([mean(icp2k(:,1,c)),mean(icp2k(:,2,c))], cov_kier_k, 0.95, 'blue',1,dest)
hold on
plotErrorEllipse([mean(icp1k(:,1,c)),mean(icp1k(:,2,c))], cov_hub_k, 0.95, 'red',1,dest)
plotErrorEllipse([mean(icp2k(:,1,c)),mean(icp2k(:,2,c))], cov_zwy_k, 0.95, 'black',1,dest)
plotErrorEllipse([mean(icp4k(:,1,c)),mean(icp4k(:,2,c))], cov_wek_k, 0.95, 'green',1,dest)
plotErrorEllipse([mean(icp3k(:,1,c)),mean(icp3k(:,2,c))], cov_sre_k, 0.95, 'yellow',1,dest)
daspect([1 1 1])
scatter(1,0,'black','filled')

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
%l=legend('ICP klasyczny','ICP odporny','ICP odp.- wsp. b³¹d œredni','ICP odporny - wsp. kierunkowy b³¹d œredni w kierunku','ICP odporny - wsp. b³¹d œredni wektorowy')
%legend('Location','southoutside')
%l.NumColumns=1;
grid on
%%axis([-0.035 0.035 -0.055 0.055])
%title(ax2,'RUCH WEWN¥TRZ OKRÊGU')

if ilosc_powtorzen<200
    axis([-0.17 0.17 -0.17 0.17])
end

if ilosc_powtorzen>=200 && ilosc_powtorzen<400
    axis([-0.07 0.07 -0.07 0.07])
end

if ilosc_powtorzen>=400 
    axis([-0.035 0.035 -0.035 0.035])
end
xlabel(ax2,'\Delta x [m]','fontsize',15,'FontName','Times New Roman','FontAngle','italic')
ylabel(ax2,'\Delta y [m]','fontsize',15,'FontName','Times New Roman','FontAngle','italic')
set(ax2,'DataAspectRatio',[1 1 1],'FontAngle','italic','FontName',...
    'Times','FontSize',15);
%title(ax2,'Wariant II - kwadrat','fontsize',15,'FontName','Times New Roman','FontAngle','normal')
if ilosc_powtorzen>=200
set(ax2,'DataAspectRatio',[1 1 1],'FontAngle','italic','FontName',...
    'Times','FontSize',15,'XTick',[-0.15 -0.145 -0.14 -0.135 -0.13 -0.125 -0.12 -0.115 -0.11 -0.105 -0.1 -0.095 -0.09 -0.085 -0.08 -0.075 -0.070 -0.065 -0.060 -0.055 -0.050 -0.045 -0.040 -0.035 -0.030 -0.025 -0.020 -0.015 -0.010 -0.005 0 0.005 0.010 0.015 0.020 0.025 0.030 0.035 0.040 0.045 0.050 0.055 0.060 0.065 0.070 0.075 0.08 0.085 0.09 0.095 0.1 0.105 0.11 0.115 0.12 0.125 0.13 0.135 0.14 0.145 0.15],...
    'XTickLabelRotation',-90,'YTick',...
    [-0.15 -0.145 -0.14 -0.135 -0.13 -0.125 -0.12 -0.115 -0.11 -0.105 -0.1 -0.095 -0.09 -0.085 -0.08 -0.075 -0.070 -0.065 -0.060 -0.055 -0.050 -0.045 -0.040 -0.035 -0.030 -0.025 -0.020 -0.015 -0.010 -0.005 0 0.005 0.010 0.015 0.020 0.025 0.030 0.035 0.040 0.045 0.050 0.055 0.060 0.065 0.070 0.075 0.08 0.085 0.09 0.095 0.1 0.105 0.11 0.115 0.12 0.125 0.13 0.135 0.14 0.145 0.15]);
end

if ilosc_powtorzen<350 && ilosc_powtorzen>150
set(ax2,'DataAspectRatio',[1 1 1],'FontAngle','italic','FontName',...
    'Times','FontSize',15,'XTick',[-0.15 -0.14 -0.13 -0.12 -0.11 -0.1 -0.09 -0.08 -0.070 -0.060 -0.050 -0.040 -0.030 -0.020 -0.010 0.010 0.020 0.030 0.040 0.050 0.060 0.070 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15],...
    'XTickLabelRotation',-90,'YTick',...
    [-0.15 -0.14 -0.13 -0.12 -0.11 -0.1 -0.09 -0.08 -0.070 -0.060 -0.050 -0.040 -0.030 -0.020 -0.010 0 0.010 0.020 0.030 0.040 0.050 0.060 0.070 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15]);    
end
if ilosc_powtorzen <150  
 set(ax2,'DataAspectRatio',[1 1 1],'FontAngle','italic','FontName',...
    'Times','FontSize',15,'XTick',[-0.17 -0.15 -0.13 -0.11 -0.09 -0.070 -0.050 -0.030 -0.010 0.010 0.030 0.050 0.070 0.09 0.11 0.13 0.15 0.17],...
    'XTickLabelRotation',-90,'YTick',...
    [-0.17 -0.15 -0.13 -0.11 -0.09 -0.070 -0.050 -0.030 -0.010 0.010 0.030 0.050 0.070 0.09 0.11 0.13 0.15 0.17]);     
end

ax2.Title.String= tytul;
ax2.Title.FontName='Times New Roman';
ax2.Title.FontSize=15;
ax2.Title.FontAngle='italic';
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\' 'k' int2str(ilosc_powtorzen) '.jpg'];
%set(gcf, 'Position', get(0, 'Screensize'));
%saveas(gcf,filename);
%print(dest.Parent,filename,'-djpeg', '-r500')
ilosc_powtorzen=ilosc_powtorzen+10;
c=c+2;
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