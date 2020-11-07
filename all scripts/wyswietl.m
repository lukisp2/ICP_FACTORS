 function wyswietl(A,B,best,i,wys)
 
  V=best(i).V_WSP;
   figure(2)
  imshow(A);
   pause(1);
  imshow(B);
   pause(1);
  B=imtranslate(B,[0 V]);
  a=best(i).COG;
  B=imrotate(B,a,'bicubic','crop');
  imshow(B);
   pause(1);
  C=A*0.5+B;
  imshow(C);
   pause(2);
  disp("numer skanu:" + i);
  disp("predkosc wsp:" + V/((wys/2)/40));
  disp("delta cog:" +best(i).COG);
  pause(2);
  close;
 
   end