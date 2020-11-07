%% okr¹g
load('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\dane\500_kow_okr¹g.mat');
load('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\dane\500_icp_okr¹g.mat');
%% kwadrat
%load('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\dane\500_kow_kwadrat.mat');
%load('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\dane\500_icp.mat');
%%


var(3,3)=0;
for i=1:1:(500)
var=var+kowariancja_zapis(:,:,i);
end
var=var/500;
scatter(icp2o(:,2),icp2o(:,1),'.');
hold on
mu(1)=mean(icp2o(:,2));
mu(2)=mean(icp2o(:,1));
scatter(0,1.0,'x','LineWidth',3.5);
Sigma=var(1:2,1:2);
p=0.95;
kolor='blue';
skala=1;
plotErrorEllipse_bez_dest(mu, Sigma, p, kolor,skala);
daspect([1 1 1])

Sigma1=cov(icp2o(:,2),icp2o(:,1));  %% 63 66 // 87 82
kolor='black';
plotErrorEllipse_bez_dest(mu, Sigma1, p, kolor,skala);
daspect([1 1 1])

%scatter(icp0o(:,2),icp0o(:,1),'+');

title('Rozk³ad b³êdu 500 pozycji')
xlabel('[m]')
ylabel('[m]')
l=legend('Pozycja ICP','Pozycja oczekiwana','Estymowana elipsa b³êdu p=95%','Elipsa b³êdu z próby p=95%');
ax = gca;
ax.FontSize = 15; 
set(ax,'FontSize',15,'FontAngle','italic','FontName','Times')
legend('Location','southoutside')
lgd=legend;
lgd.NumColumns = 1;
ylim([1-0.03 1+0.03])
xlim([0-0.03 0+0.03])

%ylim([0.985 1.01]);
%xlim([-0.015 0.0125]);


grid on
grid minor
box on
set(gcf, 'Position', get(0, 'Screensize')/1.5);
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\kowariancja_rozklad.jpg'];
%saveas(gcf,filename);
print(ax.Parent,filename,'-djpeg', '-r500')
hold off

