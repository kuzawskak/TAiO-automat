function stan_wynikowy = symulacja_automatu_rozmytego(wektor, macierz_przejsc)
%SYMULACJA_AUTOMATU symulacja pracy automatu, mnozenie macierzy i
%wypisywanie wynikowego stanu
global liczba_cech;

% wektor - to wektor ze zbioru uczacego w postaci np [0.3  0.7  0.5  ... ]
% w przeciwienstwie do poprzedniego etapu nie ma scisle okreslonej
% przynaleznosci do klasy dlatego takie wartosci
%%pierwszy stan bedzie wektorem o wartosciach 
%losowych z przedzialu od 0 do 1 (jest to wektor stopni pewnosci)
pop_stan = rand(size(macierz_przejsc, 1), 1);
nast_stan = pop_stan;

konfiguracja_koncowa_stron=zeros(size(nast_stan,1),liczba_cech);
 konfiguracje_ze_st_przynaleznosci=zeros(size(nast_stan,1),liczba_cech);
stopien_przynaleznosci_do_strony = zeros(size(macierz_przejsc,1),liczba_cech);
for i=1: size(stopien_przynaleznosci_do_strony,2)
    stopien_przynaleznosci_do_strony(:,i) = wektor(i);
end   

wektor_minimum=zeros(length(pop_stan));
%% na razie zakladam ze nadal dzielimyzbior testowy na podprzedzialy
%% i ma on postac liczb calkowitych 
for i = 1 : (length(wektor)/liczba_cech)
    
 for strona = 1: liczba_cech
    %mnozenie (max-min) macierzy przejsc *  stan
    for j = 1 :length(nast_stan)        
       for k = 1: length(nast_stan)
        minimum(k) = 1- tanh(atanh(1-macierz_przejsc(j, k,strona))+atanh(1-pop_stan(k)));  
       end
       % 
       for m = 1: length(minimum)
        wektor_minimum(1,m)=atanh(minimum(1,m));
       end
        suma_min=sum(wektor_minimum(1,:));
        max(j) = tanh(suma_min); 
        %otzrymuje konf koncowa dla strony s
        nast_stan(j)=max(j);
    end 
   
    konfiguracja_koncowa_stron(:,strona)=nast_stan';
    
    konfiguracje_ze_st_przynaleznosci(:,strona)=1-tanh(atanh(1-stopien_przynaleznosci_do_strony(:,strona))+...
        atanh(1-konfiguracja_koncowa_stron(:,strona)));
 end
%agrguje wyniki ze wszytkich stron zeby uzyskac nast_stan

a=atanh(konfiguracje_ze_st_przynaleznosci);
suma_stopni = sum(a,2);
nast_stan=tanh(suma_stopni);

pop_stan = nast_stan;
end


stan_wynikowy = nast_stan;
end

