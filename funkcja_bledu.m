%macierz funkcji jest 3-wymiarowa
%stan wejsciowy to wektor dlugosci liczba_podzialow_na _podprzedzialy
%%napewno zle
%%
function blad = funkcja_bledu(macierz_funkcji,stan_wejsciowy)
blad = 0;
n=-1;
dl_wektora = dim(size(slowo),1);
for i=1:dl_wektora
    if(stan_wejsciowy(i)==1)
        n=i;
    end
end

st_wy = macierz_funkcji(n)* stan_wejsciowy;
%blad liczymy jako sume miejsc na ktorych sie rozni stan odczytany 



end

%'mnozenie' macierzy i wektora
function stan_wynikowy = przejscie_automatu(strona_macierzy,obecny_stan)

stan_wynikowy=strona_macierzy*obecny_stan
%TO DO zrobic mnozenie macierzy w petli
%for i=1:size(strona_macierzy,1)
 %   for j=1:size(strona_macierzy,2)
    
end