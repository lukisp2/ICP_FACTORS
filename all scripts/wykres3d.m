%This script illustrates a multivariate Gaussian distribution and its
%marginal distributions
%This code is issued under the CC0 "license"
%Define limits of plotting
fig = figure;
icp=icp0;
icp(:,1)=icp(:,1)-1.25;
xmean=mean(icp(:,1));
ymean=mean(icp(:,2));
%% kwadrat
%X = (xmean-0.02):0.001:(xmean+0.02);
%Y = (ymean-0.02):0.001:(ymean+0.02);
%% kó³ko
X = (xmean-0.04):0.001:(xmean+0.04);
Y = (ymean-0.04):0.001:(ymean+0.04);
%%\
%2-d Mean and covariance matrix
MeanVec(1,1) = mean(icp(:,1));
MeanVec(1,2) = mean(icp(:,2));
CovMatrix = cov(icp);

%Get the 1-d PDFs for the "walls"

Z_x = normpdf(X,xmean, sqrt(CovMatrix(1,1)));
Z_y = normpdf(Y,ymean, sqrt(CovMatrix(2,2)));

%Get the 2-d samples for the "floor"
%Samples = mvnrnd(MeanVec, CovMatrix, 10000);
Samples = icp;
%Samples = mvnrnd(MeanVec, CovMatrix, 1000);
%Samples(:,1)=Samples(:,1)-1.25
%Get the sigma ellipses by transform a circle by the cholesky decomp
L = chol(CovMatrix,'lower');
t = linspace(0,2*pi,1000); %Our ellipse will have 100 points on it
C = [cos(t) ; sin(t)]; %A unit circle
E1 = 1*L*C; E2 = 2*L*C; E3 = 3*L*C; %Get the 1,2, and 3-sigma ellipses

figure; hold on; 
%Plot the samples on the "floor"
plot3(Samples(:,1),Samples(:,2),zeros(size(Samples,1),1),'k.','MarkerSize',8)
% Wartoœæ oczekiwana 
scatter3(0,0,0,'*',"LineWidth",2,'MarkerFaceColor','green')
%Plot the 1,2, and 3-sigma ellipses slightly above the floor
%plot3(E1(1,:), E1(2,:), 1e-3+zeros(1,size(E1,2)),'Color','g','LineWidth',2);
%plot3(E2(1,:), E2(2,:), 1e-3+zeros(1,size(E2,2)),'Color','g','LineWidth',2);
plot3(E3(1,:)+xmean, E3(2,:)+ymean, 1e-3+zeros(1,size(E3,2)),'Color','g','LineWidth',1);

%Plot the histograms on the walls from the data in the middle
[n_x, xout] = hist(Samples(:,1),20);%Creates 20 bars
n_x = n_x ./ ( sum(n_x) *(xout(2)-xout(1)));%Normalizes to be a pdf
[~,~,~,x_Pos,x_Height] = makebars(xout,n_x);%Creates the bar points
plot3(x_Pos, Y(end)*ones(size(x_Pos)),x_Height,'-k','HandleVisibility','off')

%Now plot the other histograms on the wall
[n_y, yout] = hist(Samples(:,2),20);
n_y = n_y ./ ( sum(n_y) *(yout(2)-yout(1)));
[~,~,~,y_Pos,y_Height] = makebars(yout,n_y);
plot3(X(1)*ones(size(y_Pos)),y_Pos, y_Height,'-k','HandleVisibility','off')

%Now plot the 1-d pdfs over the histograms
plot3(X, ones(size(X))*Y(end), Z_x,'-b','LineWidth',2); 
plot3(ones(size(Y))*X(1), Y, Z_y,'-r','LineWidth',2);


%Make the figure look nice
grid on;
view(45,55);
axis([X(1) X(end) Y(1) Y(end)])
%kwadtat
%xticks(-0.02:0.005:0.02)
%yticks(-0.02:0.005:0.02)
%kó³ko
xticks(-0.04:0.005:0.04)
yticks(-0.04:0.01:0.04)
ang=22;
xtickangle(ang)
ytickangle(-ang)
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times New Roman','fontsize',10,'FontAngle','italic')
xlabel('\Delta x [m]','fontsize',15,'FontName','Times New Roman','FontAngle','italic')
ylabel('\Delta y [m]','fontsize',15,'FontName','Times New Roman','FontAngle','italic')
zlabel('Czêstoœæ','fontsize',15,'FontName','Times New Roman','FontAngle','italic')
%l=legend('Odchy³ka wsp. poz.','Odchy³ka oczekiwana - wzorcowa ','Elipsa b³êdu odchy³ek wsp. poz. próby dla p=95%','Rozk³ad czêstoœci wystêpowania \Delta y', 'Rozk³ad czêstoœci wystêpowania \Delta x')
%legend('Location','southoutside');
%l.NumColumns=2;
%l.FontSize=15;
%l.FontName='Times New Roman'
%l.FontAngle='italic'
%Wariant I - kwadrat, ICP klasyczne
%Wariant I - kwadrat, ICP odporne 
%Wariant I - kwadrat, ICP odporne ze wsp. kierunkowym
%Wariant II - okr¹g, ICP klasyczne
%Wariant II - okr¹g, ICP odporne 
%Wariant II - okr¹g, ICP odporne ze wsp. kierunkowym
title('Wariant II - okr¹g, ICP odporne','fontsize',15,'FontName','Times New Roman','FontAngle','normal')
saveas(gcf,'Badania6.jpg')
%saveLegendToImage(fig, l, 'testImage', 'tif');