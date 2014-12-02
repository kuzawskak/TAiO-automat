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




%% na razie zakladam ze nadal dzielimyzbior testowy na podprzedzialy
%% i ma on postac liczb calkowitych 
for i = 1 : (length(wektor)/liczba_cech)
    
 for strona = 1: liczba_cech
    %mnozenie (max-min) macierzy przejsc *  stan
    for j = 1 :length(nast_stan)        
       for k = 1: length(nast_stan)
        z_minimum(k) = minimum(macierz_przejsc(j, k,strona),pop_stan(k));
       end
       
       max(j)=maximum(z_minimum(1,1),z_minimum(1,2));
       for loop=3: size(z_minimum,2)       
            max(j)=maximum(z_minimum(1,loop),max(j)) ;          
       end
                  
        %otzrymuje konf koncowa dla strony s
        nast_stan(j)=max(j);
    end 
   
    konfiguracja_koncowa_stron(:,strona)=nast_stan';    
    konfiguracje_ze_st_przynaleznosci(:,strona)=...
    minimum(stopien_przynaleznosci_do_strony(:,strona),konfiguracja_koncowa_stron(:,strona));

 end
%agrguje wyniki ze wszytkich stron zeby uzyskac nast_stan
maxss=maximum(konfiguracje_ze_st_przynaleznosci(:,1),konfiguracje_ze_st_przynaleznosci(:,2));
        for loop=3: size(konfiguracje_ze_st_przynaleznosci,2)      
            maxss=maximum(konfiguracje_ze_st_przynaleznosci(:,loop),maxss) ;
        end           
        %otzrymuje konf koncowa dla wszytkich stron
nast_stan=maxss;
pop_stan = nast_stan;
end
stan_wynikowy = nast_stan;
end

