function symbol = find_symbol(vector_index, liczba_symboli, liczba_kopii)
%FIND_SYMBOL znajduje jaki symbol jest reprezentowany przez dany wektor

for i = 1 : liczba_symboli
    if (vector_index <= i * liczba_kopii)
        symbol = i;
        break;
    end
end

end

