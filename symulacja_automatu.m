function symbol = symulacja_automatu(wektor, macierz_przejsc)
%SYMULACJA_AUTOMATU symulacja pracy automatu, mnozenie macierzy i
%wypisywanie wynikowego stanu, na koniec znajdowany jest indeks jedynki w
%wektorze, potrzebny do zmapowania symbolu

pop_stan = zeros(size(macierz_przejsc, 1), 1);
pop_stan(1) = 1;
nast_stan = pop_stan;

for k = 1 : length(wektor)
    nast_stan = max(min(macierz_przejsc(k, :, wektor(i)), pop_stan'));
    pop_stan = nast_stan;
end

symbol = find(nast_stan);
end
