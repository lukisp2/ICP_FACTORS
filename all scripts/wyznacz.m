function [procent, ktory]=wyznacz(zmienna, parametr)


cykl=0;
anty_cykl=0;
for i=1:length(zmienna)
   if zmienna(1,i)>=parametr 
    cykl=cykl+1;
   else
       cykl=cykl+1;
       break
   end
end
ktory=cykl*2+100;

cykl=0;

for i=1:length(zmienna)
if zmienna(1,i)<=parametr 
    anty_cykl=anty_cykl+1;
end



procent = (anty_cykl/451)*100;

end
