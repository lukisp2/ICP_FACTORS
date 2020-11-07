%% KWADRAT 
zakres_min=26;
zakres_max=476;
%zakres_min=1;
%zakres_max=451;
przemieszczenie_X=1;
przemieszczenie_Y=0;
predkosc=1;
%% X uporz?dkowane
X0K(:,:)=(icp1k(:,1,zakres_min:zakres_max));
XX0K(:)=X0K(:);

X1K(:,:)=(icp1k(:,1,zakres_min:zakres_max));
XX1K(:)=X1K(:);

X2K(:,:)=(icp2k(:,1,zakres_min:zakres_max));
XX2K(:)=X2K(:);

X3K(:,:)=(icp3k(:,1,zakres_min:zakres_max));
XX3K(:)=X3K(:);

X4K(:,:)=(icp4k(:,1,zakres_min:zakres_max));
XX4K(:)=X4K(:);
%% Y uporz¹dkowane
Y0K(:,:)=(icp0k(:,2,zakres_min:zakres_max));
YY0K(:)=Y0K(:);

Y1K(:,:)=(icp1k(:,2,zakres_min:zakres_max));
YY1K(:)=Y1K(:);

Y2K(:,:)=(icp2k(:,2,zakres_min:zakres_max));
YY2K(:)=Y2K(:);

Y3K(:,:)=(icp3k(:,2,zakres_min:zakres_max));
YY3K(:)=Y3K(:);

Y4K(:,:)=(icp4k(:,2,zakres_min:zakres_max));
YY4K(:)=Y4K(:);
%% K?T uporz¹dkowany
K0K(:,:)=(icp0k(:,3,zakres_min:zakres_max));
KK0K(:)=K0K(:);

K1K(:,:)=(icp1k(:,3,zakres_min:zakres_max));
KK1K(:)=K1K(:);

K2K(:,:)=(icp2k(:,3,zakres_min:zakres_max));
KK2K(:)=K2K(:);

K3K(:,:)=(icp3k(:,3,zakres_min:zakres_max));
KK3K(:)=K3K(:);

K4K(:,:)=(icp4k(:,3,zakres_min:zakres_max));
KK4K(:)=K4K(:);
%% odchylenie standardowe z elips

std_x_k_1=mean(KOWk1x(zakres_min:zakres_max));
std_x_k_2=mean(KOWk2x(zakres_min:zakres_max));
std_x_k_3=mean(KOWk3x(zakres_min:zakres_max));
std_x_k_4=mean(KOWk4x(zakres_min:zakres_max));

std_y_k_1=mean(KOWk1y(zakres_min:zakres_max));
std_y_k_2=mean(KOWk2y(zakres_min:zakres_max));
std_y_k_3=mean(KOWk3y(zakres_min:zakres_max));
std_y_k_4=mean(KOWk4y(zakres_min:zakres_max));

%% medniana x
med_x0k=median(XX0K);
med_x1k=median(XX1K);
med_x2k=median(XX2K);
med_x3k=median(XX3K);
med_x4k=median(XX4K);
%% mediana y
med_y0k=median(YY0K);
med_y1k=median(YY1K);
med_y2k=median(YY2K);
med_y3k=median(YY3K);
med_y4k=median(YY4K);
%% srednie odchylenie x
odch_x0k=std((XX0K-1));
odch_x1k=std(XX1K-1);
odch_x2k=std(XX2K-1);
odch_x3k=std(XX3K-1);
odch_x4k=std(XX4K-1);
%% srednie odchylenie y
odch_y0k=std(YY0K-0);
odch_y1k=std(YY1K-0);
odch_y2k=std(YY2K-0);
odch_y3k=std(YY3K-0);
odch_y4k=std(YY4K-0);
%% srednie odchylenie xy
odcy_xy1k=sqrt(odch_x1k^2+odch_y1k^2);
odcy_xy2k=sqrt(odch_x2k^2+odch_y2k^2);
odcy_xy3k=sqrt(odch_x3k^2+odch_y3k^2);
odcy_xy4k=sqrt(odch_x4k^2+odch_y4k^2);

%% srednia x
sred_x0k=mean(XX0K);
sred_x1k=mean(XX1K);
sred_x2k=mean(XX2K);
sred_x3k=mean(XX3K);
sred_x4k=mean(XX4K);
%% srednia y
sred_y0k=mean(YY0K);
sred_y1k=mean(YY1K);
sred_y2k=mean(YY2K);
sred_y3k=mean(YY3K);
sred_y4k=mean(YY4K);
%% b??d pozycji
M0k=sqrt(odch_x0k^2+odch_y0k^2);
M1k=sqrt(odch_x1k^2+odch_y1k^2);
M2k=sqrt(odch_x2k^2+odch_y2k^2);
M3k=sqrt(odch_x3k^2+odch_y3k^2);
M4k=sqrt(odch_x4k^2+odch_y4k^2);

%% odchy?ki 
%% mean |x1-xhat1|
odchylka_x1k=mean(XX1K-0)
odchylka_x2k=mean(XX2K-0)
odchylka_x3k=mean(XX3K-0)
odchylka_x4k=mean(XX4K-0)

%% mean |y1-yhat1|
odchylka_y1k=mean(YY1K-1)
odchylka_y2k=mean(YY2K-1)
odchylka_y3k=mean(YY3K-1)
odchylka_y4k=mean(YY4K-1)

%%  mean X1-Xhat1
odchylka_X1k=sqrt(odchylka_x1k^2+odchylka_y1k^2)
odchylka_X2k=sqrt(odchylka_x2k^2+odchylka_y2k^2)
odchylka_X3k=sqrt(odchylka_x3k^2+odchylka_y3k^2)
odchylka_X4k=sqrt(odchylka_x4k^2+odchylka_y4k^2)

%% max _x
max_x0k=max(XX0K);
max_x1k=max(XX1K);
max_x2k=max(XX2K);
max_x3k=max(XX3K);
max_x4k=max(XX4K);
%% max_y
max_y0k=max(YY0K);
max_y1k=max(YY1K);
max_y2k=max(YY2K);
max_y3k=max(YY3K);
max_y4k=max(YY4K);
%% min _x
min_x0k=min(XX0K);
min_x1k=min(XX1K);
min_x2k=min(XX2K);
min_x3k=min(XX3K);
min_x4k=min(XX4K);
%% min_y
min_y0k=min(abs(YY0K));
min_y1k=min(abs(YY1K));
min_y2k=min(abs(YY2K));
min_y3k=min(abs(YY3K));
min_y4k=min(abs(YY4K));
%% mediana k?t
med_k0k=median(KK0K);
med_k1k=median(KK1K);
med_k2k=median(KK2K);
med_k3k=median(KK3K);
med_k4k=median(KK4K);
%% srednie odchylenie k?t
odch_k0k=std(KK0K);
odch_k1k=std(KK1K);
odch_k2k=std(KK2K);
odch_k3k=std(KK3K);
odch_k4k=std(KK4K);
%% sredni k?t
sre_k0k=mean(KK0K);
sre_k1k=mean(KK1K);
sre_k2k=mean(KK2K);
sre_k3k=mean(KK3K);
sre_k4k=mean(KK4K);
%% max kat
max_k0k=max(abs(KK0K));
max_k1k=max(abs(KK1K));
max_k2k=max(abs(KK2K));
max_k3k=max(abs(KK3K));
max_k4k=max(abs(KK4K));
%% min kat
min_k0k=min((KK0K));
min_k1k=min(KK1K);
min_k2k=min((KK2K));
min_k3k=min((KK3K));
min_k4k=min((KK4K));
%% B??d wzgl?dem pozycji referencyjnej
%% B??d x
B_1_x=mean(sqrt((XX1K(:)-1).^2));
B_2_x=mean(sqrt((XX2K(:)-1).^2));
B_3_x=mean(sqrt((XX3K(:)-1).^2));
B_4_x=mean(sqrt((XX4K(:)-1).^2));
%% B??d y
B_1_y=mean(sqrt((YY1K(:)-0).^2));
B_2_y=mean(sqrt((YY2K(:)-0).^2));
B_3_y=mean(sqrt((YY3K(:)-0).^2));
B_4_y=mean(sqrt((YY4K(:)-0).^2));
%% B??d pozycji
M1=sqrt(B_1_x.^2+B_1_y.^2);
M2=sqrt(B_2_x.^2+B_2_y.^2);
M3=sqrt(B_3_x.^2+B_3_y.^2);
M4=sqrt(B_4_x.^2+B_4_y.^2);
%% czas 

czas1K(:,:)=(icp1k(:,4,zakres_min:zakres_max));
czasczas1K(:)=czas1K(:);

czas2K(:,:)=(icp2k(:,4,zakres_min:zakres_max));
czasczas2K(:)=czas2K(:);

czas3K(:,:)=(icp3k(:,4,zakres_min:zakres_max));
czasczas3K(:)=czas3K(:);

czas4K(:,:)=(icp4k(:,4,zakres_min:zakres_max));
czasczas4K(:)=czas4K(:);

sr_czas1k=mean(czasczas1K);
sr_czas2k=mean(czasczas2K);
sr_czas3k=mean(czasczas3K);
sr_czas4k=mean(czasczas4K);


%% odchy³ka od k¹ta prawdziwego œrednia

od_pr_kat_1k=mean(abs(KK1K-2));
od_pr_kat_2k=mean(abs(KK2K-2));
od_pr_kat_3k=mean(abs(KK3K-2));
od_pr_kat_4k=mean(abs(KK4K-2));




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% okr?g
zakres_min=26;
zakres_max=476;
%zakres_min=1;
%zakres_max=451;
przemieszczenie_X=1;
przemieszczenie_Y=0;
predkosc=1;
%% X uporz?dkowane
X0O(:,:)=(icp1o(:,1,zakres_min:zakres_max));
XX0O(:)=X0O(:);

X1O(:,:)=(icp1o(:,1,zakres_min:zakres_max));
XX1O(:)=X1O(:);

X2O(:,:)=(icp2o(:,1,zakres_min:zakres_max));
XX2O(:)=X2O(:);

X3O(:,:)=(icp3o(:,1,zakres_min:zakres_max));
XX3O(:)=X3O(:);

X4O(:,:)=(icp4o(:,1,zakres_min:zakres_max));
XX4O(:)=X4O(:);
%% Y uporz?doowane
Y0O(:,:)=(icp0o(:,2,zakres_min:zakres_max));
YY0O(:)=Y0O(:);

Y1O(:,:)=(icp1o(:,2,zakres_min:zakres_max));
YY1O(:)=Y1O(:);

Y2O(:,:)=(icp2o(:,2,zakres_min:zakres_max));
YY2O(:)=Y2O(:);

Y3O(:,:)=(icp3o(:,2,zakres_min:zakres_max));
YY3O(:)=Y3O(:);

Y4O(:,:)=(icp4o(:,2,zakres_min:zakres_max));
YY4O(:)=Y4O(:);
%% K?T uporz?doowany
O0O(:,:)=(icp0o(:,3,zakres_min:zakres_max));
OO0O(:)=O0O(:);

O1O(:,:)=(icp1o(:,3,zakres_min:zakres_max));
OO1O(:)=O1O(:);

O2O(:,:)=(icp2o(:,3,zakres_min:zakres_max));
OO2O(:)=O2O(:);

O3O(:,:)=(icp3o(:,3,zakres_min:zakres_max));
OO3O(:)=O3O(:);

O4O(:,:)=(icp4o(:,3,zakres_min:zakres_max));
OO4O(:)=O4O(:);
%% odchylenie standardowe z elips
%{
std_x_o_1=KOWo1x(zakres_min:zakres_max);
std_x_o_2=KOWo2x(zakres_min:zakres_max);
std_x_o_3=KOWo3x(zakres_min:zakres_max);
std_x_o_4=KOWo4x(zakres_min:zakres_max);

std_y_o_1=KOWo1y(zakres_min:zakres_max);
std_y_o_2=KOWo2y(zakres_min:zakres_max);
std_y_o_3=KOWo3y(zakres_min:zakres_max);
std_y_o_4=KOWo4y(zakres_min:zakres_max);
%}
%% medniana x
med_x0o=median(XX0O);
med_x1o=median(XX1O);
med_x2o=median(XX2O);
med_x3o=median(XX3O);
med_x4o=median(XX4O);
%% mediana y
med_y0o=median(YY0O);
med_y1o=median(YY1O);
med_y2o=median(YY2O);
med_y3o=median(YY3O);
med_y4o=median(YY4O);
%% srednie odchylenie x
odch_x0o=std((XX0O-1));
odch_x1o=std(XX1O-1);
odch_x2o=std(XX2O-1);
odch_x3o=std(XX3O-1);
odch_x4o=std(XX4O-1);
%% srednie odchylenie y
odch_y0o=std(YY0O-0);
odch_y1o=std(YY1O-0);
odch_y2o=std(YY2O-0);
odch_y3o=std(YY3O-0);
odch_y4o=std(YY4O-0);
%% srednie odchylenie xy
odcy_xy1o=sqrt(odch_x1o^2+odch_y1o^2);
odcy_xy2o=sqrt(odch_x2o^2+odch_y2o^2);
odcy_xy3o=sqrt(odch_x3o^2+odch_y3o^2);
odcy_xy4o=sqrt(odch_x4o^2+odch_y4o^2);

%% srednia x
sred_x0o=mean(XX0O);
sred_x1o=mean(XX1O);
sred_x2o=mean(XX2O);
sred_x3o=mean(XX3O);
sred_x4o=mean(XX4O);
%% srednia y
sred_y0o=mean(YY0O);
sred_y1o=mean(YY1O);
sred_y2o=mean(YY2O);
sred_y3o=mean(YY3O);
sred_y4o=mean(YY4O);
%% b??d pozycji
M0o=(odch_x0o^2+odch_y0o^2);
M1o=(odch_x1o^2+odch_y1o^2);
M2o=(odch_x2o^2+odch_y2o^2);
M3o=(odch_x3o^2+odch_y3o^2);
M4o=(odch_x4o^2+odch_y4o^2);
%% max _x
max_x0o=max(XX0O);
max_x1o=max(XX1O);
max_x2o=max(XX2O);
max_x3o=max(XX3O);
max_x4o=max(XX4O);
%% max_y
max_y0o=max(YY0O);
max_y1o=max(YY1O);
max_y2o=max(YY2O);
max_y3o=max(YY3O);
max_y4o=max(YY4O);
%% min _x
min_x0o=min(XX0O);
min_x1o=min(XX1O);
min_x2o=min(XX2O);
min_x3o=min(XX3O);
min_x4o=min(XX4O);
%% min_y
min_y0o=min((YY0O));
min_y1o=min((YY1O));
min_y2o=min((YY2O));
min_y3o=min((YY3O));
min_y4o=min((YY4O));

%% odchy?ki 
%% mean |x1-xhat1|
odchylka_x1o=mean(XX1O-0)
odchylka_x2o=mean(XX2O-0)
odchylka_x3o=mean(XX3O-0)
odchylka_x4o=mean(XX4O-0)

%% mean |y1-yhat1|
odchylka_y1o=mean(YY1O-1)
odchylka_y2o=mean(YY2O-1)
odchylka_y3o=mean(YY3O-1)
odchylka_y4o=mean(YY4O-1)

%%  mean X1-Xhat1
odchylka_X1o=sqrt(odchylka_x1o^2+odchylka_y1o^2)
odchylka_X2o=sqrt(odchylka_x2o^2+odchylka_y2o^2)
odchylka_X3o=sqrt(odchylka_x3o^2+odchylka_y3o^2)
odchylka_X4o=sqrt(odchylka_x4o^2+odchylka_y4o^2)



%% mediana k?t
med_o0o=median(OO0O);
med_o1o=median(OO1O);
med_o2o=median(OO2O);
med_o3o=median(OO3O);
med_o4o=median(OO4O);
%% srednie odchylenie o?t
odch_o0o=std(OO0O);
odch_o1o=std(OO1O);
odch_o2o=std(OO2O);
odch_o3o=std(OO3O);
odch_o4o=std(OO4O);
%% sredni k?t
sre_o0o=mean(OO0O);
sre_o1o=mean(OO1O);
sre_o2o=mean(OO2O);
sre_o3o=mean(OO3O);
sre_o4o=mean(OO4O);
%% max K?T
max_o0o=max((OO0O));
max_o1o=max((OO1O));
max_o2o=max((OO2O));
max_o3o=max((OO3O));
max_o4o=max((OO4O));
%% min K?T
min_o0o=min((OO0O));
min_o1o=min((OO1O));
min_o2o=min((OO2O));
min_o3o=min((OO3O));
min_o4o=min((OO4O));
%% B??d wzgl?dem pozycji referencyjnej
%% B??d x
B_1_x=mean(sqrt((XX1O(:)-1).^2));
B_2_x=mean(sqrt((XX2O(:)-1).^2));
B_3_x=mean(sqrt((XX3O(:)-1).^2));
B_4_x=mean(sqrt((XX4O(:)-1).^2));
%% B??d y
B_1_y=mean(sqrt((YY1O(:)-0).^2));
B_2_y=mean(sqrt((YY2O(:)-0).^2));
B_3_y=mean(sqrt((YY3O(:)-0).^2));
B_4_y=mean(sqrt((YY4O(:)-0).^2));
%% B??d pozycji
M1=sqrt(B_1_x.^2+B_1_y.^2);
M2=sqrt(B_2_x.^2+B_2_y.^2);
M3=sqrt(B_3_x.^2+B_3_y.^2);
M4=sqrt(B_4_x.^2+B_4_y.^2);
%% czas 

czas1O(:,:)=(icp1o(:,4,zakres_min:zakres_max));
czasczas1O(:)=czas1O(:);

czas2O(:,:)=(icp2o(:,4,zakres_min:zakres_max));
czasczas2O(:)=czas2O(:);

czas3O(:,:)=(icp3o(:,4,zakres_min:zakres_max));
czasczas3O(:)=czas3O(:);

czas4O(:,:)=(icp4o(:,4,zakres_min:zakres_max));
czasczas4O(:)=czas4O(:);

sr_czas1=mean(czasczas1O);
sr_czas2=mean(czasczas2O);
sr_czas3=mean(czasczas3O);
sr_czas4=mean(czasczas4O);

%% odchy³ka od k¹ta prawdziwego œrednia

od_pr_kat_1o=mean(abs(OO1O-2));
od_pr_kat_2o=mean(abs(OO2O-2));
od_pr_kat_3o=mean(abs(OO3O-2));
od_pr_kat_4o=mean(abs(OO4O-2));

%% Dalsze obliczenia  KO£O
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
COG1o(:)=rad2deg(atan2(YY1O(:),XX1O(:))); %% wyszystkie cogi w jednym wierszu
COG2o(:)=rad2deg(atan2(YY2O(:),XX2O(:)));
COG3o(:)=rad2deg(atan2(YY3O(:),XX3O(:)));
COG4o(:)=rad2deg(atan2(YY4O(:),XX4O(:)));

cykl=1
for z=1:451
   for k=1:100                            %% zgrupowanie cogow w tabeli 100 na 451
    COG1o_2_t(k,z)=COG1o(cykl);
    COG2o_2_t(k,z)=COG2o(cykl);
    COG3o_2_t(k,z)=COG3o(cykl);
    COG4o_2_t(k,z)=COG4o(cykl);    
    cykl=cykl+1;
   k=k+1;
   end
   z=z+1;
end

sigma_cog_1_o=std(COG1o_2_t(:,:));
sigma_cog_2_o=std(COG2o_2_t(:,:));           %% wyznacznie sigmy z tych tabel wyznaczonych na górze
sigma_cog_3_o=std(COG3o_2_t(:,:));
sigma_cog_4_o=std(COG4o_2_t(:,:));

licznik=0;
for i = 1:1:451
    if sigma_cog_2_o(1,i)<=sigma_cog_4_o(1,i) && sigma_cog_2_o(1,i)<=sigma_cog_3_o(1,i) && sigma_cog_2_o(1,i)<=sigma_cog_1_o(1,i)
      licznik=licznik+1      
    end
end
p=(licznik/451)*100;

licznik=0;
for i = 1:1:451
    if sigma_cog_4_o(1,i)<=sigma_cog_2_o(1,i) && sigma_cog_4_o(1,i)<=sigma_cog_3_o(1,i) && sigma_cog_4_o(1,i)<=sigma_cog_1_o(1,i)
      licznik=licznik+1      
    end
end
p=(licznik/451)*100;





sre_COG1_o=mean(COG1o_2_t(:,:)-90);
sre_COG2_o=mean(COG2o_2_t(:,:)-90);
sre_COG3_o=mean(COG3o_2_t(:,:)-90);
sre_COG4_o=mean(COG4o_2_t(:,:)-90);


sigma_cog1o=std(COG1o)
sigma_cog2o=std(COG2o)                       %% dane statystyczne do tabeli -> odchylenia standardowe cogu Ok
sigma_cog3o=std(COG3o)
sigma_cog4o=std(COG4o)

sredni_cog10=mean(COG1o)-90
sredni_cog20=mean(COG2o)   -90                  %%  %% dane statystyczne do tabeli -> œrednie cogi Ok
sredni_cog30=mean(COG3o)-90
sredni_cog40=mean(COG4o)-90

mediana_cog_o_1=median(COG1o)-90;                 %%% Mediana do tabeli COG -> Ok nowa 
mediana_cog_o_2=median(COG2o)-90;         
mediana_cog_o_3=median(COG3o)-90;
mediana_cog_o_4=median(COG4o)-90;

max_cog_o_1=max(COG1o)-90;                      %%% Max do tabeli COG -> Ok nowa
max_cog_o_2=max(COG2o)-90;
max_cog_o_3=max(COG3o)-90;
max_cog_o_4=max(COG4o)-90;

min_cog_o_1=min(COG1o)-90;                      %%% Min do tabeli COG -> Ok nowa
min_cog_o_2=min(COG2o)-90;
min_cog_o_3=min(COG3o)-90;
min_cog_o_4=min(COG4o)-90;


SOG1o=sqrt(YY1O(:).^2+XX1O(:).^2);
SOG2o=sqrt(YY2O(:).^2+XX2O(:).^2);
SOG3o=sqrt(YY3O(:).^2+XX3O(:).^2);            %% Sogi w jednej kolumnie
SOG4o=sqrt(YY4O(:).^2+XX4O(:).^2);

sigma_sog1o=std(SOG1o);
sigma_sog2o=std(SOG2o);
sigma_sog3o=std(SOG3o);                       %% dane stat do tabeli -> œrednie odchylenia standardowe sogu ok
sigma_sog4o=std(SOG4o);

srednia_sog1o=mean(SOG1o);
srednia_sog2o=mean(SOG2o);
srednia_sog3o=mean(SOG3o);                    %% dane stat do tabelki -> œrednie sogi ok 
srednia_sog4o=mean(SOG4o);

mediana_sog1o=median(SOG1o);                   %%% mediana stat do tabelki -> mediana nowa
mediana_sog2o=median(SOG2o);
mediana_sog3o=median(SOG3o);
mediana_sog4o=median(SOG4o);

max_sog1o=max(SOG1o);                           %%% max sog 1 kwadrat do tabelki ->ok nowy
max_sog2o=max(SOG2o);
max_sog3o=max(SOG3o);
max_sog4o=max(SOG4o);

min_sog1o=min(SOG1o);                           %%% min sog 1 kwadrat do tabelki -> ok nowa
min_sog2o=min(SOG2o); 
min_sog3o=min(SOG3o); 
min_sog4o=min(SOG4o); 

SOG1oo(:,:)=sqrt((Y1O(:,:).^2+X1O(:,:).^2))
SOG2oo(:,:)=sqrt((Y2O(:,:).^2+X2O(:,:).^2))
SOG3oo(:,:)=sqrt((Y3O(:,:).^2+X3O(:,:).^2))
SOG4oo(:,:)=sqrt((Y4O(:,:).^2+X4O(:,:).^2))

sigma_SOG1oo(:)=std(SOG1oo(:,:))
sigma_SOG2oo(:)=std(SOG2oo(:,:))
sigma_SOG3oo(:)=std(SOG3oo(:,:))
sigma_SOG4oo(:)=std(SOG4oo(:,:))


licznik=0;
for i = 1:1:451
    if sigma_SOG2oo(1,i)<=sigma_SOG4oo(1,i) && sigma_SOG2oo(1,i)<=sigma_SOG3oo(1,i) && sigma_SOG2oo(1,i)<=sigma_SOG1oo(1,i)
      licznik=licznik+1  ;    
    end
end
p=(licznik/451)*100;

licznik=0;
for i = 1:1:451
    if sigma_cog_4_o(1,i)<=sigma_cog_2_o(1,i) && sigma_cog_4_o(1,i)<=sigma_cog_3_o(1,i) && sigma_cog_4_o(1,i)<=sigma_cog_1_o(1,i)
      licznik=licznik+1 ;     
    end
end
p=(licznik/451)*100;




sre_SOG1oo=mean(SOG1oo(:,:));                         %% œrednie sogi do wykresu okr¹g
sre_SOG2oo=mean(SOG2oo(:,:));
sre_SOG3oo=mean(SOG3oo(:,:));
sre_SOG4oo=mean(SOG4oo(:,:));

pause(2)
close all

plot(sigma_SOG1oo);
hold on
plot(sigma_SOG2oo);
plot(sigma_SOG3oo);
plot(sigma_SOG4oo);
%% Wykres COG
os_x=[100:2:1000]
hold off
close all

subplot(1,1,1);
fig2=plot(os_x,sigma_cog_1_o(1:451),'red');
%title('B³¹d œredni \Delta COG')
xlabel('Liczba punktów w skanie')
ylabel('\sigma_{\Delta COG_{(k+1)}} [\circ]')

hold on
fig3=plot(os_x,sigma_cog_3_o(1:451),'yellow');
fig4=plot(os_x,sigma_cog_2_o(1:451),'blue');
fig5=plot(os_x,sigma_cog_4_o(1:451),'green');
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
ylim([miny 3.3])
ytick=[miny:0.3:2 2.5 3]
ytick=round(ytick,1)

xlim([100 1000])
yticks(ytick)
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
yl = get(gca,'YTickLabel');
new_yl = strrep(yl(:),'.',',');
set(gca,'YTickLabel',new_yl)

plot(xlim, [1.0 1.0], '--k', 'LineWidth', .75)
c='dop. \sigma_{COG}'
c=[c newline '     (1^{\circ})']
t=text(1035, 1.2, c, 'BackgroundColor', 'w','rotation', -90);
t(1).FontSize = 12;
t(1).FontName = 'Times';
t(1).FontAngle= 'italic';

%plot(xlim, [0.4 0.4], '--k', 'LineWidth', .75)
%c='k. sat. \sigma_{COG}'
%c=[c newline '      (0,4^{\circ})']
%t=text(1035, 0.5, c, 'BackgroundColor', 'w', 'rotation', -90);
%t(1).FontSize = 12;
%t(1).FontName = 'Times';
%t(1).FontAngle= 'italic';


plot(xlim, [3.0 3.0], '--k', 'LineWidth', .75)
c='o. GNSS. \sigma_{COG}'
c=[c newline '        (3^{\circ})']
t=text(1035, 3.4, c, 'BackgroundColor', 'w', 'rotation', -90);
t(1).FontSize = 12;
t(1).FontName = 'Times';
t(1).FontAngle= 'italic';

box on
set(gca, 'YScale', 'log')
l=legend('ICP odporny (ICP_{R} )','ICP odporny - wsp. b³¹d œredni (ICP_{RME} )','ICP odporny - wsp. b³¹d œredni w kierunku (ICP_{RMDE} )','ICP odporny - wsp. b³¹d œredni wektorowy (ICP_{RVDE} )')
legend('Location','northeast')
l.NumColumns=1;
l.Position=([0.50 0.63 0.1778 0.1957]);
set(gcf, 'Position', get(0, 'Screensize')/1.5);
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\ruch\blad_COGo.jpg'];
print(ax.Parent,filename,'-djpeg', '-r500')
hold off
close all



%% Wykres SOG
os_x=[100:2:1000]
subplot(1,1,1);
fig2=plot(os_x,sigma_SOG1oo(1:451)*1.943844,'red');
%title('B³¹d œredni SOG')
xlabel('Liczba punktów w skanie')
ylabel('\sigma_{SOG_{(k+1)}} [wêz³y]')
hold on
fig3=plot(os_x,sigma_SOG3oo(1:451)*1.943844,'yellow');
fig4=plot(os_x,sigma_SOG2oo(1:451)*1.943844,'blue');
fig5=plot(os_x,sigma_SOG4oo(1:451)*1.943844,'green');
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
ylim([miny 0.25])
ytick=[0.01 0.02 0.03 0.04 0.05 0.06 0.08 0.10 0.15 0.20 0.25]
xlim([100 1000])
yticks(ytick)
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
yl = get(gca,'YTickLabel');
new_yl = strrep(yl(:),'.',',');
set(gca,'YTickLabel',new_yl)

yl = get(gca,'YTickLabel');





plot(xlim, [.2 .2], '--k', 'LineWidth', .75)
c='dop. \sigma_{SOG}'
c=[c '   (0,2{w})']
c=[c newline 'o. GNSS \sigma_{SOG}'];
c=[c '   (0,2{w}) ']
t=text(1035, .255, c, 'BackgroundColor', 'w',  'rotation', -90);
t(1).FontSize = 12;
t(1).FontName = 'Times';
t(1).FontAngle= 'italic';

plot(xlim, [0.05 0.05], '--k', 'LineWidth', .75)
c='DVL \sigma_{SOG}'
c=[c newline '   (0,05{w})']
t=text(1035, 0.06, c, 'BackgroundColor', 'w',  'rotation', -90);
t(1).FontSize = 12;
t(1).FontName = 'Times';
t(1).FontAngle= 'italic';
box on
set(gca, 'YScale', 'log')
l=legend('ICP odporny (ICP_{R} )','ICP odporny - wsp. b³¹d œredni (ICP_{RME} )','ICP odporny - wsp. b³¹d œredni w kierunku (ICP_{RMDE} )','ICP odporny - wsp. b³¹d œredni wektorowy (ICP_{RVDE} )')
legend('Location','northeast')
l.NumColumns=1;
l.Position=([0.50 0.63 0.1778 0.1957]);
set(gcf, 'Position', get(0, 'Screensize')/1.5);
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\ruch\blad_SOGo.jpg'];
print(ax.Parent,filename,'-djpeg', '-r500')
hold off
close all

%% Wykres œrednia COG
os_x=[100:2:1000]
subplot(1,1,1);
fig2=plot(os_x,sre_COG1_o(1:451),'red');
%title('œrednia z COG')
xlabel('Liczba punktów w skanie')
ylabel('\Delta COG_{(k+1)} [\circ]')
hold on
fig3=plot(os_x,sre_COG3_o(1:451),'yellow');
fig4=plot(os_x,sre_COG2_o(1:451),'blue');
fig5=plot(os_x,sre_COG4_o(1:451),'green');
fig2.LineWidth = 0.75;
fig3.LineWidth = .75;
fig4.LineWidth = .75;
fig5.LineWidth = .75;
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
ytick=[miny:0.1:maxy]
ytick=round(ytick,1)
%
xlim([100 1000])
yticks(ytick)
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
yl = get(gca,'YTickLabel');
new_yl = strrep(yl(:),'.',',');
set(gca,'YTickLabel',new_yl)
box on
%set(gca, 'YScale', 'log')
plot(xlim, [0.0 0.0], '-.black', 'LineWidth' , 0.75);
l=legend('ICP odporny (ICP_{R} )','ICP odporny - wsp. b³¹d œredni (ICP_{RME} )','ICP odporny - wsp. b³¹d œredni w kierunku (ICP_{RMDE} )','ICP odporny - wsp. b³¹d œredni wektorowy (ICP_{RVDE} )', 'Wartoœæ symulowana')
legend('Location','northeast')
l.NumColumns=1;
set(gcf, 'Position', get(0, 'Screensize')/1.5);
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\ruch\sredni_COGo.jpg'];
%saveas(gcf,filename);
print(ax.Parent,filename,'-djpeg', '-r500')
 %saveas(gcf,'fig1.jpeg')
hold off
close all
%% Wykres œrednia sog
os_x=[100:2:1000]
subplot(1,1,1);
fig2=plot(os_x,sre_SOG1oo(1:451)*1.943844,'red');
%title('œrednia z SOG')
xlabel('Liczba punktów w skanie')
ylabel('SOG_{(k+1)} [wêz³y]')
hold on
fig3=plot(os_x,sre_SOG3oo(1:451)*1.943844,'yellow');
fig4=plot(os_x,sre_SOG2oo(1:451)*1.943844,'blue');
fig5=plot(os_x,sre_SOG4oo(1:451)*1.943844,'green');
fig2.LineWidth = 0.75;
fig3.LineWidth = .75;
fig4.LineWidth = .75;
fig5.LineWidth = .75;
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
%ylim([miny maxy])
%ytick=[1.8:0.01:2.1]
%ytick=round(ytick,2)
%
xlim([100 1000])
%yticks(ytick)
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
yl = get(gca,'YTickLabel');
new_yl = strrep(yl(:),'.',',');
%set(gca,'YTickLabel',new_yl)
box on
%set(gca, 'YScale', 'log')
plot(xlim, [1.9438 1.9438], '-.black', 'LineWidth' , 0.75);
l=legend('ICP odporny (ICP_{R} )','ICP odporny - wsp. b³¹d œredni (ICP_{RME} )','ICP odporny - wsp. b³¹d œredni w kierunku (ICP_{RMDE} )','ICP odporny - wsp. b³¹d œredni wektorowy (ICP_{RVDE} )', 'Wartoœæ symulowana')
legend('Location','northeast')
l.NumColumns=1;
set(gcf, 'Position', get(0, 'Screensize')/1.5);
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\ruch\sredni_SOGo.jpg'];
print(ax.Parent,filename,'-djpeg', '-r500')
hold off
close all



%% Dalsze obliczenia KWADRAT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
COG1k(:)=rad2deg(atan2(YY1K(:),XX1K(:))); %% wyszystkie cogi w jednym wierszu
COG2k(:)=rad2deg(atan2(YY2K(:),XX2K(:)));
COG3k(:)=rad2deg(atan2(YY3K(:),XX3K(:)));
COG4k(:)=rad2deg(atan2(YY4K(:),XX4K(:)));

cykl=1
for z=1:451
   for k=1:100                            %% zgrupowanie cogow w tabeli 100 na 451
    COG1k_2_t(k,z)=COG1k(cykl);
    COG2k_2_t(k,z)=COG2k(cykl);
    COG3k_2_t(k,z)=COG3k(cykl);
    COG4k_2_t(k,z)=COG4k(cykl);    
    cykl=cykl+1;
   k=k+1;
   end
   z=z+1;
end

sigma_cog_1_k=std(COG1k_2_t(:,:));
sigma_cog_2_k=std(COG2k_2_t(:,:));           %% wyznacznie sigmy z tych tabel wyznaczonych na górze
sigma_cog_3_k=std(COG3k_2_t(:,:));
sigma_cog_4_k=std(COG4k_2_t(:,:));


licznik=0;
for i = 1:1:451
    if sigma_cog_2_k(1,i)<=sigma_cog_4_k(1,i) && sigma_cog_2_k(1,i)<=sigma_cog_3_k(1,i) && sigma_cog_2_k(1,i)<=sigma_cog_1_k(1,i)
      licznik=licznik+1      
    end
end
p2=(licznik/451)*100;

licznik=0;
for i = 1:1:451
    if sigma_cog_4_k(1,i)<=sigma_cog_2_k(1,i) && sigma_cog_4_k(1,i)<=sigma_cog_3_k(1,i) && sigma_cog_4_k(1,i)<=sigma_cog_1_k(1,i)
      licznik=licznik+1      
    end
end
p4=(licznik/451)*100;


licznik=0;
for i = 1:1:451
    if sigma_cog_3_k(1,i)<=sigma_cog_2_k(1,i) && sigma_cog_3_k(1,i)<=sigma_cog_1_k(1,i) && sigma_cog_3_k(1,i)<=sigma_cog_4_k(1,i)
      licznik=licznik+1      
    end
end
p3=(licznik/451)*100;

licznik=0;
for i = 1:1:451
    if sigma_cog_1_k(1,i)<=sigma_cog_2_k(1,i) && sigma_cog_1_k(1,i)<=sigma_cog_3_k(1,i) && sigma_cog_1_k(1,i)<=sigma_cog_4_k(1,i)
      licznik=licznik+1      
    end
end
p1=(licznik/451)*100;



sre_COG1_k=mean(COG1k_2_t(:,:)-90);
sre_COG2_k=mean(COG2k_2_t(:,:)-90);
sre_COG3_k=mean(COG3k_2_t(:,:)-90);
sre_COG4_k=mean(COG4k_2_t(:,:)-90);

sigma_cog1k=std(COG1k)
sigma_cog2k=std(COG2k)                       %% dane statystyczne do tabeli -> odchylenia standardowe cogu Ok
sigma_cog3k=std(COG3k)
sigma_cog4k=std(COG4k)


sredni_cog1k=mean(COG1k)-90;
sredni_cog2k=mean(COG2k)-90;                 %%  %% dane statystyczne do tabeli -> œrednie cogi Ok
sredni_cog3k=mean(COG3k)-90;
sredni_cog4k=mean(COG4k)-90;

mediana_cog_k_1=median(COG1k)-90;                 %%% Mediana do tabeli COG -> Ok nowa 
mediana_cog_k_2=median(COG2k)-90;         
mediana_cog_k_3=median(COG3k)-90;
mediana_cog_k_4=median(COG4k)-90;

max_cog_k_1=max(COG1k)-90;                      %%% Max do tabeli COG -> Ok nowa
max_cog_k_2=max(COG2k)-90;
max_cog_k_3=max(COG3k)-90;
max_cog_k_4=max(COG4k)-90;

min_cog_k_1=min(COG1k)-90;                      %%% Min do tabeli COG -> Ok nowa
min_cog_k_2=min(COG2k)-90;
min_cog_k_3=min(COG3k)-90;
min_cog_k_4=min(COG4k)-90;

SOG1k=sqrt(YY1K(:).^2+XX1K(:).^2);
SOG2k=sqrt(YY2K(:).^2+XX2K(:).^2);
SOG3k=sqrt(YY3K(:).^2+XX3K(:).^2);            %% Sogi w jednej kolumnie
SOG4k=sqrt(YY4K(:).^2+XX4K(:).^2);

sigma_sog1k=std(SOG1k);
sigma_sog2k=std(SOG2k);
sigma_sog3k=std(SOG3k);                       %% dane stat do tabeli -> œrednie odchylenia standardowe sogu ok
sigma_sog4k=std(SOG4k);

srednia_sog1k=mean(SOG1k);
srednia_sog2k=mean(SOG2k);
srednia_sog3k=mean(SOG3k);                    %% dane stat do tabelki -> œrednie sogi ok 
srednia_sog4k=mean(SOG4k);

mediana_sog1k=median(SOG1k);                   %%% mediana stat do tabelki -> mediana nowa
mediana_sog2k=median(SOG2k);
mediana_sog3k=median(SOG3k);
mediana_sog4k=median(SOG4k);

max_sog1k=max(SOG1k);                           %%% max sog 1 kwadrat do tabelki ->ok nowy
max_sog2k=max(SOG2k);
max_sog3k=max(SOG3k);
max_sog4k=max(SOG4k);

min_sog1k=min(SOG1k);                           %%% min sog 1 kwadrat do tabelki -> ok nowa
min_sog2k=min(SOG2k); 
min_sog3k=min(SOG3k); 
min_sog4k=min(SOG4k); 

SOG1kk(:,:)=sqrt((Y1K(:,:).^2+X1K(:,:).^2))
SOG2kk(:,:)=sqrt((Y2K(:,:).^2+X2K(:,:).^2))
SOG3kk(:,:)=sqrt((Y3K(:,:).^2+X3K(:,:).^2))
SOG4kk(:,:)=sqrt((Y4K(:,:).^2+X4K(:,:).^2))

sigma_SOG1kk(:)=std(SOG1kk(:,:))
sigma_SOG2kk(:)=std(SOG2kk(:,:))                  %% odchylenia do wykresu !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
sigma_SOG3kk(:)=std(SOG3kk(:,:))
sigma_SOG4kk(:)=std(SOG4kk(:,:))



licznik=0;
for i = 1:1:451
    if sigma_SOG2kk(1,i)<=sigma_SOG4kk(1,i) && sigma_SOG2kk(1,i)<=sigma_SOG3kk(1,i) && sigma_SOG2kk(1,i)<=sigma_SOG1kk(1,i)
      licznik=licznik+1      
    end
end
p2=(licznik/451)*100;

licznik=0;
for i = 1:1:451
    if sigma_SOG4kk(1,i)<=sigma_SOG2kk(1,i) && sigma_SOG4kk(1,i)<=sigma_SOG3kk(1,i) && sigma_SOG4kk(1,i)<=sigma_SOG1kk(1,i)
      licznik=licznik+1      
    end
end
p4=(licznik/451)*100;


licznik=0;
for i = 1:1:451
    if sigma_SOG3kk(1,i)<=sigma_SOG2kk(1,i) && sigma_SOG3kk(1,i)<=sigma_SOG1kk(1,i) && sigma_SOG3kk(1,i)<=sigma_SOG4kk(1,i)
      licznik=licznik+1      
    end
end
p3=(licznik/451)*100;

licznik=0;
for i = 1:1:451
    if sigma_SOG1kk(1,i)<=sigma_SOG2kk(1,i) && sigma_SOG1kk(1,i)<=sigma_SOG3kk(1,i) && sigma_SOG1kk(1,i)<=sigma_SOG4kk(1,i)
      licznik=licznik+1      
    end
end
p1=(licznik/451)*100;


sre_SOG1kk=mean(SOG1kk(:,:));                         %% œrednie sogi do wykresu okr¹g
sre_SOG2kk=mean(SOG2kk(:,:));
sre_SOG3kk=mean(SOG3kk(:,:));
sre_SOG4kk=mean(SOG4kk(:,:));

pause(2)
close all

%% Wykres COG
os_x=[100:2:1000]
hold off
close all

subplot(1,1,1);
fig2=plot(os_x,sigma_cog_1_k(1:451),'red');
%title('B³¹d œredni COG')
xlabel('Liczba punktów w skanie')
ylabel('\sigma_{\Delta COG_{(k+1)}} [\circ]')

hold on
fig3=plot(os_x,sigma_cog_3_k(1:451),'yellow');
fig4=plot(os_x,sigma_cog_2_k(1:451),'blue');
fig5=plot(os_x,sigma_cog_4_k(1:451),'green');
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
ytick=[miny:0.5:maxy]
ytick=round(ytick,1)

xlim([100 1000])
yticks(ytick)
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
yl = get(gca,'YTickLabel');
new_yl = strrep(yl(:),'.',',');
%set(gca,'YTickLabel',new_yl)

plot(xlim, [1.0 1.0], '--k', 'LineWidth', .75)
c='dop. \sigma_{COG}'
c=[c newline '     (1^{\circ})']
t=text(1035, 1.2, c, 'BackgroundColor', 'w','rotation', -90);
t(1).FontSize = 12;
t(1).FontName = 'Times';
t(1).FontAngle= 'italic';

%plot(xlim, [0.4 0.4], '--k', 'LineWidth', .75)
%c='k. sat. \sigma_{COG}'
%c=[c newline '      (0,4^{\circ})']
%t=text(1035, 0.5, c, 'BackgroundColor', 'w', 'rotation', -90);
%t(1).FontSize = 12;
%t(1).FontName = 'Times';
%t(1).FontAngle= 'italic';


plot(xlim, [3.0 3.0], '--k', 'LineWidth', .75)
c='o. GNSS. \sigma_{COG}'
c=[c newline '        (3^{\circ})']
t=text(1035, 3.6, c, 'BackgroundColor', 'w', 'rotation', -90);
t(1).FontSize = 12;
t(1).FontName = 'Times';
t(1).FontAngle= 'italic';

box on
set(gca, 'YScale', 'log')
l=legend('ICP odporny (ICP_{R} )','ICP odporny - wsp. b³¹d œredni (ICP_{RME} )','ICP odporny - wsp. b³¹d œredni w kierunku (ICP_{RMDE} )','ICP odporny - wsp. b³¹d œredni wektorowy (ICP_{RVDE} )')
legend('Location','northeast')
l.Position=([0.5 0.57 0.1778 0.1957]);
l.NumColumns=1;
set(gcf, 'Position', get(0, 'Screensize')/1.5);
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\ruch\blad_COGk.jpg'];
print(ax.Parent,filename,'-djpeg', '-r500')
hold off
close all



%% Wykres SOG
os_x=[100:2:1000];
subplot(1,1,1);
fig2=plot(os_x,sigma_SOG1kk(1:451)*1.943844,'red');
%title('B³¹d œredni SOG')
xlabel('Liczba punktów w skanie')
ylabel('\sigma_{SOG_{(k+1)}} [wêz³y]')
hold on
fig3=plot(os_x,sigma_SOG3kk(1:451)*1.943844,'yellow');
fig4=plot(os_x,sigma_SOG2kk(1:451)*1.943844,'blue');
fig5=plot(os_x,sigma_SOG4kk(1:451)*1.943844,'green');
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
ylim([miny 0.28])
ytick=[0.005 0.01 0.02 0.03 0.04 0.05 0.06 0.08 0.10 0.15 0.20 0.25]
%ytick=round(ytick,3)

xlim([100 1000])
yticks(ytick)
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
yl = get(gca,'YTickLabel');
new_yl = strrep(yl(:),'.',',');
yl = get(gca,'YTickLabel');

plot(xlim, [.2 .2], '--k', 'LineWidth', .75)
c='dop. \sigma_{SOG}'
c=[c '   (0,2{w})']
c=[c newline 'o. GNSS \sigma_{SOG}'];
c=[c '   (0,2{w}) ']
t=text(1035, .255, c, 'BackgroundColor', 'w',  'rotation', -90);
t(1).FontSize = 12;
t(1).FontName = 'Times';
t(1).FontAngle= 'italic';

plot(xlim, [0.05 0.05], '--k', 'LineWidth', .75)
c='DVL \sigma_{SOG}'
c=[c newline '   (0,05{w})']
t=text(1035, 0.06, c, 'BackgroundColor', 'w',  'rotation', -90);
t(1).FontSize = 12;
t(1).FontName = 'Times';
t(1).FontAngle= 'italic';

set(gca, 'YScale', 'log')
box on
l=legend('ICP odporny (ICP_{R} )','ICP odporny - wsp. b³¹d œredni (ICP_{RME} )','ICP odporny - wsp. b³¹d œredni w kierunku (ICP_{RMDE} )','ICP odporny - wsp. b³¹d œredni wektorowy (ICP_{RVDE} )')
legend('Location','northeast')
l.NumColumns=1;
l.Position=([0.5 0.57 0.1778 0.1957]);
set(gcf, 'Position', get(0, 'Screensize')/1.5);
%set(gca,'YTickLabel',new_yl);
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\ruch\blad_SOGk.jpg'];
print(ax.Parent,filename,'-djpeg', '-r500')
hold off
close all


%% Wykres œrednia
os_x=[100:2:1000]
subplot(1,1,1);
fig2=plot(os_x,sre_COG1_k(1:451),'red');
%title('œrednia z COG')
xlabel('Liczba punktów w skanie')
ylabel('\Delta COG_{(k+1)} [\circ]')
hold on
fig3=plot(os_x,sre_COG3_k(1:451),'yellow');
fig4=plot(os_x,sre_COG2_k(1:451),'blue');
fig5=plot(os_x,sre_COG4_k(1:451),'green');
fig2.LineWidth = 0.75;
fig3.LineWidth = .75;
fig4.LineWidth = .75;
fig5.LineWidth = .75;
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
%
xlim([100 1000])
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
yl = get(gca,'YTickLabel');
new_yl = strrep(yl(:),'.',',');
set(gca,'YTickLabel',new_yl)
box on
%set(gca, 'YScale', 'log')
plot(xlim, [0 0], '-.black', 'LineWidth' , 0.75);
plot(xlim, [0.0 0.0], '-.black', 'LineWidth' , 0.75);
l=legend('ICP odporny (ICP_{R} )','ICP odporny - wsp. b³¹d œredni (ICP_{RME} )','ICP odporny - wsp. b³¹d œredni w kierunku (ICP_{RMDE} )','ICP odporny - wsp. b³¹d œredni wektorowy (ICP_{RVDE} )', 'Wartoœæ symulowana')
legend('Location','southeast')
l.NumColumns=1;
set(gcf, 'Position', get(0, 'Screensize')/1.5);
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\ruch\sredni_COGk.jpg'];
%saveas(gcf,filename);
print(ax.Parent,filename,'-djpeg', '-r500')
 %saveas(gcf,'fig1.jpeg')
hold off
close all

%% Wykres œrednia sog
os_x=[100:2:1000]
subplot(1,1,1);
fig2=plot(os_x,sre_SOG1kk(1:451)*1.943844,'red');
%title('œrednia z SOG')
xlabel('Liczba punktów w skanie')
ylabel('SOG_{(k+1)} [wêz³y]')
hold on
fig3=plot(os_x,sre_SOG3kk(1:451)*1.943844,'yellow');
fig4=plot(os_x,sre_SOG2kk(1:451)*1.943844,'blue');
fig5=plot(os_x,sre_SOG4kk(1:451)*1.943844,'green');
fig2.LineWidth = 0.75;
fig3.LineWidth = .75;
fig4.LineWidth = .75;
fig5.LineWidth = .75;
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
xlim([100 1000])
xtick =[100:100:1000];
xticks(xtick)
grid on
grid minor
yl = get(gca,'YTickLabel');
new_yl = strrep(yl(:),'.',',');
set(gca,'YTickLabel',new_yl)
box on
plot(xlim, [1.9438 1.9438], '-.black', 'LineWidth' , 0.75);
l=legend('ICP odporny (ICP_{R} )','ICP odporny - wsp. b³¹d œredni (ICP_{RME} )','ICP odporny - wsp. b³¹d œredni w kierunku (ICP_{RMDE} )','ICP odporny - wsp. b³¹d œredni wektorowy (ICP_{RVDE} )', 'Wartoœæ symulowana')
legend('Location','northeast')
l.NumColumns=1;
set(gcf, 'Position', get(0, 'Screensize')/1.5);
filename=['C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\wykresy\ruch\sredni_SOGk.jpg'];
%saveas(gcf,filename);
print(ax.Parent,filename,'-djpeg', '-r500')
 %saveas(gcf,'fig1.jpeg')
hold off
close all





%%%%%%%%%%%
%%%%%%%%%%%
%%%%%%%%%%%
%%%%%%%%%%%
%

[a1,b1]=wyznacz(sigma_cog_1_k, 1)
[a2,b2]=wyznacz(sigma_cog_2_k, 1)
[a3,b3]=wyznacz(sigma_cog_3_k, 1)
[a4,b4]=wyznacz(sigma_cog_4_k, 1)

[a1,b1]=wyznacz(sigma_cog_1_k, 3)
[a2,b2]=wyznacz(sigma_cog_2_k, 3)
[a3,b3]=wyznacz(sigma_cog_3_k, 3)
[a4,b4]=wyznacz(sigma_cog_4_k, 3)



[a1,b1]=wyznacz(sigma_cog_1_o, 1)
[a2,b2]=wyznacz(sigma_cog_2_o, 1)
[a3,b3]=wyznacz(sigma_cog_3_o, 1)
[a4,b4]=wyznacz(sigma_cog_4_o, 1)

[a1,b1]=wyznacz(sigma_cog_1_o, 3)
[a2,b2]=wyznacz(sigma_cog_2_o, 3)
[a3,b3]=wyznacz(sigma_cog_3_o, 3)
[a4,b4]=wyznacz(sigma_cog_4_o, 3)


[sa1,sb1]=wyznacz(sigma_SOG1oo*1.943844,0.2)
[sa2,sb2]=wyznacz(sigma_SOG2oo*1.943844,0.2)
[sa3,sb3]=wyznacz(sigma_SOG3oo*1.943844,0.2)
[sa4,sb4]=wyznacz(sigma_SOG4oo*1.943844,0.2)


[sa1,sb1]=wyznacz(sigma_SOG1oo*1.943844,0.05)
[sa2,sb2]=wyznacz(sigma_SOG2oo*1.943844,0.05)
[sa3,sb3]=wyznacz(sigma_SOG3oo*1.943844,0.05)
[sa4,sb4]=wyznacz(sigma_SOG4oo*1.943844,0.05)




[sa1,sb1]=wyznacz(sigma_SOG1kk*1.943844,0.2)
[sa2,sb2]=wyznacz(sigma_SOG2kk*1.943844,0.2)
[sa3,sb3]=wyznacz(sigma_SOG3kk*1.943844,0.2)
[sa4,sb4]=wyznacz(sigma_SOG4kk*1.943844,0.2)


[sa1,sb1]=wyznacz(sigma_SOG1kk*1.943844,0.05)
[sa2,sb2]=wyznacz(sigma_SOG2kk*1.943844,0.05)
[sa3,sb3]=wyznacz(sigma_SOG3kk*1.943844,0.05)
[sa4,sb4]=wyznacz(sigma_SOG4kk*1.943844,0.05)

