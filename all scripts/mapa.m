function map = mapa(A,B,best,i,wys,pose,map,liczba_skanow)
if i == 1
map.init_x=wys/2;
map.init_y=wys/2;
map.x_m=map.init_x;
map.y_m=map.init_y;
map.lastangm=rad2deg(pose(1,3));
    for w=1:1:wys
       for s=1:1:wys
          map.M(map.init_y+s-1,map.init_x+w-1)=A(s,w); 
       end   
    end  
end

if i>1
%map.x_m=map.x_m+best(i).V_WSP*cos(deg2rad(map.lastangm+best(i).COG));
%map.y_m=map.y_m-best(i).V_WSP*sin(deg2rad(map.lastangm+best(i).COG));
map.x_m=map.x_m+best(i).V_WSP*((wys/2)/40)*cos(deg2rad(map.lastangm+best(i).COG));
map.y_m=map.y_m-best(i).V_WSP*((wys/2)/40)*sin(deg2rad(map.lastangm+best(i).COG));
map.lastangm=map.lastangm+best(i).COG;
map.kumulacja_kata=map.kumulacja_kata+best(i).COG;
B_prim=B;
B_prim= imtranslate(B,[0 best(i).V_WSP]); 
B_prim = imrotate(B,map.kumulacja_kata,'bicubic','crop');
     for w=1:1:wys
       for s=1:1:wys
          map.M(round(map.y_m+s-1),round(map.x_m+w-1))=map.M(round(map.y_m+s-1),round(map.x_m+w-1))+B_prim(s,w); 
       end   
    end  
end   
%imshow(map.M);
%pause(0.5);
%close all;
if i==liczba_skanow-1
    imwrite(map.M,'mapa.jpg');
end
end



