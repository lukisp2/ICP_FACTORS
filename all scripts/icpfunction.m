function [RotTransMat,data,model,Cov,iteracja,czas,RES]=icpfunction(i,sigma_odl,sigma_KK,skan,rodzaj)
rodzaj = rodzaj;
cykl =1;
minIter=1000;
maxIter=10000;
% Generate model points
[w,k]=size(skan);
%new_skan=zeros(w,k);
for wi=1:(w)
    if isnan(skan(wi,i*2-1))==0
    if isnan(skan(wi,i*2-3))==0
        new_skan(cykl,1)=skan(wi,i*2-3);
        new_skan(cykl,2)=skan(wi,i*2-2);
        new_skan(cykl,3)=skan(wi,i*2-1);
        new_skan(cykl,4)=skan(wi,i*2);
        cykl=cykl+1;
    end
    end
end
cykl=cykl-1; % ten cykl wysy³am do funkcji, ¿eby wskazaæ iloœæ "wspólnych" punktów skanu

xvals=linspace(1,0.5);
yvals=2.^(xvals);
xvals=transpose(new_skan(:,1));
yvals=transpose(new_skan(:,2));
%xvals=transpose(A(:,1));
%vals=transpose(A(:,2));

model=[xvals;yvals];
for ii=1:length(model)
model_odl(1,ii)=(model(1,ii)^2+model(2,ii)^2)^0.5;
model_M(1,ii)=1/(sin(pi/2))*(((rad2deg(sigma_KK)*0.0174*model_odl(1,ii))^2+sigma_odl^2))^0.5;
end
% Generate data points
xvals=linspace(1,0.5);
yvals=2.^(xvals);
xvals=transpose(new_skan(:,3));
yvals=transpose(new_skan(:,4));
data=[xvals;yvals];
for ii=1:length(data)
data_odl(1,ii)=(data(1,ii)^2+data(2,ii)^2)^0.5;
data_M(1,ii)=(1/sin(pi/2))*(((rad2deg(sigma_KK)*(pi/180)*data_odl(1,ii))^2+sigma_odl^2))^0.5;
end
% Transform data points to their start positions

data(1,:)=data(1,:);
data(2,:)=data(2,:);


tic;
[RotMat,TransVec,dataOut,RES,TR_min,TT_min,res_min,Cov,iteracja]=icp_kierunkowy_rodzaj(model,data,20,20,rodzaj,1e-8,data_M,model_M,cykl,sigma_odl,sigma_KK);
czas=toc;


RotTransMat(i-1,1)=RotMat(1,1);
RotTransMat(i-1,2)=RotMat(2,1);
RotTransMat(i-1,3)=TransVec(1,1);
RotTransMat(i-1,4)=TransVec(2,1);
iteracja = iteracja;

% A plot. Model points and data points in transformed positions
%figure(3)
%clf(figure(1))
%%
%plot(model(1,:),model(2,:),'r.',data(1,:)+1,data(2,:)-1,'b.'), axis equal
%%
%plot(model(1,:),model(2,:),'r.',dataOut(1,:),dataOut(2,:),'b.'), axis equal
%annotation('textbox',[.9 .5 .1 .2],'String',int2str(rodzaj),'EdgeColor','none')
%pause(1);
end