function stan_wynikowy = symulacja_automatu_rozmytego(wektor, macierz_przejsc)
%SYMULACJA_AUTOMATU symulacja pracy automatu, mnozenie macierzy i
%wypisywanie wynikowego stanu


% wektor - to wektor ze zbioru uczacego w postaci np [0.3  0.7  0.5  ... ]
% w przeciwienstwie do poprzedniego etapu nie ma scisle okreslonej
% przynaleznosci do klasy dlatego takie wartosci
%%pierwszy stan bedzie wektorem o wartosciach 
%losowych z przedzialu od 0 do 1 (jest to wektor stopni pewnosci)
pop_stan = rand(size(macierz_przejsc, 1), 1);
nast_stan = pop_stan;
syms x
f(x)=tanh(x);
g=finverse(f);

wektor_minimum=zeros(length(pop_stan));
%% na razie zakladam ze nadal dzielimyzbior testowy na podprzedzialy
%% i ma on postac liczb calkowitych 
for i = 1 : length(wektor)
    %mnozenie (max-min) macierzy przejsc *  stan
    for j = 1 :length(nast_stan)
        
       for k = 1: length(nast_stan)
        minimum(k) = 1- g(tanh(1-macierz_przejsc(j, k,wektor(i)))+tanh(1-pop_stan(k)));  
       end
       % 
       for m = 1: length(minimum)
        wektor_minimum(1,m)=tanh(minimum(1,m));
       end
     suma_min=sum(wektor_minimum(1,:));
        max(j) = g(suma_min); 
        nast_stan(j)=max(j);
    end     
    pop_stan = nast_stan;
end

stan_wynikowy = nast_stan;

end