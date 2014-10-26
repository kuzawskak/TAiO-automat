function symbol = znajdz_symbol(indeks, liczba_symboli, liczba_kopii)
%ZNAJDZ_SYMBOL - znajduje jaki symbol jest reprezentowany przez dany wektor

for i = 1 : liczba_symboli
    if (indeks <= i * liczba_kopii)
        symbol = i;
        break;
    end
end

end

