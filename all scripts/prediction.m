 function particles= prediction(particles,pose,sn,sigma_V,sigma_K)
%Ruch z b³êdami

i=sn;
delta_x=(pose(i,1)-pose(i+1,1));
delta_y=(pose(i,2)-pose(i+1,2));
VR=sqrt(delta_x*delta_x+delta_y*delta_y);
%KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
for j=1:length(particles)
 if(i==1)
VB=VR+normrnd(0,sigma_V); 
KB=pi*1.5+normrnd(0,sigma_K);
particles(j).pose(1,1)=pose(1,1)+VB*cos(KB);
particles(j).pose(1,2)=pose(1,2)+VB*sin(KB);
particles(j).pose(1,3)=(KB);
else
 KR=atan2((pose(i-1,2)-pose(i,2)),(pose(i-1,1)-pose(i,1)))+pi;
 KR=atan2((pose(i,2)-pose(i+1,2)),(pose(i,1)-pose(i+1,1)))+pi;
 VB=VR+normrnd(0,sigma_V); 
 KB=KR+normrnd(0,sigma_K);
    
particles(j).history(1,i)=particles(j).pose(1,1);
a=particles(j).history(1,i);
particles(j).history(2,i)=particles(j).pose(1,2);
b=particles(j).history(2,i);
particles(j).history(3,i)=(particles(j).pose(1,3));
c=particles(j).history(3,i);

particles(j).pose(1,1)=particles(j).pose(1,1)+VB*cos(KB);
particles(j).pose(1,2)=particles(j).pose(1,2)+VB*sin(KB);
particles(j).pose(1,3)=(KB);
end
end
end
