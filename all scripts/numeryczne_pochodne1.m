function cov=numeryczne_pochodne(data1,model,vi,TT,TR,sigma_odl,sigma_KK,cov_z,wghs);

%% These are the interval to approximate the derivatives with the increments.
eps_xy = 0.0001;
eps_t = deg2rad(0.01);
%% Zmienne
Gtot = [0;0;0];
G2tot = zeros(3,3);
%% P�tla
for i=1:length(data1-1)
%% Zmienne 
x=TT(1,1);
y=TT(2,1);
cos_theta= TR(1,1);
sin_theta=TR(2,1);
 if cos_theta >=0 && sin_theta >=0
    theta=rad2deg(acos(cos_theta));
 else
    theta=-1*rad2deg(acos(cos_theta));
 end
theta = deg2rad(theta);  %% Sprawdzi� czy dzia�a 12.05.2019r!!!

xp = data1(1,i); % punkty z daty
yp = data1(2,i);
       
xq = model(1,vi(i,1)); % punkty z modelu
yq = model(2,vi(i,1)); 

R=[cos(theta) -sin(theta); sin(theta) cos(theta)];

%% Funkcja celu 
E=@(xp_,yp_,xq_,yq_,x_,y_,theta_)...
    wghs(i,1)*norm([cos(theta_) -sin(theta_); sin(theta_) cos(theta_)]*[xp_;yp_]+[x_;y_]-[xq_; yq_])^2;
%% Pierwsza pochodna
gradEk = @(xp_,yp_,xq_,yq_,x_,y_,theta_) ...
			 [deriv(@(xx)E(xp_,yp_,xq_,yq_,xx,y_,theta_), x_, eps_xy); ...
			  deriv(@(yy)E(xp_,yp_,xq_,yq_,x_,yy,theta_), y_, eps_xy); ...
			  deriv(@(tt)E(xp_,yp_,xq_,yq_,x_,y_,tt), theta_, eps_t)];
			
%% Druga pochodna 
d2Ek_dx2 = @(xp_,yp_,xq_,yq_,x_,y_,theta_) ...
			 [deriv(@(xx)gradEk(xp_,yp_,xq_,yq_,xx,y_,theta_), x_, eps_xy) ...
			  deriv(@(yy)gradEk(xp_,yp_,xq_,yq_,x_,yy,theta_), y_, eps_xy) ...
			  deriv(@(tt)gradEk(xp_,yp_,xq_,yq_,x_,y_,tt), theta_, eps_t)];
          
%% Obliczenia pochodnych %608392893
A= gradEk(xp,yp,xq,yq,x,y,theta);	

Gtot = Gtot+ gradEk(xp,yp,xq,yq,x,y,theta);	
G2tot = G2tot+ d2Ek_dx2(xp,yp,xq,yq,x,y,theta);

d2Ek_dxdxxp = @(xp_,yp_,xq_,yq_,x_,y_,theta_) ...
			deriv(@(xxp)gradEk(xxp,yp_,xq_,yq_,x_,y_,theta_), xp_, eps_xy);
d2Ek_dxdyyp = @(xp_,yp_,xq_,yq_,x_,y_,theta_) ...
			deriv(@(yyp)gradEk(xp_,yyp,xq_,yq_,x_,y_,theta_), yp_, eps_xy);
d2Ek_dxdxxq = @(xp_,yp_,xq_,yq_,x_,y_,theta_) ...
			deriv(@(xxq)gradEk(xp_,yp_,xxq,yq_,x_,y_,theta_), xq_, eps_xy);
d2Ek_dxdyyq = @(xp_,yp_,xq_,yq_,x_,y_,theta_) ...
			deriv(@(yyq)gradEk(xp_,yp_,xq_,yyq,x_,y_,theta_), yp_, eps_xy);    
  
        
 dxp=d2Ek_dxdxxp(xp,yp,xq,yq,x,y,theta);
 dyp=d2Ek_dxdyyp(xp,yp,xq,yq,x,y,theta);
 dxq=d2Ek_dxdxxq(xp,yp,xq,yq,x,y,theta);
 dyq=d2Ek_dxdyyq(xp,yp,xq,yq,x,y,theta);
 
term_2(1,2*i-1)=dxp(1,1);
term_2(2,2*i-1)=dxp(2,1);
term_2(3,2*i-1)=dxp(3,1);

term_2(1,2*i-0)=dyp(1,1);
term_2(2,2*i-0)=dyp(2,1);
term_2(3,2*i-0)=dyp(3,1);

term_2(1,2*i-1+2*length(data1))=dxq(1,1);
term_2(2,2*i-1+2*length(data1))=dxq(2,1);
term_2(3,2*i-1+2*length(data1))=dxq(3,1);

term_2(1,2*i+2*length(data1))=dyq(1,1);
term_2(2,2*i+2*length(data1))=dyq(2,1);
term_2(3,2*i+2*length(data1))=dyq(3,1);
 
 %{
term_2(1,4*i-3)=dxp(1,1);
term_2(2,4*i-3)=dxp(2,1);
term_2(3,4*i-3)=dxp(3,1);

term_2(1,4*i-2)=dyp(1,1);
term_2(2,4*i-2)=dyp(2,1);
term_2(3,4*i-2)=dyp(3,1);

term_2(1,4*i-1)=dxq(1,1);
term_2(2,4*i-1)=dxq(2,1);
term_2(3,4*i-1)=dxq(3,1);

term_2(1,4*i)=dyq(1,1);
term_2(2,4*i)=dyq(2,1);
term_2(3,4*i)=dyq(3,1);
%}

end
%%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%G2tot=[289.0012916 0.989704144	162.1884798;
%0.989704144	78.99871601	262.9611212;
%162.1884798	262.9611212	2946.179384]
%term2=load('censi2.mat','AA');
%%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

cov=inv(G2tot)*term_2*cov_z*(term_2')*inv(G2tot);
%cov=((term_1)^-1)*term_2*term_kow*(term_2')*((term_1)^-1);
