function wynik = znajdz_symbol_obcy( wektor_sym )
%ZNAJDZ_SYMBOL_OBCY sprawdza, czy symbol reprezentowany przez 
%wektor wektor_sym zostal odrzucony przez automat
%Funkcja zwraca 1, jeœli symbol zosta³ odrzucony lub -1 w przeciwnym
%przypadku.

wynik = -1;
global liczba_st_odrzucajacych;
if(liczba_st_odrzucajacych>0)
    for i=length(wektor_sym)- liczba_st_odrzucajacych + 1 : length(wektor_sym)
        if(wektor_sym(i) == 1)
            wynik = 1;
            break;
        end
    end
end

end

