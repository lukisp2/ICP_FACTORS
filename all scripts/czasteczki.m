clear all
part_n=150;
generations=100;
sigma_a=deg2rad(1);
sigma_v=1;
speed=10;
COG=deg2rad(0);
%% rys 1
h=subplot(2,1,1);
p(1,2,generations,part_n)=0;

for pokolenie=1:1:generations
   for particle=1:1:part_n
       
       if pokolenie==1
       %% x 
       p(1,1,pokolenie,particle)=0;
       %% y
       p(1,2,pokolenie,particle)=0;
       else
       %% x 
       p(1,1,pokolenie,particle)=(speed+normrnd(0,sigma_v))*cos(COG+normrnd(0,sigma_a))+ p(1,1,pokolenie-1,particle);
       %% y
       p(1,2,pokolenie,particle)=(speed+normrnd(0,sigma_v))*sin(COG+normrnd(0,sigma_a))+p(1,2,pokolenie-1,particle);   
       end
       
   end
end
scatter(p(1,1,:),p(1,2,:),7.5,'.','black')
xlim([0,1010]);
ylim([-11,11]);
xlabel('x [m]')
ylabel('y [m]')
%daspect([1 1 1])
ax1 = gca;
set(ax1,'FontSize',15,'FontAngle','italic','FontName','Times');
%% rys 2
subplot(2,1,2);
sigma_a=deg2rad(2);
sigma_v=1;
p(1,2,generations,part_n)=0;

for pokolenie=1:1:generations
   for particle=1:1:part_n
       
       if pokolenie==1
       %% x 
       p(1,1,pokolenie,particle)=0;
       %% y
       p(1,2,pokolenie,particle)=0;
       else
       %% x 
       p(1,1,pokolenie,particle)=(speed+normrnd(0,sigma_v))*cos(COG+normrnd(0,sigma_a))+ p(1,1,pokolenie-1,particle);
       %% y
       p(1,2,pokolenie,particle)=(speed+normrnd(0,sigma_v))*sin(COG+normrnd(0,sigma_a))+p(1,2,pokolenie-1,particle);   
       end
       
   end
end
scatter(p(1,1,:),p(1,2,:),7.5,'.','blue')
xlim([0,1010]);
ylim([-11,11]);
%daspect([1 1 1])
xlabel('x [m]')
ylabel('y [m]')
ax2 = gca;
set(ax2,'FontSize',15,'FontAngle','italic','FontName','Times');
set(gcf, 'Position', get(0, 'Screensize')/1.5);
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\particles.jpg'];
print(h.Parent,filename,'-djpeg', '-r500')



