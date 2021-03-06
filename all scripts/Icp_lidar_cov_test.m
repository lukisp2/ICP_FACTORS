clear all;
%load 'censi.mat'
%% Lidar Sensor Example
% Copyright 2018 The MathWorks, Inc.
%close all
%image2=imread('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\Mobile Robotics Simulation Toolbox\code\examples\matlab\okr�g2.pgm');
image2=imread('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\Mobile Robotics Simulation Toolbox\code\examples\matlab\kwadrat.pgm');
%image2=imread('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\Mobile Robotics Simulation Toolbox\code\examples\matlab\korytarz.pgm');
image2=image2<100;
liczba_pentli=50 ;
ilosc_pomiarow=250;
init_angle=deg2rad(90+0);
%% B��dy zosta�y standardowe !!!!!
sigma_range=0.03;
sigma_angle=deg2rad(0.5);
init_x=6.00;
init_y=6;
for j=1:liczba_pentli
 tic;  
%% Create environment
%load exampleMap
%load grid
%image2=imread('marina_jachty_720_edit.pgm');
map=robotics.BinaryOccupancyGrid(image2,15);
% Create lidar sensor
lidar = LidarSensor;
lidar.sensorOffset = [0,0];
lidar.scanAngles = linspace(0,2*pi,ilosc_pomiarow);
lidar.minRange= 1; 
lidar.maxRange = 40;
maxRange=lidar.maxRange*100;
maxLidarRange = 40;
mapResolution = 30;
slamAlg.LoopClosureThreshold = 210;  
slamAlg.LoopClosureSearchRadius = 8;
slamAlg = robotics.LidarSLAM(mapResolution, maxLidarRange);
%scan = lidarScan(ranges,angles);
% Create visualizer
viz = Visualizer2D;
viz.mapName = 'map';
attachLidarSensor(viz,lidar);
%% Simulation parameters
sampleTime = 0.125;              % Sample time [s]
%% k�ko
%init_x=16.00;
%init_y=16;
%% kwadrat
%init_x=8.31;
%init_y=6.5;
%init_angle=deg2rad(270);
initPose = [init_x; init_y; init_angle];        % Initial pose (x y theta)
%%
parametr = 1;
vel_error = 0.15;
K_error = 0.08;
% Initialize time, input, and pose arrays
tVec = 0:sampleTime:22;         % Time array
tVec = 0:sampleTime:0.5; 
vxRef = 1.0*ones(size(tVec))*10;   % Reference x speed
vyRef = 0.0*ones(size(tVec))*10;  % Reference y speed
wRef = zeros(size(tVec));       % Reference angular speed
wRef(tVec < 50) = 0.0;   %%-0.5;
wRef(tVec >=6.0) = 0.45;
wRef(tVec >=9.50) = 0.0;
wRef(tVec >=18.25) = -0.45;
wRef(tVec >=21.00) = 0;

%wRef(tVec <=18.75) = 0;
ref = [vxRef;vyRef;wRef];
pose = zeros(3,numel(tVec));    % Pose matrix
pose(:,1) = initPose;
% tworze macierz na przechowywanie pomiar�w
ranges_baza=zeros(ilosc_pomiarow,numel(tVec));
angles_baza=zeros(ilosc_pomiarow,numel(tVec));
global pose_baza
pose_baza =zeros(3,numel(tVec));

%% Simulation loop
i=1;
r = robotics.Rate(1/sampleTime);
for idx = 2:numel(tVec)   
    % Convert the reference speeds to world coordinates
    vel = bodyToWorld(ref(:,idx-1),pose(:,idx-1));
    %% Perform forward discrete integration step
    pose(:,idx) = pose(:,idx-1) + vel*sampleTime;
    pose_baza(idx,1)=pose(1,idx);
    pose_baza(idx,2)=pose(2,idx);
    
    % Update lidar and visualization
    ranges = lidar(pose(:,idx));
    ranges_baza(:,i)=ranges;
    %ranges_baza(1,i)=pose_baza(idx,1);
    %ranges_baza(2,i)=pose_baza(idx,2);
    
   for kat = 1 : ilosc_pomiarow
     angles_baza(kat,i)=deg2rad(kat/(ilosc_pomiarow/360))+normrnd(0,sigma_angle);
     if(ranges_baza(kat,i)>0)
     ranges_baza(kat,i) = ranges_baza(kat,i)+ normrnd(0,sigma_range); 
     end
   end
    i=i+1;
  if  j ==1
    viz(pose(:,idx),ranges)  
    waitfor(r);  
  end
end

skan= zeros(ilosc_pomiarow,2*numel(tVec)+2);
for y=1:numel(tVec)
for z=1:ilosc_pomiarow  
 skan(z,(y-1)*2+1)=cos(angles_baza(z,y))*ranges_baza(z,y);   
 skan(z,(y-1)*2+2)=sin(angles_baza(z,y))*ranges_baza(z,y);   
 
end
end
cart_ref=zeros(ilosc_pomiarow,2);
cart_next=zeros(ilosc_pomiarow,2);
cart_next_x=zeros(ilosc_pomiarow,numel(tVec)+2);
cart_next_y=zeros(ilosc_pomiarow,numel(tVec)+2);
transition_pixels=zeros(3,numel(tVec)+2);
pose_match=zeros(numel(tVec),3);
pose_grid_baza=zeros(numel(tVec),3);
for i=1:numel(tVec)
    cart_ref_x=skan(:,i*2-1);
    cart_ref_y=skan(:,i*2);
    cart_next_x=skan(:,i*2+1);
    cart_next_y=skan(:,i*2+2);
    cart_ref=cat(2,cart_ref_x,cart_ref_y);
    cart_next=cat(2,cart_next_x,cart_next_y);

    scan1=lidarScan(cart_ref);  
    scan2=lidarScan(cart_next);
    
 %pose_match(i,:)=matchScans(scan1,scan2,'MaxIterations', 1000,'CellSize',10);
 %pose_grid = matchScansGrid(scan2,scan1);
% pose_grid_baza(i,:)=pose_grid;
 %[pose,stats]=matchScans(scan1,scan2,'MaxIterations', 1000,'CellSize',10);
end
delta_pose= zeros(numel(tVec),3);
slam_pose= zeros(numel(tVec),3);
for i=1:numel(tVec)

end
slam_x=slam_pose(:,1);
slam_y=slam_pose(:,2);
for k=1:(numel(tVec)-1)
%%figure
%%plot(skan(:,2*k-1),skan(:,2*k),"k.");
skan_2x=skan(:,2*k-1+2)-pose_match(k,1);
skan_2y=skan(:,2*k+2)-pose_match(k,2);

end
pose_t=pose';

wys= 500;
szer= wys;
%global cov;
%% mapa
%map=struct;
%map.wys_mapy=6*wys;
%map.szer_mapy=6 *szer;
%map.M = zeros(map.wys_mapy,map.szer_mapy);
%map.M2=map.M;
%map.kumulacja_kata=0;
%%wspolrzedne mapy
%map.x_m=0;
%map.y_m=0;
%map.lastangm=0; %wspolrzedne mapy ostatni k�t
%% inne zmienne
TimeToStop=-1;
%background = zeros(wys);
%liczba_skanow=4;
liczba_skanow=3;
matrix1 = ones(wys,szer,liczba_skanow);
corr_max(liczba_skanow,1) = 0;
corr_max2(liczba_skanow,1) = 0;
corr_statistica=zeros(1000);
%icp
RotTransMat=zeros(liczba_skanow,4);
RotTransMat_all=zeros(liczba_skanow,4);

%%
for i=1:liczba_skanow
matrix1(:,:,i)= zeros(szer);
corr_max(i,1)=0;
corr_max2(i,1)=0;
end
hold on;
skala = 0.5*wys/maxRange;
for k=1:(liczba_skanow-liczba_skanow+1)
figure = 255*ones(wys,szer);
%imshow(figure);
hold on;

for i=1:ilosc_pomiarow
if isnan(skan(i,k*2))==0 
if isnan(skan(i,k*2+1))==0 
X=round(skala*skan(i,k*2+1)*100+szer/2,0);
Y=round(skala*skan(i,k*2)*100+wys/2,0);
if(X==0)
    X=1;
end
if(Y==0)
    Y=1;
end
matrix1(X,Y,k) = 255;

end
end
end
matrix1(:,:,k) = imgaussfilt(matrix1(:,:,k), 1.0);
fig= matrix1(:,:,k);
close;
end
%Filtr cz�steczkowy
ns=liczba_skanow;
pose=pose_baza(2:liczba_skanow+2,1:3);
pose(1,1)=155;
pose(1,2)=107.5;
poczatkowy_kurs=270;
%Inicjalizacja czasteczek
pn=1;
sigma_V=0.0;
sigma_K=deg2rad(2);
particles =struct;
best = struct;

for i=1:pn
    particles(i).pose=zeros(3,1);
    particles(i).pose(1,1)=pose(1,1);
    particles(i).pose(1,2)=pose(1,2);
    particles(i).pose(1,3)=(poczatkowy_kurs);
    particles(i).pose(1,4)=particles(i).pose(1,3);
    particles(i).pose(1,5)=-1;%predkosc wyznaczona
    particles(i).pose(1,6)=-1;%predkosc wspolczynnik
    particles(i).weight=1/pn;
    particles(i).history(3,100)=0;
    particles(i).history(1,1)=pose(1,1);
    particles(i).history(2,1)=pose(1,2);
    particles(i).history(3,1)=deg2rad(pose(1,3));
    particles(i).history(4,1)=0;
end
for i=1:liczba_skanow-1 
    KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
    %KR=atan2((pose(i-1,2)-pose(i,2)),(pose(i-1,1)-pose(i,1)))+pi;
    pose_baza(i,3)=(KR);
    pose_baza(i+2,4)= rad2deg(pose_baza(i+2,3)-pose_baza(i+1,3));
    best(i+1).REAL_COG_DIFF=pose_baza(i+2,4);
end
    for i=1:liczba_skanow-1 
%for i=1:39 
disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
    % A=matrix1(:,:,i); % zmienna do funkcji z map�
    % B=matrix1(:,:,i); % zmienna do funkcji z map� 
     best(i).x=pose(1,1);
     best(i).y=pose(1,2);
     best(i).ang=deg2rad(poczatkowy_kurs);
    
    end
    
    if i>=2
   % A=matrix1(:,:,i-1);
   % B=matrix1(:,:,i);
    KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
    %KR=atan2((pose(i-1,2)-pose(i,2)),(pose(i-1,1)-pose(i,1)))+pi;
    pose_baza(i,3)=(KR);
    %icp%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sigmaD=sigma_range;
    sigmaKK=sigma_angle;
    %% ICP KLASIK
    rodzaj=0;
    [RotTransMat,data,model,Cov,iteracja]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    data=data;
    model=model;
    RotTransMat_all(i-1,1)=RotTransMat(i-1,1);
    RotTransMat_all(i-1,2)=RotTransMat(i-1,2);
    RotTransMat_all(i-1,3)=RotTransMat(i-1,3);
    RotTransMat_all(i-1,4)=RotTransMat(i-1,4);
    
    best = znajdzbest(particles,best,i);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=acos(RotTransMat_all(i-1,1));
    best(i).waga=-1;
    best(i).V=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    best(i).V_WSP=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    if RotTransMat_all(i-1,1) >=0 && RotTransMat_all(i-1,2) >=0
    best(i).COG=rad2deg(acos(RotTransMat_all(i-1,1)));
    else
    best(i).COG=-1*rad2deg(acos(RotTransMat_all(i-1,1)));
    end
    end
    end     
    ICP0(j,1)=RotTransMat(1,3);
    ICP0(j,2)=RotTransMat(1,4);
    ICP0(j,3)=  best(i).COG;
    ICP0(j,4)=iteracja;
    
    %% ICP Huber
    for i=1:liczba_skanow-1 
%for i=1:39 
disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
    % A=matrix1(:,:,i); % zmienna do funkcji z map�
    % B=matrix1(:,:,i); % zmienna do funkcji z map� 
     best(i).x=pose(1,1);
     best(i).y=pose(1,2);
     best(i).ang=deg2rad(poczatkowy_kurs);
    end
  
    if i>=2
  %  A=matrix1(:,:,i-1);
  %  B=matrix1(:,:,i);
    KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
    %KR=atan2((pose(i-1,2)-pose(i,2)),(pose(i-1,1)-pose(i,1)))+pi;
    pose_baza(i,3)=(KR);
    %icp%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sigmaD=sigma_range;
    sigmaKK=sigma_angle;
    rodzaj=1;
    [RotTransMat,data,model,Cov,iteracja]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    data=data;
    model=model;
    RotTransMat_all(i-1,1)=RotTransMat(i-1,1);
    RotTransMat_all(i-1,2)=RotTransMat(i-1,2);
    RotTransMat_all(i-1,3)=RotTransMat(i-1,3);
    RotTransMat_all(i-1,4)=RotTransMat(i-1,4);
    best = znajdzbest(particles,best,i);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=acos(RotTransMat_all(i-1,1));
    best(i).waga=-1;
    best(i).V=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    best(i).V_WSP=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    if RotTransMat_all(i-1,1) >=0 && RotTransMat_all(i-1,2) >=0
    best(i).COG=rad2deg(acos(RotTransMat_all(i-1,1)));
    else
    best(i).COG=-1*rad2deg(acos(RotTransMat_all(i-1,1)));
    end
    end
    end     
    ICP1(j,1)=RotTransMat(1,3);
    ICP1(j,2)=RotTransMat(1,4);
    ICP1(j,3)=  best(i).COG;
    ICP1(j,4)=iteracja;
    
    
    %% ICP KIER
    for i=1:liczba_skanow-1 
%for i=1:39 
disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
 %A=matrix1(:,:,i); % zmienna do funkcji z map�
 %B=matrix1(:,:,i); % zmienna do funkcji z map� 
     best(i).x=pose(1,1);
     best(i).y=pose(1,2);
     best(i).ang=deg2rad(poczatkowy_kurs);
    
    end
    
    if i>=2
   % A=matrix1(:,:,i-1);
   % B=matrix1(:,:,i);
    KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
    %KR=atan2((pose(i-1,2)-pose(i,2)),(pose(i-1,1)-pose(i,1)))+pi;
    pose_baza(i,3)=(KR);
    %icp%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sigmaD=sigma_range;
    sigmaKK=sigma_angle;
    rodzaj=2;
    [RotTransMat,data,model,Cov,iteracja]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    data=data;
    model=model;
    RotTransMat_all(i-1,1)=RotTransMat(i-1,1);
    RotTransMat_all(i-1,2)=RotTransMat(i-1,2);
    RotTransMat_all(i-1,3)=RotTransMat(i-1,3);
    RotTransMat_all(i-1,4)=RotTransMat(i-1,4);
    best = znajdzbest(particles,best,i);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=acos(RotTransMat_all(i-1,1));
    best(i).waga=-1;
    best(i).V=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    best(i).V_WSP=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    if RotTransMat_all(i-1,1) >=0 && RotTransMat_all(i-1,2) >=0
    best(i).COG=rad2deg(acos(RotTransMat_all(i-1,1)));
    else
    best(i).COG=-1*rad2deg(acos(RotTransMat_all(i-1,1)));
    end
    end
    end     
    ICP2(j,1)=RotTransMat(1,3);
    ICP2(j,2)=RotTransMat(1,4);
    ICP2(j,3)=best(i).COG;
    ICP2(j,4)=iteracja;
     
        %% ICP �redni
        for i=1:liczba_skanow-1 
%for i=1:39 
disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
 %    A=matrix1(:,:,i); % zmienna do funkcji z map�
   %  B=matrix1(:,:,i); % zmienna do funkcji z map� 
     best(i).x=pose(1,1);
     best(i).y=pose(1,2);
     best(i).ang=deg2rad(poczatkowy_kurs);
    
    end
    
    if i>=2
   % A=matrix1(:,:,i-1);
   % B=matrix1(:,:,i);
    KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
    %KR=atan2((pose(i-1,2)-pose(i,2)),(pose(i-1,1)-pose(i,1)))+pi;
    pose_baza(i,3)=(KR);
    %icp%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sigmaD=sigma_range;
    sigmaKK=sigma_angle;
    rodzaj=3;
    [RotTransMat,data,model,Cov,iteracja]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    data=data;
    model=model;
    RotTransMat_all(i-1,1)=RotTransMat(i-1,1);
    RotTransMat_all(i-1,2)=RotTransMat(i-1,2);
    RotTransMat_all(i-1,3)=RotTransMat(i-1,3);
    RotTransMat_all(i-1,4)=RotTransMat(i-1,4);
    best = znajdzbest(particles,best,i);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=acos(RotTransMat_all(i-1,1));
    best(i).waga=-1;
    best(i).V=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    best(i).V_WSP=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    if RotTransMat_all(i-1,1) >=0 && RotTransMat_all(i-1,2) >=0
    best(i).COG=rad2deg(acos(RotTransMat_all(i-1,1)));
    else
    best(i).COG=-1*rad2deg(acos(RotTransMat_all(i-1,1)));
    end
    end
    end     
    ICP3(j,1)=RotTransMat(1,3);
    ICP3(j,2)=RotTransMat(1,4);
    ICP3(j,3)=  best(i).COG;
    ICP3(j,4)=iteracja;
       
        %% ICP Wektor
        for i=1:liczba_skanow-1 
%for i=1:39 
disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
     best(i).x=pose(1,1);
     best(i).y=pose(1,2);
     best(i).ang=deg2rad(poczatkowy_kurs);
    end
    
    if i>=2
    KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
    %KR=atan2((pose(i-1,2)-pose(i,2)),(pose(i-1,1)-pose(i,1)))+pi;
    pose_baza(i,3)=(KR);
    %icp%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sigmaD=sigma_range;
    sigmaKK=sigma_angle;
    rodzaj=4;
    [RotTransMat,data,model,Cov,iteracja]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    data=data;
    model=model;
    RotTransMat_all(i-1,1)=RotTransMat(i-1,1);
    RotTransMat_all(i-1,2)=RotTransMat(i-1,2);
    RotTransMat_all(i-1,3)=RotTransMat(i-1,3);
    RotTransMat_all(i-1,4)=RotTransMat(i-1,4);
    best = znajdzbest(particles,best,i);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=acos(RotTransMat_all(i-1,1));
    best(i).waga=-1;
    best(i).V=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    best(i).V_WSP=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    if RotTransMat_all(i-1,1) >=0 && RotTransMat_all(i-1,2) >=0
    best(i).COG=rad2deg(acos(RotTransMat_all(i-1,1)));
    else
    best(i).COG=-1*rad2deg(acos(RotTransMat_all(i-1,1)));
    end
    end
    end     
    ICP4(j,1)=RotTransMat(1,3);
    ICP4(j,2)=RotTransMat(1,4);
    ICP4(j,3)=  best(i).COG;
    ICP4(j,4)=iteracja;
    j
    toc
    time=toc;
    jj=(liczba_pentli-j)*time/60
    clear map;
end
for z= 1: liczba_pentli
    icp0(z,1)=0;
    icp0(z,2)=0;
    icp1(z,1)=0;
    icp1(z,2)=0;
    icp2(z,1)=0;
    icp2(z,2)=0;
    icp3(z,1)=0;
    icp3(z,2)=0;
    icp4(z,1)=0;
    icp4(z,2)=0;
    
end

icp0k(:,1)=ICP0(:,1);
icp0k(:,2)=ICP0(:,2); % zwyk�e icp
cov_zwy_k=cov(icp0k)
 
icp1k(:,1)=ICP1(:,1);
icp1k(:,2)=ICP1(:,2); % huber icp
cov_hub_k=cov(icp1k)
 
icp2k(:,1)=ICP2(:,1);
icp2k(:,2)=ICP2(:,2); % kierunkowe icp
cov_kier_k=cov(icp2k)

icp3k(:,1)=ICP3(:,1);
icp3k(:,2)=ICP3(:,2); %�rednie icp
cov_sre_k=cov(icp3k)

icp4k(:,1)=ICP4(:,1);
icp4k(:,2)=ICP4(:,2); %wektorowe icp
cov_wek_k =cov(icp4k)

image2=imread('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\Mobile Robotics Simulation Toolbox\code\examples\matlab\okr�g.pgm');
image2=image2<100;
init_x=6.00;
init_y=6;
for j=1:liczba_pentli
 tic;  
%% Create environment
%load exampleMap
%load grid
%image2=imread('marina_jachty_720_edit.pgm');
map=robotics.BinaryOccupancyGrid(image2,15);
% Create lidar sensor

lidar = LidarSensor;
lidar.sensorOffset = [0,0];
lidar.scanAngles = linspace(0,2*pi,ilosc_pomiarow);
lidar.minRange= 1; 
lidar.maxRange = 40;
maxRange=lidar.maxRange*100;
maxLidarRange = 40;
mapResolution = 30;
slamAlg.LoopClosureThreshold = 210;  
slamAlg.LoopClosureSearchRadius = 8;
slamAlg = robotics.LidarSLAM(mapResolution, maxLidarRange);
%scan = lidarScan(ranges,angles);
% Create visualizer
viz = Visualizer2D;
viz.mapName = 'map';
attachLidarSensor(viz,lidar);
%% Simulation parameters
sampleTime = 0.125;              % Sample time [s]
%% k�ko
%init_x=16.00;
%init_y=16;
%% kwadrat
%init_x=8.31;
%init_y=6.5;
%init_angle=deg2rad(270);
initPose = [init_x; init_y; init_angle];        % Initial pose (x y theta)

%%
parametr = 1;
vel_error = 0.15;
K_error = 0.08;
% Initialize time, input, and pose arrays
tVec = 0:sampleTime:22;         % Time array
tVec = 0:sampleTime:0.5; 
vxRef = 1.0*ones(size(tVec))*10;   % Reference x speed
vyRef = 0.0*ones(size(tVec))*10;  % Reference y speed
wRef = zeros(size(tVec));       % Reference angular speed
wRef(tVec < 50) = 0.0;   %%-0.5;
wRef(tVec >=6.0) = 0.45;
wRef(tVec >=9.50) = 0.0;
wRef(tVec >=18.25) = -0.45;
wRef(tVec >=21.00) = 0;

%wRef(tVec <=18.75) = 0;
ref = [vxRef;vyRef;wRef];
pose = zeros(3,numel(tVec));    % Pose matrix
pose(:,1) = initPose;
% tworze macierz na przechowywanie pomiar�w
ranges_baza=zeros(ilosc_pomiarow,numel(tVec));
angles_baza=zeros(ilosc_pomiarow,numel(tVec));
global pose_baza
pose_baza =zeros(3,numel(tVec));

%% Simulation loop
i=1;
r = robotics.Rate(1/sampleTime);
for idx = 2:numel(tVec)   
    % Convert the reference speeds to world coordinates
    vel = bodyToWorld(ref(:,idx-1),pose(:,idx-1));
    %% Perform forward discrete integration step
    pose(:,idx) = pose(:,idx-1) + vel*sampleTime;
    pose_baza(idx,1)=pose(1,idx);
    pose_baza(idx,2)=pose(2,idx);
    
    % Update lidar and visualization
    ranges = lidar(pose(:,idx));
    ranges_baza(:,i)=ranges;
    %ranges_baza(1,i)=pose_baza(idx,1);
    %ranges_baza(2,i)=pose_baza(idx,2);
    
   for kat = 1 : ilosc_pomiarow
     angles_baza(kat,i)=deg2rad(kat/(ilosc_pomiarow/360))+normrnd(0,sigma_angle);
     if(ranges_baza(kat,i)>0)
     ranges_baza(kat,i) = ranges_baza(kat,i)+ normrnd(0,sigma_range); 
     end
   end
    i=i+1;
  viz(pose(:,idx),ranges)  %%%%%%%
    waitfor(r);  
end

skan= zeros(ilosc_pomiarow,2*numel(tVec)+2);
for y=1:numel(tVec)
for z=1:ilosc_pomiarow  
 skan(z,(y-1)*2+1)=cos(angles_baza(z,y))*ranges_baza(z,y);   
 skan(z,(y-1)*2+2)=sin(angles_baza(z,y))*ranges_baza(z,y);   
 
end
end
cart_ref=zeros(ilosc_pomiarow,2);
cart_next=zeros(ilosc_pomiarow,2);
cart_next_x=zeros(ilosc_pomiarow,numel(tVec)+2);
cart_next_y=zeros(ilosc_pomiarow,numel(tVec)+2);
transition_pixels=zeros(3,numel(tVec)+2);
pose_match=zeros(numel(tVec),3);
pose_grid_baza=zeros(numel(tVec),3);
for i=1:numel(tVec)
    cart_ref_x=skan(:,i*2-1);
    cart_ref_y=skan(:,i*2);
    cart_next_x=skan(:,i*2+1);
    cart_next_y=skan(:,i*2+2);
    cart_ref=cat(2,cart_ref_x,cart_ref_y);
    cart_next=cat(2,cart_next_x,cart_next_y);

    scan1=lidarScan(cart_ref);  
    scan2=lidarScan(cart_next);
    
 %pose_match(i,:)=matchScans(scan1,scan2,'MaxIterations', 1000,'CellSize',10);
 %pose_grid = matchScansGrid(scan2,scan1);
% pose_grid_baza(i,:)=pose_grid;
 %[pose,stats]=matchScans(scan1,scan2,'MaxIterations', 1000,'CellSize',10);
end
delta_pose= zeros(numel(tVec),3);
slam_pose= zeros(numel(tVec),3);
for i=1:numel(tVec)

end
slam_x=slam_pose(:,1);
slam_y=slam_pose(:,2);
for k=1:(numel(tVec)-1)
%%figure
%%plot(skan(:,2*k-1),skan(:,2*k),"k.");
skan_2x=skan(:,2*k-1+2)-pose_match(k,1);
skan_2y=skan(:,2*k+2)-pose_match(k,2);

end
pose_t=pose';

wys= 500;
szer= wys;
%global cov;
%% mapa
%map=struct;
%map.wys_mapy=6*wys;
%map.szer_mapy=6 *szer;
%map.M = zeros(map.wys_mapy,map.szer_mapy);
%map.M2=map.M;
%map.kumulacja_kata=0;
%%wspolrzedne mapy
%map.x_m=0;
%map.y_m=0;
%map.lastangm=0; %wspolrzedne mapy ostatni k�t
%% inne zmienne
TimeToStop=-1;
%background = zeros(wys);
%liczba_skanow=4;
liczba_skanow=3;
matrix1 = ones(wys,szer,liczba_skanow);
corr_max(liczba_skanow,1) = 0;
corr_max2(liczba_skanow,1) = 0;
corr_statistica=zeros(1000);
%icp
RotTransMat=zeros(liczba_skanow,4);
RotTransMat_all=zeros(liczba_skanow,4);

%%
for i=1:liczba_skanow
matrix1(:,:,i)= zeros(szer);
corr_max(i,1)=0;
corr_max2(i,1)=0;
end
hold on;
skala = 0.5*wys/maxRange;
for k=1:(liczba_skanow-liczba_skanow+1)
figure = 255*ones(wys,szer);
%imshow(figure);
hold on;

for i=1:ilosc_pomiarow
if isnan(skan(i,k*2))==0 
if isnan(skan(i,k*2+1))==0 
X=round(skala*skan(i,k*2+1)*100+szer/2,0);
Y=round(skala*skan(i,k*2)*100+wys/2,0);
if(X==0)
    X=1;
end
if(Y==0)
    Y=1;
end
matrix1(X,Y,k) = 255;

end
end
end
matrix1(:,:,k) = imgaussfilt(matrix1(:,:,k), 1.0);
fig= matrix1(:,:,k);
close;
end
%Filtr cz�steczkowy
ns=liczba_skanow;
pose=pose_baza(2:liczba_skanow+2,1:3);
pose(1,1)=155;
pose(1,2)=107.5;
poczatkowy_kurs=270;
%Inicjalizacja czasteczek
pn=1;
sigma_V=0.0;
sigma_K=deg2rad(2);
particles =struct;
best = struct;

for i=1:pn
    particles(i).pose=zeros(3,1);
    particles(i).pose(1,1)=pose(1,1);
    particles(i).pose(1,2)=pose(1,2);
    particles(i).pose(1,3)=(poczatkowy_kurs);
    particles(i).pose(1,4)=particles(i).pose(1,3);
    particles(i).pose(1,5)=-1;%predkosc wyznaczona
    particles(i).pose(1,6)=-1;%predkosc wspolczynnik
    particles(i).weight=1/pn;
    particles(i).history(3,100)=0;
    particles(i).history(1,1)=pose(1,1);
    particles(i).history(2,1)=pose(1,2);
    particles(i).history(3,1)=deg2rad(pose(1,3));
    particles(i).history(4,1)=0;
end
for i=1:liczba_skanow-1 
    KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
    %KR=atan2((pose(i-1,2)-pose(i,2)),(pose(i-1,1)-pose(i,1)))+pi;
    pose_baza(i,3)=(KR);
    pose_baza(i+2,4)= rad2deg(pose_baza(i+2,3)-pose_baza(i+1,3));
    best(i+1).REAL_COG_DIFF=pose_baza(i+2,4);
end
    for i=1:liczba_skanow-1 
%for i=1:39 
disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
    % A=matrix1(:,:,i); % zmienna do funkcji z map�
    % B=matrix1(:,:,i); % zmienna do funkcji z map� 
     best(i).x=pose(1,1);
     best(i).y=pose(1,2);
     best(i).ang=deg2rad(poczatkowy_kurs);
    
    end
    
    if i>=2
   % A=matrix1(:,:,i-1);
   % B=matrix1(:,:,i);
    KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
    %KR=atan2((pose(i-1,2)-pose(i,2)),(pose(i-1,1)-pose(i,1)))+pi;
    pose_baza(i,3)=(KR);
    %icp%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sigmaD=sigma_range;
    sigmaKK=sigma_angle;
    %% ICP KLASIK
    rodzaj=0;
    [RotTransMat,data,model,Cov,iteracja]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    data=data;
    model=model;
    RotTransMat_all(i-1,1)=RotTransMat(i-1,1);
    RotTransMat_all(i-1,2)=RotTransMat(i-1,2);
    RotTransMat_all(i-1,3)=RotTransMat(i-1,3);
    RotTransMat_all(i-1,4)=RotTransMat(i-1,4);
    best = znajdzbest(particles,best,i);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=acos(RotTransMat_all(i-1,1));
    best(i).waga=-1;
    best(i).V=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    best(i).V_WSP=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    if RotTransMat_all(i-1,1) >=0 && RotTransMat_all(i-1,2) >=0
    best(i).COG=rad2deg(acos(RotTransMat_all(i-1,1)));
    else
    best(i).COG=-1*rad2deg(acos(RotTransMat_all(i-1,1)));
    end
    end
    end     
    ICP0(j,1)=RotTransMat(1,3);
    ICP0(j,2)=RotTransMat(1,4);
    ICP0(j,3)=  best(i).COG;
    ICP0(j,4)=iteracja;
    
    %% ICP Huber
    for i=1:liczba_skanow-1 
%for i=1:39 
disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
    % A=matrix1(:,:,i); % zmienna do funkcji z map�
    % B=matrix1(:,:,i); % zmienna do funkcji z map� 
     best(i).x=pose(1,1);
     best(i).y=pose(1,2);
     best(i).ang=deg2rad(poczatkowy_kurs);
    end
  
    if i>=2
  %  A=matrix1(:,:,i-1);
  %  B=matrix1(:,:,i);
    KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
    %KR=atan2((pose(i-1,2)-pose(i,2)),(pose(i-1,1)-pose(i,1)))+pi;
    pose_baza(i,3)=(KR);
    %icp%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sigmaD=sigma_range;
    sigmaKK=sigma_angle;
    rodzaj=1;
    [RotTransMat,data,model,Cov,iteracja]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    data=data;
    model=model;
    RotTransMat_all(i-1,1)=RotTransMat(i-1,1);
    RotTransMat_all(i-1,2)=RotTransMat(i-1,2);
    RotTransMat_all(i-1,3)=RotTransMat(i-1,3);
    RotTransMat_all(i-1,4)=RotTransMat(i-1,4);
    best = znajdzbest(particles,best,i);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=acos(RotTransMat_all(i-1,1));
    best(i).waga=-1;
    best(i).V=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    best(i).V_WSP=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    if RotTransMat_all(i-1,1) >=0 && RotTransMat_all(i-1,2) >=0
    best(i).COG=rad2deg(acos(RotTransMat_all(i-1,1)));
    else
    best(i).COG=-1*rad2deg(acos(RotTransMat_all(i-1,1)));
    end
    end
    end     
    ICP1(j,1)=RotTransMat(1,3);
    ICP1(j,2)=RotTransMat(1,4);
    ICP1(j,3)=  best(i).COG;
    ICP1(j,4)=iteracja;
    
    
    %% ICP KIER
    for i=1:liczba_skanow-1 
%for i=1:39 
disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
 %A=matrix1(:,:,i); % zmienna do funkcji z map�
 %B=matrix1(:,:,i); % zmienna do funkcji z map� 
     best(i).x=pose(1,1);
     best(i).y=pose(1,2);
     best(i).ang=deg2rad(poczatkowy_kurs);
    
    end
    
    if i>=2
   % A=matrix1(:,:,i-1);
   % B=matrix1(:,:,i);
    KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
    %KR=atan2((pose(i-1,2)-pose(i,2)),(pose(i-1,1)-pose(i,1)))+pi;
    pose_baza(i,3)=(KR);
    %icp%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sigmaD=sigma_range;
    sigmaKK=sigma_angle;
    rodzaj=2;
    [RotTransMat,data,model,Cov,iteracja]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    data=data;
    model=model;
    RotTransMat_all(i-1,1)=RotTransMat(i-1,1);
    RotTransMat_all(i-1,2)=RotTransMat(i-1,2);
    RotTransMat_all(i-1,3)=RotTransMat(i-1,3);
    RotTransMat_all(i-1,4)=RotTransMat(i-1,4);
    best = znajdzbest(particles,best,i);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=acos(RotTransMat_all(i-1,1));
    best(i).waga=-1;
    best(i).V=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    best(i).V_WSP=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    if RotTransMat_all(i-1,1) >=0 && RotTransMat_all(i-1,2) >=0
    best(i).COG=rad2deg(acos(RotTransMat_all(i-1,1)));
    else
    best(i).COG=-1*rad2deg(acos(RotTransMat_all(i-1,1)));
    end
    end
    end     
    ICP2(j,1)=RotTransMat(1,3);
    ICP2(j,2)=RotTransMat(1,4);
    ICP2(j,3)=best(i).COG;
    ICP2(j,4)=iteracja;
     
        %% ICP �redni
        for i=1:liczba_skanow-1 
%for i=1:39 
disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
 %    A=matrix1(:,:,i); % zmienna do funkcji z map�
   %  B=matrix1(:,:,i); % zmienna do funkcji z map� 
     best(i).x=pose(1,1);
     best(i).y=pose(1,2);
     best(i).ang=deg2rad(poczatkowy_kurs);
    
    end
    
    if i>=2
   % A=matrix1(:,:,i-1);
   % B=matrix1(:,:,i);
    KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
    %KR=atan2((pose(i-1,2)-pose(i,2)),(pose(i-1,1)-pose(i,1)))+pi;
    pose_baza(i,3)=(KR);
    %icp%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sigmaD=sigma_range;
    sigmaKK=sigma_angle;
    rodzaj=3;
    [RotTransMat,data,model,Cov,iteracja]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    data=data;
    model=model;
    RotTransMat_all(i-1,1)=RotTransMat(i-1,1);
    RotTransMat_all(i-1,2)=RotTransMat(i-1,2);
    RotTransMat_all(i-1,3)=RotTransMat(i-1,3);
    RotTransMat_all(i-1,4)=RotTransMat(i-1,4);
    best = znajdzbest(particles,best,i);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=acos(RotTransMat_all(i-1,1));
    best(i).waga=-1;
    best(i).V=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    best(i).V_WSP=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    if RotTransMat_all(i-1,1) >=0 && RotTransMat_all(i-1,2) >=0
    best(i).COG=rad2deg(acos(RotTransMat_all(i-1,1)));
    else
    best(i).COG=-1*rad2deg(acos(RotTransMat_all(i-1,1)));
    end
    end
    end     
    ICP3(j,1)=RotTransMat(1,3);
    ICP3(j,2)=RotTransMat(1,4);
    ICP3(j,3)=  best(i).COG;
    ICP3(j,4)=iteracja;
       
        %% ICP Wektor
        for i=1:liczba_skanow-1 
%for i=1:39 
disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
     best(i).x=pose(1,1);
     best(i).y=pose(1,2);
     best(i).ang=deg2rad(poczatkowy_kurs);
    end
    
    if i>=2
    KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
    %KR=atan2((pose(i-1,2)-pose(i,2)),(pose(i-1,1)-pose(i,1)))+pi;
    pose_baza(i,3)=(KR);
    %icp%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sigmaD=sigma_range;
    sigmaKK=sigma_angle;
    rodzaj=4;
    [RotTransMat,data,model,Cov,iteracja]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    data=data;
    model=model;
    RotTransMat_all(i-1,1)=RotTransMat(i-1,1);
    RotTransMat_all(i-1,2)=RotTransMat(i-1,2);
    RotTransMat_all(i-1,3)=RotTransMat(i-1,3);
    RotTransMat_all(i-1,4)=RotTransMat(i-1,4);
    best = znajdzbest(particles,best,i);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=acos(RotTransMat_all(i-1,1));
    best(i).waga=-1;
    best(i).V=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    best(i).V_WSP=(RotTransMat(i-1,2)^2+RotTransMat(i-1,3)^2)^0.5;
    if RotTransMat_all(i-1,1) >=0 && RotTransMat_all(i-1,2) >=0
    best(i).COG=rad2deg(acos(RotTransMat_all(i-1,1)));
    else
    best(i).COG=-1*rad2deg(acos(RotTransMat_all(i-1,1)));
    end
    end
    end     
    ICP4(j,1)=RotTransMat(1,3);
    ICP4(j,2)=RotTransMat(1,4);
    ICP4(j,3)=  best(i).COG;
    ICP4(j,4)=iteracja;
    j
    toc
    time=toc;
    jj=(liczba_pentli-j)*time/60
    clear map;
end
for z= 1: liczba_pentli
    icp0(z,1)=0;
    icp0(z,2)=0;
    icp1(z,1)=0;
    icp1(z,2)=0;
    icp2(z,1)=0;
    icp2(z,2)=0;
    icp3(z,1)=0;
    icp3(z,2)=0;
    icp4(z,1)=0;
    icp4(z,2)=0;
    
end

icp0o(:,1)=ICP0(:,1);
icp0o(:,2)=ICP0(:,2); % zwyk�e icp
cov_zwy_o=cov(icp0o)
 
icp1o(:,1)=ICP1(:,1);
icp1o(:,2)=ICP1(:,2); % huber icp
cov_hub_o=cov(icp1o)
 
icp2o(:,1)=ICP2(:,1);
icp2o(:,2)=ICP2(:,2); % kierunkowe icp
cov_kier_o=cov(icp2o)

icp3o(:,1)=ICP3(:,1);
icp3o(:,2)=ICP3(:,2); %�rednie icp
cov_sre_o=cov(icp3o)

icp4o(:,1)=ICP4(:,1);
icp4o(:,2)=ICP4(:,2); %wektorowe icp
cov_wek_o =cov(icp4o)


