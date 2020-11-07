function PP=kowariancja(model, data,sigma_KK,sigma_D)
%% SPRAWDZ CZY SIGMA_KK JEST W STOPNIACH CZY RADIANACH
%% POWINNA BYC W STOPNIACH

%sigma_KK = rad2deg(sigma_KK);
theta=deg2rad(90);
P_M=zeros(2,2,length(model));
P_D=zeros(2,2,length(data));
for i=1:length(model)
 D=(model(1,i)^2+model(2,i)^2)^0.5; %OK
 NR=(atan2(model(2,i),model(1,i))); %OK
 if NR<0
   NR=NR+2*pi;
 end
 V1=rad2deg(sigma_KK)*D/ 57.2957795130; %OK
 V2=sigma_D;
 a_plus_b=sqrt(V1^2+V2^2+2*V1*V2*sin(theta));
 a_minus_b=sqrt(V1^2+V2^2-2*V1*V2*sin(theta));
 a=(a_plus_b+a_minus_b)/2;
 b=a_plus_b-a;
 tan2alfa=(sin(2*theta)/((V1/V2)^2+cos(2*theta)));
 alfa=atan(tan2alfa)/2+pi/2;
 sigma_fi_kwadrat=a^2*(cos(NR+alfa))^2+b^2*(sin(NR+alfa))^2;
 sigma_lambda_kwadat=a^2*(sin(NR+alfa))^2+b^2*(cos(NR+alfa))^2;
 k_lambda_fi=(a^2-b^2)*sin(NR+alfa)*cos(NR+alfa);
 k_fi_lamdna=(a^2-b^2)*sin(NR+alfa)*cos(NR+alfa);
P(1,1)=sigma_fi_kwadrat; P(1,2)=k_fi_lamdna;
P(2,1)=k_lambda_fi; P(2,2)=sigma_lambda_kwadat;
%Sy=[cos(y) sin(y)];
%blad_y=Sy*P*Sy';
mu(1)=data(1,i); mu(2)=data(2,i);
p=0.95;
skala=1;

%plotErrorEllipse_bez_dest(mu, P, p, 'red',skala);

%hold on


PP(i).kow_m(1,1)=P(1,1);
PP(i).kow_m(1,2)=P(1,2);
PP(i).kow_m(2,1)=P(2,1);
PP(i).kow_m(2,2)=P(2,2);
end
for i=1:length(data)
 D=(data(1,i)^2+data(2,i)^2)^0.5;
 NR=(atan2(data(2,i),data(1,i)));
 if NR<0
     NR=NR+2*pi;
 end
 V1=rad2deg(sigma_KK)*D/ 57.2957795130;
 V2=sigma_D;
 a_plus_b=sqrt(V1^2+V2^2+2*V1*V2*sin(theta));
 a_minus_b=sqrt(V1^2+V2^2-2*V1*V2*sin(theta));
 a=(a_plus_b+a_minus_b)/2;
 b=a_plus_b-a;
 tan2alfa=(sin(2*theta)/((V1/V2)^2+cos(2*theta)));
 alfa=atan(tan2alfa)/2+pi/2;
 sigma_fi_kwadrat=a^2*(cos(NR+alfa))^2+b^2*(sin(NR+alfa))^2;
 sigma_lambda_kwadat=a^2*(sin(NR+alfa))^2+b^2*(cos(NR+alfa))^2;
 k_lambda_fi=(a^2-b^2)*sin(NR+alfa)*cos(NR+alfa);
 k_fi_lamdna=(a^2-b^2)*sin(NR+alfa)*cos(NR+alfa);
P(1,1)=sigma_fi_kwadrat; P(1,2)=k_fi_lamdna;
P(2,1)=k_lambda_fi; P(2,2)=sigma_lambda_kwadat;
%Sy=[cos(y) sin(y)];
%blad_y=Sy*P*Sy';
PP(i).kow_d(1,1)=P(1,1);
PP(i).kow_d(1,2)=P(1,2);
PP(i).kow_d(2,1)=P(2,1);
PP(i).kow_d(2,2)=P(2,2);
mu(1)=data(1,i); mu(2)=data(2,i);
p=0.95;
%plotErrorEllipse(mu,P,p, 'blue');
end

end