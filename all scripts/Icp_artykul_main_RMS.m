clear all
ilosc_pomiarow_max=500;
poczatek=500;
c=1;
spacing=1;
liczba_pentli=2;
prev=rng;  
rng('default');

for ilosc_pomiarow=poczatek:spacing:ilosc_pomiarow_max
tic;    
%% Lidar Sensor Example
% Copyright 2018 The MathWorks, Inc.
%close all
%Komp praca
%image2=imread('C:\Users\user\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\Mobile Robotics Simulation Toolbox\code\examples\matlab\kwadrat2.pgm');
%Komp ma³y
image2=imread('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\Mobile Robotics Simulation Toolbox\code\examples\matlab\okr¹g2.pgm');
image2=image2<10;
init_y=15.43333333;
init_x=15.93333333;

%init_y=5;
%init_x=5;
init_angle=deg2rad(90);
sampleTime = 0.1;
tVec = 0:sampleTime:22;         % Time array
tVec = 0:sampleTime:0.5; 
wRef = zeros(size(tVec));       % Reference angular speed
wRef(tVec < 50) = 0;%1.396263401595461*0%%0.25;   % 1*1.39626340159546 jest równe 8 stopni
wRef(tVec >=6.0) = 0.45;
wRef(tVec >=9.50) = 0.0;
wRef(tVec >=18.25) = -0.45;
wRef(tVec >=21.00) = 0;



for j=1:liczba_pentli
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
%slamAlg.LoopClosureThreshold = 210;  
%slamAlg.LoopClosureSearchRadius = 8;
%slamAlg = robotics.LidarSLAM(mapResolution, maxLidarRange);
%scan = lidarScan(ranges,angles);
% Create visualizer
viz = Visualizer2D;
viz.mapName = 'map';
attachLidarSensor(viz,lidar);
%% Simulation parameters
initPose = [init_x; init_y; init_angle];        % Initial pose (x y theta)
%% B³êdy zosta³y standardowe !!!!!
sigma_range=0.03;
sigma_angle=deg2rad(0.5);
%%
parametr = 1;
vel_error = 0.15;
K_error = 0.08;
lidar.angle_error=sigma_angle;
% Initialize time, input, and pose arrays

vxRef = 1.0*ones(size(tVec))*10;   % Reference x speed
vyRef = 0.0*ones(size(tVec))*10;  % Reference y speed

vxRef = 1.0*ones(size(tVec))*10;   % Reference x speed
vyRef = 0.0*ones(size(tVec))*10;  % Reference y speed

%wRef(tVec <=18.75) = 0;
ref = [vxRef;vyRef;wRef];
pose = zeros(3,numel(tVec));    % Pose matrix
pose(:,1) = initPose;
% tworze macierz na przechowywanie pomiarów
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
    
   for kat = 1 : ilosc_pomiarow

    % angles_baza(kat,i)=deg2rad(kat/(ilosc_pomiarow/360.0));%+normrnd(0,sigma_angle);
    angles_baza(kat,i)=(lidar.scanAngles(kat)+normrnd(0,sigma_angle));
     if(ranges_baza(kat,i)>0)
     ranges_baza(kat,i) = ranges_baza(kat,i)+ normrnd(0,sigma_range); 
     end
   end
    i=i+1;
  %viz(pose(:,idx),ranges)  
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
global RES;


for ii=1:100
    for kk=1:5
        for jj=1:2
              RES1(ii,kk,jj)=0;
         end
    end
end

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
%Filtr cz¹steczkowy
ns=liczba_skanow;
pose=pose_baza(2:liczba_skanow+2,1:3);
pose(1,1)=16;
pose(1,2)=16;
poczatkowy_kurs=90;
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
%disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
%     best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
    % A=matrix1(:,:,i); % zmienna do funkcji z map¹
    % B=matrix1(:,:,i); % zmienna do funkcji z map¹ 
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
    [RotTransMat,data,model,Cov,iteracja,czas,RES]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    RES1(:,rodzaj+1,1)=RES(:,rodzaj+1,1);
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
    ICP0(j,3)=best(i).COG;
    ICP0(j,4)=czas;
    
    %% ICP Huber
    for i=1:liczba_skanow-1 
%for i=1:39 
%disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
    % A=matrix1(:,:,i); % zmienna do funkcji z map¹
    % B=matrix1(:,:,i); % zmienna do funkcji z map¹ 
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
    [RotTransMat,data,model,Cov,iteracja,czas,RES]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    RES1(:,rodzaj+1,1)=RES(:,1,1);
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
    ICP1(j,3)=best(i).COG;
    ICP1(j,4)=czas;
    
    
    %% ICP KIER
        for i=1:liczba_skanow-1 
%for i=1:39 
%disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
 %A=matrix1(:,:,i); % zmienna do funkcji z map¹
 %B=matrix1(:,:,i); % zmienna do funkcji z map¹ 
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
    [RotTransMat,data,model,Cov,iteracja,czas,RES]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    RES1(:,rodzaj+1,1)=RES(:,1,1);
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
    ICP2(j,4)=czas;
     
        %% ICP œredni
        for i=1:liczba_skanow-1 
%for i=1:39 
%disp("obrabiam skan nr" + i);
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
   % A=matrix1(:,:,i-1);
   % B=matrix1(:,:,i);
    KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
    %KR=atan2((pose(i-1,2)-pose(i,2)),(pose(i-1,1)-pose(i,1)))+pi;
    pose_baza(i,3)=(KR);
    %icp%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sigmaD=sigma_range;
    sigmaKK=sigma_angle;
    rodzaj=3;
    [RotTransMat,data,model,Cov,iteracja,czas,RES]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    RES1(:,rodzaj+1,1)=RES(:,1,1);
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
    ICP3(j,3)=best(i).COG;
    ICP3(j,4)=czas;
       
        %% ICP Wektor
        for i=1:liczba_skanow-1 
%for i=1:39 
%disp("obrabiam skan nr" + i);
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
    [RotTransMat,data,model,Cov,iteracja,czas,RES]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    RES1(:,rodzaj+1,1)=RES(:,1,1);
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
    ICP4(j,3)= best(i).COG;
    ICP4(j,4)=czas;
  %  j
  %  toc
  % jj=(liczba_pentli-j)*time/60
    clear map;
end

icp0o(:,1,c)=ICP0(:,1);
icp0o(:,2,c)=ICP0(:,2); % zwyk³e icp
icp0o(:,3,c)=ICP0(:,3);
icp0o(:,4,c)=ICP0(:,4);
%cov_zwy_o=cov(icp0);
icp1o(:,1,c)=ICP1(:,1);
icp1o(:,2,c)=ICP1(:,2); % huber icp
icp1o(:,3,c)=ICP1(:,3);
icp1o(:,4,c)=ICP1(:,4);
%cov_hub_o=cov(icp1);
icp2o(:,1,c)=ICP2(:,1);
icp2o(:,2,c)=ICP2(:,2); % kierunkowe icp
icp2o(:,3,c)=ICP2(:,3);
icp2o(:,4,c)=ICP2(:,4);
%cov_kier_o=cov(icp2);
icp3o(:,1,c)=ICP3(:,1);
icp3o(:,2,c)=ICP3(:,2); %œrednie icp
icp3o(:,3,c)=ICP3(:,3);
icp3o(:,4,c)=ICP3(:,4);
%cov_sre_o=cov(icp3);
icp4o(:,1,c)=ICP4(:,1);
icp4o(:,2,c)=ICP4(:,2); %wektorowe icp
icp4o(:,3,c)=ICP4(:,3);
icp4o(:,4,c)=ICP4(:,4);
%cov_wek_o=cov(icp4);


%Komp duzy
%image2=imread('C:\Users\user\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\Mobile Robotics Simulation Toolbox\code\examples\matlab\kwadrat.pgm');
%Komp ma³y
image2=imread('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\Mobile Robotics Simulation Toolbox\code\examples\matlab\kwadrat2.pgm');
image2=image2<100;
for j=1:liczba_pentli
%% Create environment
%load exampleMap
%load grid
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
              % Sample time [s]
initPose = [init_x; init_y; init_angle];        % Initial pose (x y theta)
%% B³êdy zosta³y standardowe !!!!!
sigma_range=0.03;
sigma_angle=deg2rad(0.5);
%%
parametr = 1;
vel_error = 0.15;
K_error = 0.08;
% Initialize time, input, and pose arrays

vxRef = 1.0*ones(size(tVec))*10;   % Reference x speed
vyRef = 0.0*ones(size(tVec))*10;  % Reference y speed

vxRef = 1.0*ones(size(tVec))*10;   % Reference x speed
vyRef = 0.0*ones(size(tVec))*10;  % Reference y speed




%wRef(tVec <=18.75) = 0;
ref = [vxRef;vyRef;wRef];
pose = zeros(3,numel(tVec));    % Pose matrix
pose(:,1) = initPose;
% tworze macierz na przechowywanie pomiarów
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
    
   for kat = 1 : ilosc_pomiarow
    % angles_baza(kat,i)=deg2rad(kat/(ilosc_pomiarow/360));%%+normrnd(0,sigma_angle);
    angles_baza(kat,i)=(lidar.scanAngles(kat)+normrnd(0,sigma_angle));
 
    if(ranges_baza(kat,i)>0)
     ranges_baza(kat,i) = ranges_baza(kat,i)+ normrnd(0,sigma_range); 
     end
   end
    i=i+1;
   %fviz(pose(:,idx),ranges)  
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
%% mapa

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
%Filtr cz¹steczkowy
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
%disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
    % A=matrix1(:,:,i); % zmienna do funkcji z map¹
    % B=matrix1(:,:,i); % zmienna do funkcji z map¹ 
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
    [RotTransMat,data,model,Cov,iteracja,czas,RES]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);  
    RES1(:,rodzaj+1,2)=RES(:,1,1);
    data=data;
    model=model;
    %save('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\testy próby\icp (1)\data_test.mat','data','model')
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
    ICP0(j,4)=czas;
    
    %% ICP Huber
    for i=1:liczba_skanow-1 
%for i=1:39 
%disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
    % A=matrix1(:,:,i); % zmienna do funkcji z map¹
    % B=matrix1(:,:,i); % zmienna do funkcji z map¹ 
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
    [RotTransMat,data,model,Cov,iteracja,czas,RES]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    RES1(:,rodzaj+1,2)=RES(:,1,1);
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
    ICP1(j,3)=best(i).COG;
    ICP1(j,4)=czas;
    
    
    %% ICP KIER
        for i=1:liczba_skanow-1 
%for i=1:39 
%disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
 %A=matrix1(:,:,i); % zmienna do funkcji z map¹
 %B=matrix1(:,:,i); % zmienna do funkcji z map¹ 
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
    [RotTransMat,data,model,Cov,iteracja,czas,RES]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    RES1(:,rodzaj+1,2)=RES(:,1,1);
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
    ICP2(j,4)=czas;
     
        %% ICP œredni
        for i=1:liczba_skanow-1 
%for i=1:39 
%disp("obrabiam skan nr" + i);
    best(i).number=-1;
    best(i).x=-1;
    best(i).y=-1;
    best(i).ang=-1;
    best(i).waga=-1;
    best(i).V=2.5;
    best(i).V_WSP=2.5*((wys/2)/40);
    best(i).COG=0;
    if i==1
 %    A=matrix1(:,:,i); % zmienna do funkcji z map¹
   %  B=matrix1(:,:,i); % zmienna do funkcji z map¹ 
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
    [RotTransMat,data,model,Cov,iteracja,czas,RES]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    RES1(:,rodzaj+1,2)=RES(:,1,1);
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
    ICP3(j,3)=best(i).COG;
    ICP3(j,4)=czas;
       
        %% ICP Wektor
        for i=1:liczba_skanow-1 
%for i=1:39 
%disp("obrabiam skan nr" + i);
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
    [RotTransMat,data,model,Cov,iteracja,czas,RES]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    RES1(:,rodzaj+1,2)=RES(:,1,1);
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
    ICP4(j,3)=best(i).COG;
    ICP4(j,4)=czas;
   % j
   % toc
      clear map;
  end

icp0k(:,1,c)=ICP0(:,1);
icp0k(:,2,c)=ICP0(:,2); % zwyk³e icp
icp0k(:,3,c)=ICP0(:,3); 
icp0k(:,4,c)=ICP0(:,4); 
%cov_zwy_k=cov(icp0);
icp1k(:,1,c)=ICP1(:,1);
icp1k(:,2,c)=ICP1(:,2); % huber icp
icp1k(:,3,c)=ICP1(:,3); 
icp1k(:,4,c)=ICP1(:,4); 
%cov_hub_k=cov(icp1);
icp2k(:,1,c)=ICP2(:,1);
icp2k(:,2,c)=ICP2(:,2); % kierunkowe icp
icp2k(:,3,c)=ICP2(:,3);
icp2k(:,4,c)=ICP2(:,4); 
%cov_kier_k=cov(icp2);
icp3k(:,1,c)=ICP3(:,1);
icp3k(:,2,c)=ICP3(:,2); %œrednie icp
icp3k(:,3,c)=ICP3(:,3); 
icp3k(:,4,c)=ICP3(:,4); 
%cov_sre_k=cov(icp3);
icp4k(:,1,c)=ICP4(:,1);
icp4k(:,2,c)=ICP4(:,2); %wektorowe icp
icp4k(:,3,c)=ICP4(:,3); 
icp4k(:,4,c)=ICP4(:,4); 
%cov_wek_k=cov(icp4);
c=c+1;
cykle=(ilosc_pomiarow_max/spacing-poczatek/spacing)+1;
disp(c +" na " +cykle+ " " +c/cykle*100 +"%");
disp(c/cykle*100 +"%")
time=toc;
%czas=(ilosc_pomiarow_max/10-50/10-c)*time/60

end
%Komp duzy
%save('C:\Users\user\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\dane\wiecej_iter_ok_ruch.mat','icp0o','icp1o','icp2o','icp3o','icp4o','icp0k','icp1k','icp2k','icp3k','icp4k');
%Komp ma³y
%save('C:\Users\Admin\Dysk
%Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\dane\wiecej_iter_ok_obrot.mat','icp0o','icp1o','icp2o','icp3o','icp4o','icp0k','icp1k','icp2k','icp3k','icp4k');
%Artyku³
%save('C:\Users\Admin\Dysk Google\AKADEMIA\nauka\artyku³y moje\artyku³ icp drugi\MDPI_template\MDPI_template\Definitions\wiecej_iter_ok_ruch.mat','icp0o','icp1o','icp2o','icp3o','icp4o','icp0k','icp1k','icp2k','icp3k','icp4k')



disp("wykonano");
rng(prev);



