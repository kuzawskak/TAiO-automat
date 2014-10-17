%macierz funkcji jest 3-wymiarowa
%stan wejsciowy to wektor dlugosci liczba_podzialow_na _podprzedzialy

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


