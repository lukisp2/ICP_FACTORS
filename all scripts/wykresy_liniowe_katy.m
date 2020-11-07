%% kwadrat
Kx1=mean(sqrt((icp1k(:,3,:)-2).^2));
KX1(:)=Kx1(1,1,:);
Kx2=mean(sqrt((icp2k(:,3,:)-2).^2));
KX2(:)=Kx2(1,1,:);
Kx3=mean(sqrt((icp3k(:,3,:)-2).^2));
KX3(:)=Kx3(1,1,:);
Kx4=mean(sqrt((icp4k(:,3,:)-2).^2));
KX4(:)=Kx4(1,1,:);
os_x=[100:2:1000]
fig1=plot(os_x,KX1(1:451),'red');
%tit={'B³¹d sredni $\hat{\theta}$'}
title('B³¹d œredni k¹ta \theta_1')
xlabel('Liczba punktów w skanie')
ylabel('Wartoœæ b³êdu œredniego \theta_1 [\circ] ')
hold on
fig2=plot(os_x,KX2(1:451),'blue');
fig3=plot(os_x,KX3(1:451),'yellow');
fig4=plot(os_x,KX4(1:451),'green');
fig1.LineWidth = 1.5;
fig2.LineWidth = 1.5;
fig3.LineWidth = 1.5;
fig4.LineWidth = 1.5;
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
ytick=[miny:0.25:maxy]
xlim([100 1000])
yticks(ytick)
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
box on
set(gca, 'YScale', 'log') 
set(gcf, 'Position', get(0, 'Screensize')/1.5);
set(gca, 'YScale', 'log')
l=legend('ICP odporny','ICP odporny - wsp. b³¹d œredni','ICP odporny - wsp. b³¹d œredni w kierunku','ICP odporny - wsp. b³¹d œredniwektorowy')
legend('Location','northeast')
l.NumColumns=1;
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\blad_k_k.jpg'];
%saveas(gcf,filename);
print(ax.Parent,filename,'-djpeg', '-r500')
hold off
close all

licznik=0;
for i = 1:451
    if KX1(1,i)<=KX2(1,i) && KX1(1,i)<=KX3(1,i) && KX1(1,i)<=KX4(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451
    if KX2(1,i)<=KX1(1,i) && KX2(1,i)<=KX3(1,i) && KX2(1,i)<=KX4(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451
    if KX3(1,i)<=KX2(1,i) && KX3(1,i)<=KX1(1,i) && KX3(1,i)<=KX4(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451
    if KX4(1,i)<=KX2(1,i) && KX4(1,i)<=KX3(1,i) && KX4(1,i)<=KX1(1,i)
      licznik=licznik+1      
    end
end




%% okr?g
Kx1=mean(sqrt((icp1o(:,3,:)-2).^2));
KX1(:)=Kx1(1,1,:);
Kx2=mean(sqrt((icp2o(:,3,:)-2).^2));
KX2(:)=Kx2(1,1,:);
Kx3=mean(sqrt((icp3o(:,3,:)-2).^2));
KX3(:)=Kx3(1,1,:);
Kx4=mean(sqrt((icp4o(:,3,:)-2).^2));
KX4(:)=Kx4(1,1,:);
os_x=[100:2:1000]
fig1=plot(os_x,KX1(1:451),'red');
%tit={'B³¹d sredni $\hat{\theta}$'}
title('B³¹d œredni k¹ta \theta_1')
xlabel('Liczba punktów w skanie')
ylabel('Wartoœæ b³êdu œredniego \theta_1 [\circ] ')
hold on
fig2=plot(os_x,KX2(1:451),'blue');
fig3=plot(os_x,KX3(1:451),'yellow');
fig4=plot(os_x,KX4(1:451),'green');
fig1.LineWidth = 1.5;
fig2.LineWidth = 1.5;
fig3.LineWidth = 1.5;
fig4.LineWidth = 1.5;
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
ytick=[miny:0.25:maxy]
xlim([100 1000])
yticks(ytick)
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
box on
set(gca, 'YScale', 'log') 
set(gcf, 'Position', get(0, 'Screensize')/1.5);
set(gca, 'YScale', 'log')
l=legend('ICP odporny','ICP odporny - wsp. b³¹d œredni','ICP odporny - wsp. b³¹d œredniw kierunku','ICP odporny - wsp. b³¹d œredniwektorowy')
legend('Location','northeast')
l.NumColumns=1;
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\blad_k_o.jpg'];
%saveas(gcf,filename);
print(ax.Parent,filename,'-djpeg', '-r500')
hold off
close all


licznik=0;
for i = 1:451
    if KX1(1,i)<=KX2(1,i) && KX1(1,i)<=KX3(1,i) && KX1(1,i)<=KX4(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451
    if KX2(1,i)<=KX1(1,i) && KX2(1,i)<=KX3(1,i) && KX2(1,i)<=KX4(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451
    if KX3(1,i)<=KX2(1,i) && KX3(1,i)<=KX1(1,i) && KX3(1,i)<=KX4(1,i)
      licznik=licznik+1      
    end
end

licznik=0;
for i = 1:451
    if KX4(1,i)<=KX2(1,i) && KX4(1,i)<=KX3(1,i) && KX4(1,i)<=KX1(1,i)
      licznik=licznik+1      
    end
end



%% œrednie k?ty
for c=1:1:451
m1o(c)=mean(icp1o(:,3,c));
m2o(c)=mean(icp2o(:,3,c));
m3o(c)=mean(icp3o(:,3,c));
m4o(c)=mean(icp4o(:,3,c));
end
fig1=plot(os_x,m1o(1:451),'red');
title('Œrednia wartoœæ k¹ta \theta_1')
xlabel('Liczba punktów w skanie')
ylabel('Wartoœæ œrednia \theta_1 [\circ] ')
hold on
fig2=plot(os_x,m2o(1:451),'blue');
fig3=plot(os_x,m3o(1:451),'yellow');
fig4=plot(os_x,m4o(1:451),'green');
fig1.LineWidth = 1.5;
fig2.LineWidth = 1.5;
fig3.LineWidth = 1.5;
fig4.LineWidth = 1.5;
ax = gca;
ax.FontSize = 15; 
set(ax,'FontSize',15,'FontAngle','italic','FontName','Times')
xlim([100 1000])
xtick =[100:100:1000];
xticks(xtick)


LineH = get(gca, 'children');
Valuey = get(LineH, 'YData');
Valuex = get(LineH, 'XData');
maxx =max(max(cell2mat(Valuex)));
maxy =max(max(cell2mat(Valuey)));
minx=min(min(cell2mat(Valuex)));
miny=min(min(cell2mat(Valuey)));
ylim([miny maxy])


set(gcf, 'Position', get(0, 'Screensize')/1.5);
grid on
grid minor
l=legend('ICP odporny','ICP odporny - wsp. b³¹d œredni','ICP odporny - wsp. b³¹d œredniw kierunku','ICP odporny - wsp. b³¹d œredniwektorowy')
legend('Location','southeast')
l.NumColumns=1;
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\sr_k_o.jpg'];
print(ax.Parent,filename,'-djpeg', '-r500')
hold off 
close all


for c=1:1:451
m1k(c)=mean(icp1k(:,3,c));
m2k(c)=mean(icp2k(:,3,c));
m3k(c)=mean(icp3k(:,3,c));
m4k(c)=mean(icp4k(:,3,c));
end
fig1=plot(os_x,m1k(1:451),'red');
title('Œrednia wartoœæ k¹ta \theta_1')
xlabel('Liczba punktów w skanie')
ylabel('Wartoœæ œrednia \theta_1 [\circ] ')
hold on
fig2=plot(os_x,m2k(1:451),'blue');
fig3=plot(os_x,m3k(1:451),'yellow');
fig4=plot(os_x,m4k(1:451),'green');
fig1.LineWidth = 1.5;
fig2.LineWidth = 1.5;
fig3.LineWidth = 1.5;
fig4.LineWidth = 1.5;
ax = gca;
ax.FontSize = 15; 
set(ax,'FontSize',15,'FontAngle','italic','FontName','Times')
xlim([100 1000])
xtick =[100:100:1000];
xticks(xtick)



LineH = get(gca, 'children');
Valuey = get(LineH, 'YData');
Valuex = get(LineH, 'XData');
maxx =max(max(cell2mat(Valuex)));
maxy =max(max(cell2mat(Valuey)));
minx=min(min(cell2mat(Valuex)));
miny=min(min(cell2mat(Valuey)));
ylim([miny maxy])



set(gcf, 'Position', get(0, 'Screensize')/1.5);
grid on
grid minor
l=legend('ICP odporny','ICP odporny - wsp. b³¹d œredni','ICP odporny - wsp. b³¹d œredniw kierunku','ICP odporny - wsp. b³¹d œredniwektorowy')
legend('Location','southeast')
l.NumColumns=1;
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\sr_k_k.jpg'];
print(ax.Parent,filename,'-djpeg', '-r500')
hold off 
close all

%% predkosc
for c=1:1:451
sv1(c)=mean(sqrt((icp1k(:,1,c)).^2+(icp1k(:,2,c).^2)))
sv2(c)=mean(sqrt((icp2k(:,1,c)).^2+(icp2k(:,2,c).^2)))
sv3(c)=mean(sqrt((icp3k(:,1,c)).^2+(icp3k(:,2,c).^2)))
sv4(c)=mean(sqrt((icp4k(:,1,c)).^2+(icp4k(:,2,c).^2)))
end
fig1=plot(os_x,sv1(1:451),'red');
title('Œrednia wartoœæ V')
xlabel('Liczba punktów w skanie')
ylabel('Wartoœæ œrednia V ')
hold on
fig2=plot(os_x,sv2(1:451),'blue');
fig3=plot(os_x,sv3(1:451),'yellow');
fig4=plot(os_x,sv4(1:451),'green');
fig1.LineWidth = 1.5;
fig2.LineWidth = 1.5;
fig3.LineWidth = 1.5;
fig4.LineWidth = 1.5;
ax = gca;
ax.FontSize = 15; 
set(ax,'FontSize',15,'FontAngle','italic','FontName','Times')
xlim([400 1000])
xtick =[100:100:1000];
xticks(xtick)
set(gcf, 'Position', get(0, 'Screensize')/1.5);
grid on
grid minor
l=legend('ICP odporny','ICP odporny - wsp. b³¹d œredniw kierunku','ICP odporny - wsp. b³¹d œredni','ICP odporny - wsp. b³¹d œredniwektorowy')
legend('Location','southeast')
l.NumColumns=1;
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\sr_V_k.jpg'];
print(ax.Parent,filename,'-djpeg', '-r500')
hold off 
close all

for c=1:1:96
sv1(c)=mean(sqrt((icp1o(:,1,c)).^2+(icp1o(:,2,c).^2)))
sv2(c)=mean(sqrt((icp2o(:,1,c)).^2+(icp2o(:,2,c).^2)))
sv3(c)=mean(sqrt((icp3o(:,1,c)).^2+(icp3o(:,2,c).^2)))
sv4(c)=mean(sqrt((icp4o(:,1,c)).^2+(icp4o(:,2,c).^2)))
end
fig1=plot(os_x,sv1(1:451),'red');
title('Œrednia wartoœæ V')
xlabel('Liczba punktów w skanie')
ylabel('Wartoœæ œrednia V ')
hold on
fig2=plot(os_x,sv2(1:451),'blue');
fig3=plot(os_x,sv3(1:451),'yellow');
fig4=plot(os_x,sv4(1:451),'green');
fig1.LineWidth = 1.5;
fig2.LineWidth = 1.5;
fig3.LineWidth = 1.5;
fig4.LineWidth = 1.5;
ax = gca;
ax.FontSize = 15; 
set(ax,'FontSize',15,'FontAngle','italic','FontName','Times')
xlim([400 1000])
xtick =[100:100:1000];
xticks(xtick)
set(gcf, 'Position', get(0, 'Screensize')/1.5);
grid on
grid minor
l=legend('ICP odporny','ICP odporny - wsp. b³¹d œredniw kierunku','ICP odporny - wsp. b³¹d œredni','ICP odporny - wsp. b³¹d œredniwektorowy')
legend('Location','southeast')
l.NumColumns=1;
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\sr_V_o.jpg'];
print(ax.Parent,filename,'-djpeg', '-r500')
hold off 
close all
