function [cw, poprawka]= cwiartka(x0,y0,x1,y1)

if((x0<=x1)&&(y0<=y1))
    cw=1;
    poprawka = -90;
end
if((x0>=x1)&&(y0<=y1))
    cw=2;
      poprawka = 270;
end
if((x0>=x1)&&(y0>=y1))
    cw=3;
      poprawka = 270;
end
if((x0<=x1)&&(y0>=y1))
    cw=4;
    poprawka = 270;
end
end