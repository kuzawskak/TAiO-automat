function symbol = znajdz_symbol(indeks, liczba_symboli, liczba_kopii)
%ZNAJDZ_SYMBOL znajduje indeks symbolu, jaki reprezentowany jest przez wektor o
%indeksie "indeks" ze zbioru ucz¹cego.
%Zwraca indeks, który jest wykorzystywany w wektorze zmapowanych symboli
%lub -1 w przypadku, gdy symbol jest obcy
symbol=-1;
for i = 1 : liczba_symboli
    if (indeks <= i * liczba_kopii)
        symbol = i;
        break;
    end
end

end

