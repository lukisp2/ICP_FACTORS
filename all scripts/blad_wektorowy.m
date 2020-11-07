function VVV = blad_wektorowy(data,data1,model,k,vi,TT,TR,sigma_odl,sigma_KK,wskaznik)
%data1 to data przed zmian¹, model nie jest zmieniany
format long

    r_data1=sqrt(data1(1,k)^2+data1(2,k)^2);
    ang_data1=atan2(data1(2,k),data1(1,k));
    if ang_data1<0
        ang_data1=ang_data1+2*pi;
    end
    r_model=sqrt(model(1,vi(k,1))^2+model(2,vi(k,1))^2);    
    ang_model=atan2(model(2,vi(k,1)),model(1,vi(k,1)));
        if ang_model<0
        ang_model=ang_model+2*pi;
        end
        %data1
        sigmalp1=r_data1*sigma_KK;
        sigmalp2=sigma_odl;
        theta = deg2rad(90);
        V1= sigmalp1/sin(theta);
        V2= sigmalp2/sin(theta);
        a_data1= (sqrt(V1^2+V2^2+2*V1*V2*sin(theta))+sqrt(V1^2+V2^2-2*V1*V2*sin(theta)))/2;
        b_data1=sqrt(V1^2+V2^2+2*V1*V2*sin(theta))-a_data1;
        %model
        sigmalp1=r_model*sigma_KK;
        sigmalp2=sigma_odl;
        theta = deg2rad(90);
        V1= sigmalp1/sin(theta);
        V2= sigmalp2/sin(theta);
        a_model= (sqrt(V1^2+V2^2+2*V1*V2*sin(theta))+sqrt(V1^2+V2^2-2*V1*V2*sin(theta)))/2;
        b_model=sqrt(V1^2+V2^2+2*V1*V2*sin(theta))-a_model;
xd=data(1,k);
yd=data(2,k);
xm=model(1,vi(k,1));
ym=model(2,vi(k,1));

if wskaznik ==1 %data
x1=xd;
y1=yd;
x2=xm;
y2=ym;
gamma = atan2(y2-y1,x2-x1);
if y2-y1<0
   gamma = 2*pi+gamma;
end
    
gora=(b_data1*cos(-ang_data1)*tan(gamma)+b_data1*sin(-ang_data1));
dol=(-a_data1*sin(-ang_data1)*tan(gamma)+a_data1*cos(-ang_data1));
alfa= atan(gora/dol)+pi;
ang=alfa;
namiar=ang_data1;
V3=b_data1*cos(ang)*cos(namiar)-a_data1*sin(ang)*sin(namiar);
V4=a_data1*sin(ang)*cos(namiar)+b_data1*cos(ang)*sin(namiar);
VVV=sqrt(V3^2+V4^2);
end

if wskaznik ==0 %model
x2=xd;
y2=yd;
x1=xm;
y1=ym;
gamma = atan2(y2-y1,x2-x1);
if y2-y1<0
   gamma = 2*pi+gamma;
end
   
gora=(b_model*cos(-ang_model)*tan(gamma)+b_model*sin(-ang_model));
dol=(-a_model*sin(-ang_model)*tan(gamma)+a_model*cos(-ang_model));
alfa= atan(gora/dol)+pi;
ang=alfa;
namiar=ang_model;
V3=b_model*cos(ang)*cos(namiar)-a_model*sin(ang)*sin(namiar);
V4=a_model*sin(ang)*cos(namiar)+b_model*cos(ang)*sin(namiar);
VVV=sqrt(V3^2+V4^2);   
end
end