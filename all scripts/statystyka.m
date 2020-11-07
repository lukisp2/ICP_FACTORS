%%9; predkosc
v=1
v0(:,:)=((icp0k(:,1,6:96)).^2+(icp0k(:,2,6:96).^2).^0.5-1);
vv0(:)=v0(:);
ev0k=std(vv0)
v1(:,:)=((icp1k(:,1,6:96)).^2+(icp1k(:,2,6:96).^2).^0.5-1);
vv1(:)=v1(:);
ev1k=std(vv1)
v2(:,:)=((icp2k(:,1,6:96)).^2+(icp2k(:,2,6:96).^2).^0.5-1);
vv2(:)=v2(:);
ev2k=std(vv2)
v3(:,:)=((icp3k(:,1,6:96)).^2+(icp3k(:,2,6:96).^2).^0.5-1);
vv3(:)=v3(:);
ev3k=std(vv3)
v4(:,:)=((icp4k(:,1,6:96)).^2+(icp4k(:,2,6:96).^2).^0.5-1);
vv4(:)=v4(:);
ev4k=std(vv4)


v0(:,:)=((icp0o(:,1,6:96)).^2+(icp0o(:,2,6:96).^2).^0.5-1)
vv0(:)=v0(:);
ev0o=std(vv0)
v1(:,:)=((icp1o(:,1,6:96)).^2+(icp1o(:,2,6:96).^2).^0.5-1)
vv1(:)=v1(:);
ev1o=std(vv1)
v2(:,:)=((icp2o(:,1,6:96)).^2+(icp2o(:,2,6:96).^2).^0.5-1)
vv2(:)=v2(:);
ev2o=std(vv2)
v3(:,:)=((icp3o(:,1,6:96)).^2+(icp3o(:,2,6:96).^2).^0.5-1)
vv3(:)=v3(:);
ev3o=std(vv3)
v4(:,:)=((icp4o(:,1,6:96)).^2+(icp4o(:,2,6:96).^2).^0.5-1)
vv4(:)=v4(:);
ev4o=std(vv4)

k0(:,:)=abs((icp0k(:,3,30:96))-0)
kk0(:)=k0(:);
ek0=std(kk0)
k1(:,:)=abs((icp1k(:,3,30:96))-0)
kk1(:)=k1(:);
ek1=std(kk1)
k2(:,:)=abs((icp2k(:,3,30:96))-0)
kk2(:)=k2(:);
ek2=std(kk2)
k3(:,:)=abs((icp3k(:,3,30:96))-0)
kk3(:)=k3(:);
ek3=std(kk3)
k4(:,:)=abs((icp4k(:,3,30:96))-0)
kk4(:)=k4(:);
ek4=std(kk4)

k0(:,:)=((icp0o(:,3,30:96))-0)
kk0(:)=k0(:);
ek0=std(kk0)
k1(:,:)=((icp1o(:,3,30:96))-0)
kk1(:)=k1(:);
ek1=std(kk1)
k2(:,:)=((icp2o(:,3,30:96))-0)
kk2(:)=k2(:);
ek2=std(kk2)
k3(:,:)=((icp3o(:,3,30:96))-0)
kk3(:)=k3(:);
ek3=std(kk3)
k4(:,:)=((icp4o(:,3,30:96))-0)
kk4(:)=k4(:);
ek4=std(kk4)


v0(:,:)=abs((icp0o(:,1,6:96)).^2+(icp0o(:,2,6:96).^2).^0.5-1)
vv0(:)=v0(:);
ev0=std(vv0)
v1(:,:)=abs((icp1o(:,1,6:96)).^2+(icp1o(:,2,6:96).^2).^0.5-1)
vv1(:)=v1(:);
ev1=std(vv1)
v2(:,:)=abs((icp2o(:,1,6:96)).^2+(icp2o(:,2,6:96).^2).^0.5-1)
vv2(:)=v2(:);
ev2=std(vv2)
v3(:,:)=abs((icp3o(:,1,6:96)).^2+(icp3o(:,2,6:96).^2).^0.5-1)
vv3(:)=v3(:);
ev3=std(vv3)
v4(:,:)=abs((icp4o(:,1,6:96)).^2+(icp4o(:,2,6:96).^2).^0.5-1)
vv4(:)=v4(:);
ev4=std(vv4)





sv0=mean(mean(sqrt((icp0o(:,1,30:96)).^2+(icp0o(:,2,30:96).^2))))
sv1=mean(mean(sqrt((icp1o(:,1,30:96)).^2+(icp1o(:,2,30:96).^2))))
sv2=mean(mean(sqrt((icp2o(:,1,30:96)).^2+(icp2o(:,2,30:96).^2))))
sv3=mean(mean(sqrt((icp3o(:,1,30:96)).^2+(icp3o(:,2,30:96).^2))))
sv4=mean(mean(sqrt((icp4o(:,1,30:96)).^2+(icp4o(:,2,30:96).^2))))




%%kwadrat
%%medniana x
for i= 6:96
medx0(i-5)=median(icp0k(:,1,i));
end
srednia_mediana_x_icp0k=mean(medx0)-0.25

for i= 6:96
medx1(i-5)=median(icp1k(:,1,i));
end
srednia_mediana_x_icp1k=mean(medx1)-0.25

for i= 6:96
medx2(i-5)=median(icp2k(:,1,i));
end
srednia_mediana_x_icp2k=mean(medx2)-0.25

for i= 6:96
medx3(i-5)=median(icp3k(:,1,i));
end
srednia_mediana_x_icp3k=mean(medx3)-0.25

for i= 6:96
medx4(i-5)=median(icp4k(:,1,i));
end
srednia_mediana_x_icp4k=mean(medx4)-0.25
%%medniana y
for i= 6:96
medy0(i-5)=median(icp0k(:,2,i));
end
srednia_mediana_y_icp0k=mean(medy0)

for i= 6:96
medy1(i-5)=median(icp1k(:,2,i));
end
srednia_mediana_y_icp1k=mean(medy1)

for i= 6:96
medy2(i-5)=median(icp2k(:,2,i));
end
srednia_mediana_y_icp2k=mean(medy2)

for i= 6:96
medy3(i-5)=median(icp3k(:,2,i));
end
srednia_mediana_y_icp3k=mean(medy3)


for i= 6:96
medy4(i-5)=median(icp4k(:,2,i));
end
srednia_mediana_y_icp4k=mean(medy4)

%% srednie odchylenie x
srednia_sigma_x0k=mean(sigma_x_zwy_k(1,6:96))
srednia_sigma_x1k=mean(sigma_x_hub_k(1,6:96))
srednia_sigma_x2k=mean(sigma_x_sre_k(1,6:96))
srednia_sigma_x3k=mean(sigma_x_kier_k(1,6:96))
srednia_sigma_x4k=mean(sigma_x_wek_k(1,6:96))
X0(:,:)=(icp0k(:,1,6:96)-1); XX0(:)=X0(:);
eX0k=std(XX0)
X1(:,:)=(icp1k(:,1,6:96)-1); XX1(:)=X1(:);
eX1k=std(XX1)
X2(:,:)=(icp2k(:,1,6:96)-1); XX2(:)=X2(:);
eX2k=std(XX2)
X3(:,:)=(icp3k(:,1,6:96)-1); XX3(:)=X3(:);
eX3k=std(XX3)
X4(:,:)=(icp4k(:,1,6:96)-1); XX4(:)=X4(:);
eX4k=std(XX4)

%% srednie odchylenie y
srednia_sigma_y0k=mean(sigma_y_zwy_k(1,6:96))
srednia_sigma_y1k=mean(sigma_y_hub_k(1,6:96))
srednia_sigma_y2k=mean(sigma_y_sre_k(1,6:96))
srednia_sigma_y3k=mean(sigma_y_kier_k(1,6:96))
srednia_sigma_y4k=mean(sigma_y_wek_k(1,6:96))
Y0(:,:)=(icp0k(:,2,6:96)); YY0(:)=Y0(:);
eY0k=std(YY0)
Y1(:,:)=(icp1k(:,2,6:96)); YY1(:)=Y1(:);
eY1k=std(YY1)
Y2(:,:)=(icp2k(:,2,6:96)); YY2(:)=Y2(:);
eY2k=std(YY2)
Y3(:,:)=(icp3k(:,2,6:96)); YY3(:)=Y3(:);
eY3k=std(YY3)
Y4(:,:)=(icp4k(:,2,6:96)); YY4(:)=Y4(:);
eY4k=std(YY4)

%srednie odchylenie pozycji - b³¹d pozycji
M0k=mean(sqrt(sigma_y_zwy_k(1,6:96).*sigma_y_zwy_k(1,6:96)+sigma_x_zwy_k(1,6:96).*sigma_x_zwy_k(1,6:96)))
M1k=mean(sqrt(sigma_y_hub_k(1,6:96).*sigma_y_hub_k(1,6:96)+sigma_x_hub_k(1,6:96).*sigma_x_hub_k(1,6:96)))
M2k=mean(sqrt(sigma_y_sre_k(1,6:96).*sigma_y_sre_k(1,6:96)+sigma_x_sre_k(1,6:96).*sigma_x_sre_k(1,6:96)))
M3k=mean(sqrt(sigma_y_kier_k(1,6:96).*sigma_y_kier_k(1,6:96)+sigma_x_kier_k(1,6:96).*sigma_x_kier_k(1,6:96)))
M4k=mean(sqrt(sigma_y_wek_k(1,6:96).*sigma_y_wek_k(1,6:96)+sigma_x_wek_k(1,6:96).*sigma_x_wek_k(1,6:96)))
M0k=100*sqrt(eX0k^2+eY0k^2)^0.5 
M1k=100*sqrt(eX1k^2+eY1k^2)^0.5
M2k=100*sqrt(eX2k^2+eY2k^2)^0.5
M3k=100*sqrt(eX3k^2+eY3k^2)^0.5
M4k=100*sqrt(eX4k^2+eY4k^2)^0.5

%% srednie x
for i= 6:96
x0(i-5)=mean(icp0k(:,1,i));
end
srednie_x_icp0k=mean(x0)

for i= 6:96
x1(i-5)=mean(icp1k(:,1,i));
end
srednie_x_icp1k=mean(x1)

for i= 6:96
x2(i-5)=mean(icp2k(:,1,i));
end
srednie_x_icp2k=mean(x2)

for i= 6:96
x3(i-5)=mean(icp3k(:,1,i));
end
srednie_x_icp3k=mean(x3)

for i= 6:96
x4(i-5)=mean(icp4k(:,1,i));
end
srednie_x_icp4k=mean(x4)

%% srednie y
for i= 6:96
y0(i-5)=mean(icp0k(:,2,i));
end
srednie_y_icp0k=mean(y0)

for i= 6:96
y1(i-5)=mean(icp1k(:,2,i));
end
srednie_y_icp1k=mean(y1)

for i= 6:96
y2(i-5)=mean(icp2k(:,2,i));
end
srednie_y_icp2k=mean(y2)

for i= 6:96
y3(i-5)=mean(icp3k(:,2,i));
end
srednie_y_icp3k=mean(y3)

for i= 6:96
y4(i-5)=mean(icp4k(:,2,i));
end
srednie_y_icp4k=mean(y4)

%% max x 
max_x_k0=max(abs(max(icp0k(:,1,:))))-0.25
max_x_k1=max(abs(max(icp1k(:,1,:))))-0.25
max_x_k2=max(abs(max(icp2k(:,1,:))))-0.25
max_x_k3=max(abs(max(icp3k(:,1,:))))-0.25
max_x_k4=max(abs(max(icp4k(:,1,:))))-0.25
%% max y
max_y_k0=max(abs(max(icp0k(:,2,:))))
max_y_k1=max(abs(max(icp1k(:,2,:))))
max_y_k2=max(abs(max(icp2k(:,2,:))))
max_y_k3=max(abs(max(icp3k(:,2,:))))
max_y_k4=max(abs(max(icp4k(:,2,:))))
%% min x
min_x_k0=min(abs(min(icp0k(:,1,:))-.25))
min_x_k1=min(abs(min(icp1k(:,1,:))-.25))
min_x_k2=min(abs(min(icp2k(:,1,:))-.25))
min_x_k3=min(abs(min(icp3k(:,1,:))-.25))
min_x_k4=min(abs(min(icp4k(:,1,:))-.25))
%% min y
min_y_k0=min(min(abs(icp0k(:,2,:))))
min_y_k1=min(min(abs(icp1k(:,2,:))))
min_y_k2=min(min(abs(icp2k(:,2,:))))
min_y_k3=min(min(abs(icp3k(:,2,:))))
min_y_k4=min(min(abs(icp4k(:,2,:))))

%% œredni b³¹d k¹ta
srednia_sigmakk0=mean(std(icp0k(:,3,:)))
srednia_sigmakk1=mean(std(icp1k(:,3,:)))
srednia_sigmakk2=mean(std(icp2k(:,3,:)))
srednia_sigmakk3=mean(std(icp3k(:,3,:)))
srednia_sigmakk4=mean(std(icp4k(:,3,:)))
%% œredni k¹t
sredni_kk0=mean(mean(icp0k(:,3,:)))
sredni_kk1=mean(mean(icp1k(:,3,:)))
sredni_kk2=mean(mean(icp2k(:,3,:)))
sredni_kk3=mean(mean(icp3k(:,3,:)))
sredni_kk4=mean(mean(icp4k(:,3,:)))
%% min k¹t
min_kk0=min(min(abs(icp0k(:,3,:))))
min_kk1=min(min(abs(icp1k(:,3,:))))
min_kk2=min(min(abs(icp2k(:,3,:))))
min_kk3=min(min(abs(icp3k(:,3,:))))
min_kk4=min(min(abs(icp4k(:,3,:))))

%% max k¹t
max_kk0=max(max(abs(icp0k(:,3,:))))
max_kk1=max(max(abs(icp1k(:,3,:))))
max_kk2=max(max(abs(icp2k(:,3,:))))
max_kk3=max(max(abs(icp3k(:,3,:))))
max_kk4=max(max(abs(icp4k(:,3,:))))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%okr¹g
%%medniana x
for i= 6:96
medx0(i-5)=median(icp0o(:,1,i));
end
srednia_mediana_x_icp0o=mean(medx0)

for i= 6:96
medx1(i-5)=median(icp1o(:,1,i));
end
srednia_mediana_x_icp1o=mean(medx1)

for i= 6:96
medx2(i-5)=median(icp2o(:,1,i));
end
srednia_mediana_x_icp2o=mean(medx2)

for i= 6:96
medx3(i-5)=median(icp3o(:,1,i));
end
srednia_mediana_x_icp3o=mean(medx3)

for i= 6:96
medx4(i-5)=median(icp4o(:,1,i));
end
srednia_mediana_x_icp4o=mean(medx4)
%%medniana y
for i= 6:96
medy0(i-5)=median(icp0o(:,2,i));
end
srednia_mediana_y_icp0o=mean(medy0)

for i= 6:96
medy1(i-5)=median(icp1o(:,2,i));
end
srednia_mediana_y_icp1o=mean(medy1)

for i= 6:96
medy2(i-5)=median(icp2o(:,2,i));
end
srednia_mediana_y_icp2o=mean(medy2)

for i= 6:96
medy3(i-5)=median(icp3o(:,2,i));
end
srednia_mediana_y_icp3o=mean(medy3)


for i= 6:96
medy4(i-5)=median(icp4o(:,2,i));
end
srednia_mediana_y_icp4o=mean(medy4)

%% srednie odchylenie x
srednia_sigma_x0o=mean(sigma_x_zwy_o(1,6:96))
srednia_sigma_x1o=mean(sigma_x_hub_o(1,6:96))
srednia_sigma_x2o=mean(sigma_x_sre_o(1,6:96))
srednia_sigma_x3o=mean(sigma_x_kier_o(1,6:96))
srednia_sigma_x4o=mean(sigma_x_wek_o(1,6:96))


%% srednie odchylenie y
srednia_sigma_y0o=mean(sigma_y_zwy_o(1,6:96))
srednia_sigma_y1o=mean(sigma_y_hub_o(1,6:96))
srednia_sigma_y2o=mean(sigma_y_sre_o(1,6:96))
srednia_sigma_y3o=mean(sigma_y_kier_o(1,6:96))
srednia_sigma_y4o=mean(sigma_y_wek_o(1,6:96))

%srednie odchylenie pozycji - b³¹d pozycji
M0o=mean(sqrt(sigma_y_zwy_o(1,6:96).*sigma_y_zwy_o(1,6:96)+sigma_x_zwy_o(1,6:96).*sigma_x_zwy_o(1,6:96)))
M1o=mean(sqrt(sigma_y_hub_o(1,6:96).*sigma_y_hub_o(1,6:96)+sigma_x_hub_o(1,6:96).*sigma_x_hub_o(1,6:96)))
M2o=mean(sqrt(sigma_y_sre_o(1,6:96).*sigma_y_sre_o(1,6:96)+sigma_x_sre_o(1,6:96).*sigma_x_sre_o(1,6:96)))
M3o=mean(sqrt(sigma_y_kier_o(1,6:96).*sigma_y_kier_o(1,6:96)+sigma_x_kier_o(1,6:96).*sigma_x_kier_o(1,6:96)))
M4o=mean(sqrt(sigma_y_wek_o(1,6:96).*sigma_y_wek_o(1,6:96)+sigma_x_wek_o(1,6:96).*sigma_x_wek_o(1,6:96)))



%% srednie x
for i= 6:96
x0(i-5)=mean(icp0o(:,1,i));
end
srednie_x_icp0o=mean(x0)

for i= 6:96
x1(i-5)=mean(icp1o(:,1,i));
end
srednie_x_icp1o=mean(x1)

for i= 6:96
x2(i-5)=mean(icp2o(:,1,i));
end
srednie_x_icp2o=mean(x2)

for i= 6:96
x3(i-5)=mean(icp3o(:,1,i));
end
srednie_x_icp3o=mean(x3)

for i= 6:96
x4(i-5)=mean(icp4o(:,1,i));
end
srednie_x_icp4o=mean(x4)

%% srednie y
for i= 6:96
y0(i-5)=mean(icp0o(:,2,i));
end
srednie_y_icp0o=mean(y0)

for i= 6:96
y1(i-5)=mean(icp1o(:,2,i));
end
srednie_y_icp1o=mean(y1)

for i= 6:96
y2(i-5)=mean(icp2o(:,2,i));
end
srednie_y_icp2o=mean(y2)

for i= 6:96
y3(i-5)=mean(icp3o(:,2,i));
end
srednie_y_icp3o=mean(y3)

for i= 6:96
y4(i-5)=mean(icp4o(:,2,i));
end
srednie_y_icp4o=mean(y4)

%% max x 
max_x_o0(:)=abs(max(icp0o(:,1,:))-1.25)
max_x_o1(:)=abs(max(icp1o(:,1,:))-1.25)
max_x_o2(:)=abs(max(icp2o(:,1,:))-1.25)
max_x_o3(:)=abs(max(icp3o(:,1,:))-1.25)
max_x_o4(:)=abs(max(icp4o(:,1,:))-1.25)
%% max y
max_y_o0(:)=abs(max(icp0o(:,2,:)))
max_y_o1(:)=abs(max(icp1o(:,2,:)))
max_y_o2(:)=abs(max(icp2o(:,2,:)))
max_y_o3(:)=abs(max(icp3o(:,2,:)))
max_y_o4(:)=abs(max(icp4o(:,2,:)))
%% min x
min_x_o0(:)=abs(min(icp0o(:,1,:))-1.25)
min_x_o1(:)=abs(min(icp1o(:,1,:))-1.25)
min_x_o2(:)=abs(min(icp2o(:,1,:))-1.25)
min_x_o3(:)=abs(min(icp3o(:,1,:))-1.25)
min_x_o4(:)=abs(min(icp4o(:,1,:))-1.25)
%% min y
min_y_o0(:)=abs(min(icp0o(:,2,:)))
min_y_o1(:)=abs(min(icp1o(:,2,:)))
min_y_o2(:)=abs(min(icp2o(:,2,:)))
min_y_o3(:)=abs(min(icp3o(:,2,:)))
min_y_o4(:)=abs(min(icp4o(:,2,:)))

%% œredni b³¹d k¹ta
srednia_sigmako0=mean(std(icp0o(:,3,:)))
srednia_sigmako1=mean(std(icp1o(:,3,:)))
srednia_sigmako2=mean(std(icp2o(:,3,:)))
srednia_sigmako3=mean(std(icp3o(:,3,:)))
srednia_sigmako4=mean(std(icp4o(:,3,:)))
%% œredni k¹t
sredni_ko0=mean(mean(icp0o(:,3,:)))
sredni_ko1=mean(mean(icp1o(:,3,:)))
sredni_ko2=mean(mean(icp2o(:,3,:)))
sredni_ko3=mean(mean(icp3o(:,3,:)))
sredni_ko4=mean(mean(icp4o(:,3,:)))
%% min k¹t
min_ko0=min(min(abs(icp0o(:,3,:))))
min_ko1=min(min(abs(icp1o(:,3,:))))
min_ko2=min(min(abs(icp2o(:,3,:))))
min_ko3=min(min(abs(icp3o(:,3,:))))
min_ko4=min(min(abs(icp4o(:,3,:))))

%% max k¹t
max_ko0=max(max(abs(icp0o(:,3,:))))
max_ko1=max(max(abs(icp1o(:,3,:))))
max_ko2=max(max(abs(icp2o(:,3,:))))
max_ko3=max(max(abs(icp3o(:,3,:))))
max_ko4=max(max(abs(icp4o(:,3,:))))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


