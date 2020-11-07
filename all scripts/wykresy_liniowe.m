%% odpal po za³¹czeniu pliku wykresy.m 
%% kwadrat
os_x=[100:2:1000]
subplot(1,2,1);
%% B³¹d x
B1x=mean(sqrt((icp1k(:,1,:)).^2));
B1X(:)=B1x(1,1,:);
B2x=mean(sqrt((icp2k(:,1,:)).^2));
B2X(:)=B2x(1,1,:);
B3x=mean(sqrt((icp3k(:,1,:)).^2));
B3X(:)=B3x(1,1,:);
B4x=mean(sqrt((icp4k(:,1,:)).^2));
B4X(:)=B4x(1,1,:);
%% B³¹d y
B1y=mean(sqrt((icp1k(:,2,:)-1).^2));
B1Y(:)=B1y(1,1,:);
B2y=mean(sqrt((icp2k(:,2,:)-1).^2));
B2Y(:)=B2y(1,1,:);
B3y=mean(sqrt((icp3k(:,2,:)-1).^2));
B3Y(:)=B3y(1,1,:);
B4y=mean(sqrt((icp4k(:,2,:)-1).^2));
B4Y(:)=B4y(1,1,:);
%% B³¹d pozycji
M1=sqrt(B1X.^2+B1Y.^2);
M2=sqrt(B2X.^2+B2Y.^2);
M3=sqrt(B3X.^2+B3Y.^2);
M4=sqrt(B4X.^2+B4Y.^2);

licznik=0;
for i = 1:451  
    if B2Y(1,i)<=B4Y(1,i) && B2Y(1,i)<=B3Y(1,i) && B2Y(1,i)<=B1Y(1,i)
      licznik=licznik+1      
    end
end


%fig1=plot(os_x,sigma_x_zwy_k(1,6:96),'black');


fig2=plot(os_x,B1X(1,1:451  ),'red');
title('B³¹d ?redni wsp??rz?dnej x_1')
xlabel('Liczba punkt?w w skanie')
ylabel('Warto?? b??du ?redniego x_{1}  [m]', 'Interpreter', 'tex')
%%
%title('Mean error of x_1')
%xlabel('Number of points in a single scan')
%ylabel('Mean error value x_{1}  [m]', 'Interpreter', 'tex')
%%
hold on
fig3=plot(os_x,B3X(1,1:451  ),'yellow');
fig4=plot(os_x,B2X(1,1:451  ),'blue');
fig5=plot(os_x,B4X(1,1:451  ),'green');
%fig1.LineWidth = 1.0;
fig2.LineWidth = 1.0;
fig3.LineWidth = 1.0;
fig4.LineWidth = 1.0;
fig5.LineWidth = 1.0;
ax = gca;
ax.FontSize = 15; 
set(ax,'FontSize',15,'FontAngle','italic','FontName','Times')

LineH = get(gca, 'children');
Valuey = get(LineH, 'YData');
Valuex = get(LineH, 'XData');
maxx =max(max(cell2mat(Valuex)));
maxy =max(max(cell2mat(Valuey)));
minx=min(min(cell2mat(Valuex)));
miny=min(min(cell2mat(Valuey)));
ylim([miny maxy])
ytick=[miny:0.01:maxy]
xlim([100 1000])
yticks(ytick)
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
box on
set(gca, 'YScale', 'log')

subplot(1,2,2);
%fig1=plot(os_x,sigma_y_zwy_k(1,6:96),'black');
title('B³¹d ?redni wsp??rz?dnej y_1')
xlabel('Liczba punkt?w w skanie')
ylabel('Warto?? b??du ?redniego y_1 [m]')

%%
%title('Mean error of y_1')
%xlabel('Number of points in a single scan')
%ylabel('Mean error value y_{1}  [m]', 'Interpreter', 'tex')
%%

%ylabel('Warto?? b??du ?redniego [m]', 'Interpreter','latex', 'fontname', 'Times', 'fontsize', 14)
hold on
fig2=plot(os_x,B1Y(1,1:451  ),'red');
hold on
fig3=plot(os_x,B3Y(1,1:451  ),'yellow');
fig4=plot(os_x,B2Y(1,1:451  ),'blue');
fig5=plot(os_x,B4Y(1,1:451  ),'green');
%fig1.LineWidth = 1.0;
fig2.LineWidth = 1.0;
fig3.LineWidth = 1.0;
fig4.LineWidth = 1.0;
fig5.LineWidth = 1.0;
ax = gca;
ax.FontSize = 16; 
set(ax,'FontSize',15,'FontAngle','italic','FontName','Times')

LineH = get(gca, 'children');
Valuey = get(LineH, 'YData');
Valuex = get(LineH, 'XData');
maxx =max(max(cell2mat(Valuex)));
maxy =max(max(cell2mat(Valuey)));
minx=min(min(cell2mat(Valuex)));
miny=min(min(cell2mat(Valuey)));
ylim([miny maxy])
ytick=[miny:0.01:maxy]
xlim([100 1000])
yticks(ytick)
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
box on
set(gca, 'YScale', 'log')
set(gcf, 'Position', get(0, 'Screensize')/1.5);
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\blad_xy_k.jpg'];
%saveas(gcf,filename);
print(ax.Parent,filename,'-djpeg', '-r500')
%saveas(gcf,'fig1.jpeg')
hold off
close all

subplot(1,1,1);
%M=sqrt(sigma_y_zwy_k(1,6:96).*sigma_y_zwy_k(1,6:96)+sigma_x_zwy_k(1,6:96).*sigma_x_zwy_k(1,6:96));
%fig1=plot(os_x,M,'black');

%M=sqrt(sigma_y_hub_k(1,6:96).*sigma_y_hub_k(1,6:96)+sigma_x_hub_k(1,6:96).*sigma_x_hub_k(1,6:96));
fig2=plot(os_x,M1(1:451  ),'red');
title('B³¹d ?redni wsp??rz?dnych pozycji X_1')
xlabel('Liczba punkt?w w skanie')
ylabel('Warto?? b??du ?redniego X_1 [m]')

%%
%title('Mean error of X_1')
%xlabel('Number of points in a single scan')
%ylabel('Mean error value X_{1}  [m]', 'Interpreter', 'tex')
%%
hold on
%M=sqrt(sigma_y_sre_k(1,6:96).*sigma_y_sre_k(1,6:96)+sigma_x_sre_k(1,6:96).*sigma_x_sre_k(1,6:96));
fig3=plot(os_x,M3(1:451  ),'yellow');
%M=sqrt(sigma_y_kier_k(1,6:96).*sigma_y_kier_k(1,6:96)+sigma_x_kier_k(1,6:96).*sigma_x_kier_k(1,6:96));
fig4=plot(os_x,M2(1:451  ),'blue');
%M=sqrt(sigma_y_wek_k(1,6:96).*sigma_y_wek_k(1,6:96)+sigma_x_wek_k(1,6:96).*sigma_x_wek_k(1,6:96));
fig5=plot(os_x,M4(1:451  ),'green');
%fig1.LineWidth = 1.0;
fig2.LineWidth = 1.0;
fig3.LineWidth = 1.0;
fig4.LineWidth = 1.0;
fig5.LineWidth = 1.0;
ax = gca;
ax.FontSize = 16; 
set(ax,'FontSize',15,'FontAngle','italic','FontName','Times')
LineH = get(gca, 'children');
Valuey = get(LineH, 'YData');
Valuex = get(LineH, 'XData');
maxx =max(max(cell2mat(Valuex)));
maxy =max(max(cell2mat(Valuey)));
minx=min(min(cell2mat(Valuex)));
miny=min(min(cell2mat(Valuey)));
ylim([miny maxy])
ytick=[miny:0.01:maxy]
xlim([100 1000])
yticks(ytick)
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
box on
set(gca, 'YScale', 'log')
l=legend('ICP odporny','ICP odporny - wsp. b??d ?redni','ICP odporny - wsp. b??d ?redni w kierunku','ICP odporny - wsp. b??d ?redni wektorowy')
%l=legend('ICP robust','ICP robust - mean error weighting','ICP robust  directional mean error weighting','ICP robust vector error')

legend('Location','northeast')
l.NumColumns=1;
set(gcf, 'Position', get(0, 'Screensize')/1.5);
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\blad_k.jpg'];
%saveas(gcf,filename);
print(ax.Parent,filename,'-djpeg', '-r500')
 %saveas(gcf,'fig1.jpeg')
 hold off
close all






%%%%%%%%%%%%%%%%%

licznik=0;
for i = 1:451  
    if M2(1,i)<=M4(1,i) && M2(1,i)<=M3(1,i) && M2(1,i)<=M1(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if M4(1,i)<=M2(1,i) && M4(1,i)<=M3(1,i) && M4(1,i)<=M1(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if M3(1,i)<=M2(1,i) && M3(1,i)<=M1(1,i) && M3(1,i)<=M4(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if M1(1,i)<=M2(1,i) && M1(1,i)<=M3(1,i) && M1(1,i)<=M4(1,i)
      licznik=licznik+1      
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
licznik=0;
for i = 1:451  
    if B2x(1,i)<=B4x(1,i) && B2x(1,i)<=B3x(1,i) && B2x(1,i)<=B1x(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if B4x(1,i)<=B2x(1,i) && B4x(1,i)<=B3x(1,i) && B4x(1,i)<=B1x(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if B3x(1,i)<=B2x(1,i) && B3x(1,i)<=B1x(1,i) && B3x(1,i)<=B4x(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if B1x(1,i)<=B2x(1,i) && B1x(1,i)<=B3x(1,i) && B1x(1,i)<=B4x(1,i)
      licznik=licznik+1      
    end
end
licznik=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:451  
    if B2y(1,i)<=B4y(1,i) && B2y(1,i)<=B3y(1,i) && B2y(1,i)<=B1y(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if B4y(1,i)<=B2y(1,i) && B4y(1,i)<=B3y(1,i) && B4y(1,i)<=B1y(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if B3y(1,i)<=B2y(1,i) && B3y(1,i)<=B1y(1,i) && B3y(1,i)<=B4y(1,i)
      licznik=licznik+1      
    end
end

 licznik=0;
for i = 1:451  
    if B1y(1,i)<=B2y(1,i) && B1y(1,i)<=B3y(1,i) && B1y(1,i)<=B4y(1,i)
      licznik=licznik+1      
    end
end















%% okr?g
%% odpal po za??czeniu pliku wykresy.m 
os_x=[100:2:1000]
subplot(1,2,1);
%% B³¹d x
B1x=mean(sqrt((icp1o(:,1,:)).^2));
B1X(:)=B1x(1,1,:);
B2x=mean(sqrt((icp2o(:,1,:)).^2));
B2X(:)=B2x(1,1,:);
B3x=mean(sqrt((icp3o(:,1,:)).^2));
B3X(:)=B3x(1,1,:);
B4x=mean(sqrt((icp4o(:,1,:)).^2));
B4X(:)=B4x(1,1,:);
%% B³¹d y
B1y=mean(sqrt((icp1o(:,2,:)-1).^2));
B1Y(:)=B1y(1,1,:);
B2y=mean(sqrt((icp2o(:,2,:)-1).^2));
B2Y(:)=B2y(1,1,:);
B3y=mean(sqrt((icp3o(:,2,:)-1).^2));
B3Y(:)=B3y(1,1,:);
B4y=mean(sqrt((icp4o(:,2,:)-1).^2));
B4Y(:)=B4y(1,1,:);
%% B³¹d pozycji
M1=sqrt(B1X.^2+B1Y.^2);
M2=sqrt(B2X.^2+B2Y.^2);
M3=sqrt(B3X.^2+B3Y.^2);
M4=sqrt(B4X.^2+B4Y.^2);



licznik=0;
for i = 1:451  
    if M2(1,i)<=M4(1,i) && M2(1,i)<=M3(1,i) && M2(1,i)<=M1(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if M4(1,i)<=M2(1,i) && M4(1,i)<=M3(1,i) && M4(1,i)<=M1(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if M3(1,i)<=M2(1,i) && M3(1,i)<=M1(1,i) && M3(1,i)<=M4(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if M1(1,i)<=M2(1,i) && M1(1,i)<=M3(1,i) && M1(1,i)<=M4(1,i)
      licznik=licznik+1      
    end
end





%fig1=plot(os_x,sigma_x_zwy_k(1,6:96),'black');

fig2=plot(os_x,B1X(1,1:451  ),'red');
title('Odchylenie standarodwe wspó³rzêdnej x_1')
xlabel('Liczba punkt?w w skanie')
ylabel('Warto?? b??du ?redniego x_{1}  [m]', 'Interpreter', 'tex')

%%
%title('Mean error of x_1')
%xlabel('Number of points in a single scan')
%ylabel('Mean error value x_{1}  [m]', 'Interpreter', 'tex')
%%

hold on
fig3=plot(os_x,B3X(1,1:451  ),'yellow');
fig4=plot(os_x,B2X(1,1:451  ),'blue');
fig5=plot(os_x,B4X(1,1:451  ),'green');
%fig1.LineWidth = 1.0;
fig2.LineWidth = 1.0;
fig3.LineWidth = 1.0;
fig4.LineWidth = 1.0;
fig5.LineWidth = 1.0;
ax = gca;
ax.FontSize = 15; 
set(ax,'FontSize',15,'FontAngle','italic','FontName','Times')


LineH = get(gca, 'children');
Valuey = get(LineH, 'YData');
Valuex = get(LineH, 'XData');
maxx =max(max(cell2mat(Valuex)));
maxy =max(max(cell2mat(Valuey)));
minx=min(min(cell2mat(Valuex)));
miny=min(min(cell2mat(Valuey)));
ylim([miny maxy])
ytick=[miny:0.01:maxy]
xlim([100 1000])
yticks(ytick)
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
box on
set(gca, 'YScale', 'log')

subplot(1,2,2);
%fig1=plot(os_x,sigma_y_zwy_k(1,6:96),'black');
title('B³¹d ?redni wsp??rz?dnej y_1')
xlabel('Liczba punkt?w w skanie')
ylabel('Warto?? b??du ?redniego y_1 [m]')

%%
%title('Mean error of y_1')
%xlabel('Number of points in a single scan')
%ylabel('Mean error value y_{1}  [m]', 'Interpreter', 'tex')
%%

%ylabel('Warto?? b??du ?redniego [m]', 'Interpreter','latex', 'fontname', 'Times', 'fontsize', 14)
hold on
fig2=plot(os_x,B1Y(1,1:451  ),'red');
hold on
fig3=plot(os_x,B3Y(1,1:451  ),'yellow');
fig4=plot(os_x,B2Y(1,1:451  ),'blue');
fig5=plot(os_x,B4Y(1,1:451  ),'green');
%fig1.LineWidth = 1.0;
fig2.LineWidth = 1.0;
fig3.LineWidth = 1.0;
fig4.LineWidth = 1.0;
fig5.LineWidth = 1.0;
ax = gca;
ax.FontSize = 16; 
set(ax,'FontSize',15,'FontAngle','italic','FontName','Times')
LineH = get(gca, 'children');
Valuey = get(LineH, 'YData');
Valuex = get(LineH, 'XData');
maxx =max(max(cell2mat(Valuex)));
maxy =max(max(cell2mat(Valuey)));
minx=min(min(cell2mat(Valuex)));
miny=min(min(cell2mat(Valuey)));
ylim([miny maxy])
ytick=[miny:0.01:maxy]
xlim([100 1000])
yticks(ytick)
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
box on
set(gca, 'YScale', 'log')
set(gcf, 'Position', get(0, 'Screensize')/1.5);
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\blad_xy_o.jpg'];
%saveas(gcf,filename);
print(ax.Parent,filename,'-djpeg', '-r500')
%saveas(gcf,'fig1.jpeg')
hold off
close all

subplot(1,1,1);
%M=sqrt(sigma_y_zwy_k(1,6:96).*sigma_y_zwy_k(1,6:96)+sigma_x_zwy_k(1,6:96).*sigma_x_zwy_k(1,6:96));
%fig1=plot(os_x,M,'black');

%M=sqrt(sigma_y_hub_k(1,6:96).*sigma_y_hub_k(1,6:96)+sigma_x_hub_k(1,6:96).*sigma_x_hub_k(1,6:96));
fig2=plot(os_x,M1(1:451  ),'red');
title('B³¹d ?redni wsp??rz?dnych pozycji X_1')
xlabel('Liczba punkt?w w skanie')
ylabel('Warto?? b??du ?redniego X_1 [m]')

%%
%title('Mean error of X_1')
%xlabel('Number of points in a single scan')
%ylabel('Mean error value X_{1}  [m]', 'Interpreter', 'tex')
%%

hold on
%M=sqrt(sigma_y_sre_k(1,6:96).*sigma_y_sre_k(1,6:96)+sigma_x_sre_k(1,6:96).*sigma_x_sre_k(1,6:96));
fig3=plot(os_x,M3(1:451  ),'yellow');
%M=sqrt(sigma_y_kier_k(1,6:96).*sigma_y_kier_k(1,6:96)+sigma_x_kier_k(1,6:96).*sigma_x_kier_k(1,6:96));
fig4=plot(os_x,M2(1:451  ),'blue');
%M=sqrt(sigma_y_wek_k(1,6:96).*sigma_y_wek_k(1,6:96)+sigma_x_wek_k(1,6:96).*sigma_x_wek_k(1,6:96));
fig5=plot(os_x,M4(1:451  ),'green');
%fig1.LineWidth = 1.0;
fig2.LineWidth = 1.0;
fig3.LineWidth = 1.0;
fig4.LineWidth = 1.0;
fig5.LineWidth = 1.0;
ax = gca;
ax.FontSize = 16; 
set(ax,'FontSize',15,'FontAngle','italic','FontName','Times')
LineH = get(gca, 'children');
Valuey = get(LineH, 'YData');
Valuex = get(LineH, 'XData');
maxx =max(max(cell2mat(Valuex)));
maxy =max(max(cell2mat(Valuey)));
minx=min(min(cell2mat(Valuex)));
miny=min(min(cell2mat(Valuey)));
ylim([miny maxy])
ytick=[miny:0.01:maxy]
xlim([100 1000])
yticks(ytick)
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
box on
set(gca, 'YScale', 'log')

l=legend('ICP odporny','ICP odporny - wsp. b??d ?redni','ICP odporny - wsp. b??d ?redni w kierunku','ICP odporny - wsp. b??d ?redni wektorowy')

%l=legend('ICP robust','ICP robust - mean error weighting','ICP robust  directional mean error weighting','ICP robust vector error')

legend('Location','northeast')
l.NumColumns=1;
set(gcf, 'Position', get(0, 'Screensize')/1.5);
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\blad_o.jpg'];
%saveas(gcf,filename);
print(ax.Parent,filename,'-djpeg', '-r500')
 %saveas(gcf,'fig1.jpeg')
 hold off
close all


%%%%%%%%%%%%%%%%%

licznik=0;
for i = 1:451  
    if M2(1,i)<=M4(1,i) && M2(1,i)<=M3(1,i) && M2(1,i)<=M1(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if M4(1,i)<=M2(1,i) && M4(1,i)<=M3(1,i) && M4(1,i)<=M1(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if M3(1,i)<=M2(1,i) && M3(1,i)<=M1(1,i) && M3(1,i)<=M4(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if M1(1,i)<=M2(1,i) && M1(1,i)<=M3(1,i) && M1(1,i)<=M4(1,i)
      licznik=licznik+1      
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
licznik=0;
for i = 1:451  
    if B2x(1,i)<=B4x(1,i) && B2x(1,i)<=B3x(1,i) && B2x(1,i)<=B1x(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if B4x(1,i)<=B2x(1,i) && B4x(1,i)<=B3x(1,i) && B4x(1,i)<=B1x(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if B3x(1,i)<=B2x(1,i) && B3x(1,i)<=B1x(1,i) && B3x(1,i)<=B4x(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if B1x(1,i)<=B2x(1,i) && B1x(1,i)<=B3x(1,i) && B1x(1,i)<=B4x(1,i)
      licznik=licznik+1      
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:451  
    if B2y(1,i)<=B4y(1,i) && B2y(1,i)<=B3y(1,i) && B2y(1,i)<=B1y(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if B4y(1,i)<=B2y(1,i) && B4y(1,i)<=B3y(1,i) && B4y(1,i)<=B1y(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if B3y(1,i)<=B2y(1,i) && B3y(1,i)<=B1y(1,i) && B3y(1,i)<=B4y(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451  
    if B1y(1,i)<=B2y(1,i) && B1y(1,i)<=B3y(1,i) && B1y(1,i)<=B4y(1,i)
      licznik=licznik+1      
    end
end