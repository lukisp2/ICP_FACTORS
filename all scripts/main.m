%%Inicjalizacja Skanów
%Spróbuj z kalmane aby wyznaczaæ prêdkoœæ nastêpn¹, a potem wagowaæ te
%cz¹ski w zale¿onœci od odleg³oœci od cz¹stki zak³adaniej
%a mo¿e by generowac skan wedle filtra kalmana??? chyba bez sensu bo to nie
%jest pomiar np pradu
wys= 50;
szer= wys;
%% mapa
map=struct;
map.wys_mapy=6*wys;
map.szer_mapy=6 *szer;
map.M = zeros(map.wys_mapy,map.szer_mapy);
map.M2=map.M;
map.kumulacja_kata=0;
%%wspolrzedne mapy
map.x_m=0;
map.y_m=0;
map.lastangm=0; %wspolrzedne mapy ostatni k¹t
%% inne zmienne
TimeToStop=-1;
background = zeros(wys);
%liczba_skanow=4;
liczba_skanow=175;
matrix1 = ones(wys,szer,liczba_skanow);
corr_max(liczba_skanow,1) = 0;
corr_max2(liczba_skanow,1) = 0;

%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%
for i=1:liczba_skanow
matrix1(:,:,i)= zeros(szer);
corr_max(i,1)=0;
corr_max2(i,1)=0;
end
hold on;
skala = 0.5*wys/maxRange;
%{
for k=1:liczba_skanow
figure = 255*ones(wys,szer);
imshow(figure);
hold on;
for i=1:ilosc_pomiarow
if isnan(skan(i,k*2))==0 
if isnan(skan(i,k*2+1))==0 
X=round(skala*skan(i,k*2+1)*100+szer/2,0)+1;
Y=round(skala*skan(i,k*2)*100+wys/2,0);
matrix1(X,Y,k) = 255;
end
end
end
matrix1(:,:,k) = imgaussfilt(matrix1(:,:,k) , 0.6);
fig= matrix1(:,:,k);
imshow(fig);
pause(0.0005);
close;
end
%}
%Filtr cz¹steczkowy
ns=liczba_skanow;
pose=pose_baza(2:89,1:3);
pose(1,1)=155;
pose(1,2)=107.5;
%pose(1,1)=179;
%pose(1,2)=29;

poczatkowy_kurs=270;
%Inicjalizacja czasteczek
pn=10;
sigma_V=0.8;
sigma_K=deg2rad(2);
particles =struct;
best = struct;

for i=1:pn
    particles(i).pose=zeros(3,1);
    particles(i).pose(1,1)=pose(1,1);
    particles(i).pose(1,2)=pose(1,2);
    particles(i).pose(1,3)=(poczatkowy_kurs);
    particles(i).pose(1,4)=particles(i).pose(1,3);
    particles(i).pose(1,5)=2.5; %% predkosc czastki
    particles(i).weight=1/pn;
    particles(i).history(3,100)=0;
    particles(i).history(1,1)=pose(1,1);
    particles(i).history(2,1)=pose(1,2);
    particles(i).history(3,1)=deg2rad(pose(1,3));
    particles(i).history(4,1)=0;
end

%figure


%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%




%icp
RotTransMat=zeros(liczba_skanow,4);
RotTransMat_all=zeros(liczba_skanow,4);
rodzaj=2;
%%
for i=1:liczba_skanow
%matrix1(:,:,i)= zeros(szer);
corr_max(i,1)=0;
corr_max2(i,1)=0;
end
hold on;
skala = 0.5*wys/maxRange;
for k=1:(liczba_skanow-liczba_skanow+1)
figure = 255*ones(wys,szer);
imshow(figure);
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
%matrix1(X,Y,k) = 255;

end
end
end
%matrix1(:,:,k) = imgaussfilt(matrix1(:,:,k), 1.0);
%fig= matrix1(:,:,k);
%imwrite(matrix1(:,:,3),'skan3.jpg');
%imwrite(matrix1(:,:,4),'skan4.jpg');
%imwrite(matrix1(:,:,5),'skan5.jpg');
%imwrite(matrix1(:,:,6),'skan6.jpg');
%imwrite(matrix1(:,:,7),'skan7.jpg');
%imwrite(matrix1(:,:,174),'skan174.jpg');
%imwrite(matrix1(:,:,175),'skan175.jpg');
%imshow(fig);
%pause(0.005);
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
     A=matrix1(:,:,i); % zmienna do funkcji z map¹
     B=matrix1(:,:,i); % zmienna do funkcji z map¹ 

     
     best(i).x=pose(1,1);
     best(i).y=pose(1,2);
     best(i).ang=deg2rad(poczatkowy_kurs);
     particles = prediction(particles, pose, i, sigma_V, sigma_K);
     map = mapa(A,B,best,i,wys,pose,map,liczba_skanow); % Mapa otoczenia  
    end
   
    tic;
    if i>=2
    
    A=matrix1(:,:,i-1);
    B=matrix1(:,:,i);
   
    KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
    %KR=atan2((pose(i-1,2)-pose(i,2)),(pose(i-1,1)-pose(i,1)))+pi;
    pose_baza(i,3)=(KR);
    %icp%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sigmaD=sigma_range;
    sigmaKK=sigma_angle;
    [RotTransMat,data,model]=icpfunction(i,sigmaD,sigmaKK,skan,rodzaj);
    data=data;
    model=model;
    RotTransMat_all(i-1,1)=RotTransMat(i-1,1);
    RotTransMat_all(i-1,2)=RotTransMat(i-1,2);
    RotTransMat_all(i-1,3)=RotTransMat(i-1,3);
    RotTransMat_all(i-1,4)=RotTransMat(i-1,4);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %particles = prediction(particles, pose, i, sigma_V, sigma_K);
    %particles = correction2cpu(particles, pose,A,B,i,wys); % bez g³êbokiego szukania
    %particles = correction2sr(particles, pose,A,B,i,wys); % z g³êbokim szukaniem
    %%% to jest ostatni%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %particles = correction2srgpu(particles,pose,A,B,i,wys,corr_statistica, TimeToStop,best); % z g³êbokim szukaniem
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    %particles = correction2srgpu_NOWYALGORYTM(particles,pose,A,B,i,wys,corr_statistica, TimeToStop,best); % z g³êbokim szukaniem
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %wyswietl(A,B,best,i,wys); 
%%   map =  mapa(A,B,best,i,wys,pose,map,liczba_skanow); % Mapa otoczenia
%%   map = mapa_waga(map);
    if i == (liczba_skanow-1)
    beep;
    pause(1);
    beep;
    pause(1);
    beep;
    end
    %particles= resample(particles);
    figure(1)
    for z=1:pn
    % plot(particles(z).pose(1,1),particles(z).pose(1,2), 'm*', 'markersize', 0.7);
    % label = num2str(z);
    % text(particles(z).pose(1,1), particles(z).pose(1,2), label, 'VerticalAlignment','bottom', ...
    % 'HorizontalAlignment','right')
  hold on
    end
    end
    timeElapsed=toc;
    TimeToStop=liczba_skanow*timeElapsed-timeElapsed*i;
    disp(round(TimeToStop,0)/60);
    end

    figure(2);
    plot(vertcat(best.x), vertcat(best.y), 'g', 'markersize' , 2.5); hold on
    plot(pose_baza(:,1),pose_baza(:,2),'b', 'markersize' , 1.5);
    hold on
   
    lastx=155;
    lasty=107.5;
    best(1).V=1.25;
    lastang=270;
    for z=1:1:liczba_skanow-1
      % lastx=lastx+(best(z).V_WSP/((wys/2)/40))*cos(deg2rad(lastang+best(z).COG));
      % lasty=lasty+(best(z).V_WSP/((wys/2)/40))*sin(deg2rad(lastang+best(z).COG));
       lastx=lastx+(best(z).V)*cos(deg2rad(lastang+best(z).COG));
       lasty=lasty+(best(z).V)*sin(deg2rad(lastang+best(z).COG));
       lastang=lastang+best(z).COG;
       scatter(lastx,lasty,'+','black');
       label = num2str(z);
       text(lastx, lasty, label, 'VerticalAlignment','bottom', ...
      'HorizontalAlignment','right')
       hold on;
    end
    beep;
    pause(1);
    beep;
    pause(1);
    beep;
