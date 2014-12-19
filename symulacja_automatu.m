function stan_wynikowy = symulacja_automatu(wektor, macierz_przejsc)
%SYMULACJA_AUTOMATU symulacja pracy automatu, mnozenie macierzy i
%wypisywanie wynikowego stanu

global rodzaj_automatu;

if(rodzaj_automatu==1)
    pop_stan = zeros(size(macierz_przejsc, 1), 1);
    pop_stan(1) = 1;
    nast_stan = pop_stan;
    
    for i = 1 : length(wektor)
        nast_stan = macierz_przejsc(:, :, wektor(i)) * pop_stan;
        pop_stan = nast_stan;
    end
else
    pop_stan = zeros(size(macierz_przejsc, 1), 1);
    pop_stan(1) = 1;
    nast_stan = pop_stan;
    
    for i = 1 : length(wektor)
        for j = 1 :length(nast_stan)
            nast_stan(j) = max(min(macierz_przejsc(j, :, wektor(i)), pop_stan'));
        end
        pop_stan = nast_stan;
    end
end

stan_wynikowy = nast_stan;

end