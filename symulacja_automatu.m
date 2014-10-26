function symbol = symulacja_automatu( wektor, macierz_przejsc )
%SYMULACJA_AUTOMATU symulacja pracy automatu, mnozenie macierzy i
%wypisywanie wynikowego stanu, na koniec znajdowany jest indeks jedynki w
%wektorze, potrzebny do zmapowania symbolu

pop_stan = zeros(size(macierz_przejsc,1),1);
pop_stan(1) = 1;
nast_stan = pop_stan;

for i = 1 : length(wektor)
    %Narazie zwykle mnozenie, bo dla 0 i 1 to bedzie dzialac, potem trzeba dac wzor od Homendy
    nast_stan = macierz_przejsc(:,:,wektor(i))*pop_stan;
    pop_stan = nast_stan;
end

symbol = find(nast_stan);
end
