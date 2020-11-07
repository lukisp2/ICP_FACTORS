function cov = icpcov(data,data1,model,vi,TT,TR,sigma_odl,sigma_KK,wghs,rodzaj)
global kowariancja_numer;
TT_kopia=TT;
TT(1,1)=TT_kopia(2,1);
TT(2,1)=TT_kopia(1,1);

term_1=wyraz_pierwszy_obliczenia(data1,model,vi,TT,TR);  %d2J/dx2
term_2=wyraz_drugi_obliczenia(data1,model,vi,TT,TR); %d2J/dzdx
term_kow=wyraz_trzeci_obliczenia1(data1,data1,model,vi,TT,TR,sigma_odl,sigma_KK); %cov(z), data1 czyli data przed zmian¹ wsp. przez algorytm
%term_kow=eye(length(term_kow))*0.01;
cov=((term_1)^-1)*term_2*term_kow*(term_2')*((term_1)^-1);



if rodzaj == 2
kow_num=numeryczne_pochodne(data1,model,vi,TT,TR,sigma_odl,sigma_KK,term_kow,wghs);
cov=kow_num;
global kowariancja_zapis
kowariancja_zapis(:,:,kowariancja_numer)=cov;

if kowariancja_numer == 1500
save('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\doktorat\symulacja_duza\dane\500_kow_kwadrat.mat','kowariancja_zapis');
end
kowariancja_numer=kowariancja_numer+1;
end
end