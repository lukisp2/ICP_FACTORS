function map = mapa_waga(map)
suma=0;
cykl=0;
map.M2=map.M;
for s=1:length(map.M)
    for w=1:length(map.M)
    if map.M(w,s)>0
       suma=suma+map.M(w,s);
         cykl=cykl+1;
    end
    end
end
srednia = suma/cykl;
disp("srednia wartosc mapy" + srednia);


for s=1:length(map.M)
    for w=1:length(map.M)
    if map.M(w,s)<= srednia
    %   map.M(w,s)=0;
    end
    if map.M(w,s)<2.0*srednia
       map.M2(w,s)=0;
    end
    end


end
%imshow(map.M2);
%pause(2);
imwrite(map.M,'mapa_srednia.jpg');
imwrite(map.M2,'mapa_srednia5.jpg');
end