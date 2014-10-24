function blad = uzyj_zbioru_testowego(count, matrix_of_transitions, vector_of_symbols)
%USE_TESTING_DATASET funkcja uzywa zbudowanego automatu do testowania
%symboli ze zbioru testowego(=wylosowanych wartosci ze zbioru uczacego)

global zbior_uczacy
global liczba_kopii
global liczba_wierszy

blad=0;
temp_vector= randperm(size(zbior_uczacy,1),count)

for i=1:count,
    x=znajdz_symbol(temp_vector(i),liczba_wierszy,liczba_kopii);
    disp(sprintf('%d Testowano symbol: %c',i, vector_of_symbols(x)))
    wynik=symulacja_automatu( zbior_uczacy(temp_vector(i),:), matrix_of_transitions );
    disp(sprintf('Otrzymano symbol: %c',  vector_of_symbols(wynik)))
    if(x~=wynik)
        blad=blad+1;
    end
end

end

