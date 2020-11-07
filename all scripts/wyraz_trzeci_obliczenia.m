function term_kow = wyraz_trzeci_obliczenia(data,data1,model,vi,TT,TR,sigma_odl,sigma_KK)
%data1 to data przed zmian¹, model nie jest zmieniany
format long
w=length(data1);
for i=1:w
    r_data1(i,1)=sqrt(data1(1,i)^2+data1(2,i)^2);
    a_data1(i,1)=atan2(data1(2,i),data1(1,i));
    if a_data1(i,1)<0
        a_data1(i,1)=a_data1(i,1)+2*pi;
    end
    r_model(i,1)=sqrt(model(1,i)^2+model(2,i)^2);    
    a_model(i,1)=atan2(model(2,i),model(1,i));
        if a_model(i,1)<0
        a_model(i,1)=a_model(i,1)+2*pi;
    end
end
wymiar=4*length(data);
cov_z=zeros(wymiar);
sigma_odl=sigma_odl;
sigma_kk=(sigma_KK); % chyba sigma_KK sie zjeba³o
C=[sigma_odl^2 0;
    0 sigma_kk^2];
k=0; z=2*length(data);
for i=1:length(data) %% i równe jest iloœci powi¹zañ 
    %P -data x
        %P - data y
            %Q - model (vi) x
                  %Q... model (vi) y
                               
     ang= a_data1(i,1);
     r=r_data1(i,1);
    
     D=[cos(ang) -r*sin(ang);
    sin(ang) r*cos(ang);];          
    Cx=D*C*D' ;
   %{ 
    cov_z(i+k,i+k)=Cx(1,1); %% 
    cov_z(i+k,i+1+k)=Cx(1,2);
    cov_z(i+1+k,i+k)=Cx(2,1);
    cov_z(i+1+k,i+1+k)=Cx(2,2); %% 
    %}
  
     
    %%$$$$$$$$$$$$$
    cov_z(i+k,i+k)=Cx(2,2); %%% tu zmieni³em 22.09 wczesniej by³o (1,1)
    cov_z(i+k,i+1+k)=Cx(1,2);
    cov_z(i+1+k,i+k)=Cx(2,1);
    cov_z(i+1+k,i+1+k)=Cx(1,1); %%% tu zmieni³em 22.09 wczesniej by³o (2,2)
    k=k+1;
    %%$$$$$$$$$$$$$
     
  %  scatter(r*cos(ang),r*sin(ang));
  %  mu(1)=r*cos(ang)
  %  mu(2)=r*sin(ang)
   % Sigma=Cx;
  %  p=0.90;
  %  skala=5;
  %  kolor ='blue';
  %  plotErrorEllipse(mu, Sigma, p, kolor,skala)
    
    
    ang=a_model(vi(i,1),1);
    r=r_model(vi(i,1),1);    
    D=[cos(ang) -r*sin(ang);
    sin(ang) r*cos(ang);];           
    Cx=D*C*D' ;
  %{
    k=k+2;
    cov_z(i+k,i+k)=Cx(1,1); %%
    cov_z(i+k,i+1+k)=Cx(1,2);
    cov_z(i+1+k,i+k)=Cx(2,1);
    cov_z(i+1+k,i+1+k)=Cx(2,2); %% 
    k=k+1;
  %}
    %%$$$$$$$$$$$$
    
    cov_z(i+z,i+z)=Cx(2,2); %%% tu zmieni³em 22.09 wczesniej by³o (1,1)
    cov_z(i+z,i+1+z)=Cx(1,2);
    cov_z(i+1+z,i+z)=Cx(2,1);
    cov_z(i+1+z,i+1+z)=Cx(1,1); %%% tu zmieni³em 22.09 wczesniej by³o (2,2)
    z=z+1;
    
   %%$$$$$$$$$$$$ 
end
term_kow=cov_z;