clear all 
close all
load('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\dane\wiecej_iter_ok.mat')

x1k(:,:)=icp1k(:,1,:);
k=1;
w=1;
g=1
for i=1:(476*100)
   
    x3k_all(i)=icp3k(w,1,k);
    y3k_all(i)=icp3k(w,2,k);
    k=k+1; w=w+1;
  if w > 100;
   w=1;
  end
  if k > 476
      k=1;
  end
end

cov=cov(x3k_all,y3k_all);
cov(1,2)*100;






C=[16,0.01;0.01 9]
D=[1 3]
sigma2=D*C*D'