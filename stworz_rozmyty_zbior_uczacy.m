function [gotowy_zbior] = stworz_rozmyty_zbior_uczacy(csvfile, liczba_symboli, ...
    liczba_cech, liczba_kopii,dyskretyzacja,srednia, wariancja,czy_plik)
%STWORZ_ROZMYTY_ZBIOR_UCZACY generuje dane do zbioru ucz¹cego automatu rozmytego,
%zwiêksza ich iloœæ przez rozk³ad normalny, normalizuje i dzieli na przedzialy

%Funkcja zwraca gotowy zbior uczacy, w zaleznosci od funkcji, zawieraj¹cy
%elementy obce lub nie
global sciezka_obce_zbior_uczacy
global ile_procent_symboli_obcych

ile_symboli_obcych=(ile_procent_symboli_obcych*liczba_symboli * liczba_kopii) / 100;

if(czy_plik==0)
    % macierz danych wejsciowych
    zbior_uczacy=csvfile;
else
    dane_wejsciowe = csvread(csvfile, 0, 1);
    %rozszerzamy macierz do zbioru uczacego - bedzie x razy wieksza, gdzie x = liczba_kopii
    zbior_uczacy = zeros(liczba_kopii * liczba_symboli + ile_symboli_obcych, liczba_cech);
    
    for i = 0 : liczba_symboli
        zbior_uczacy(i * liczba_kopii + 1) = dane_wejsciowe(i + 1);
    end
    % generowanie szumu rozkladem normalnym
    
    for i = 0 : liczba_symboli - 1
        for powt = 2 : liczba_kopii
            for cecha = 1 : liczba_cech
                zbior_uczacy(i * liczba_kopii + powt, cecha) = ...
                    dane_wejsciowe(i + 1, cecha) + abs(rozklad_normalny(srednia, wariancja));
            end
        end
    end
    
end

if(ile_procent_symboli_obcych ~= 0)
    if(sciezka_obce_zbior_uczacy == '_')
        %generowanie elementow obcych przez permutacje losowych wektorow
        tmp_wektor = randperm(size(zbior_uczacy, 1) - ile_symboli_obcych, ile_symboli_obcych);
        for i = 1 : length(tmp_wektor)
            ind = randperm(liczba_cech);
            for j = 1 : liczba_cech
                zbior_uczacy(size(zbior_uczacy, 1) - ile_symboli_obcych + i, j) = zbior_uczacy(tmp_wektor(i), ind(j));
            end
        end
    else
        [zbior_obcych,str]=xlsread(sciezka_obce_zbior_uczacy);
        zbior_uczacy=vertcat(zbior_uczacy,zbior_obcych);
    end
end

%normalizacja
maxim = 0;
for i = 1 : size(zbior_uczacy, 1)
    vec = zbior_uczacy(i,:);
    
    m = max(vec);
    if(m > maxim)
        maxim = m;
    end
end

for i = 1 : size(zbior_uczacy, 1)
    for j = 1 : size(zbior_uczacy, 2)
        zbior_uczacy(i, j) = zbior_uczacy(i, j) / maxim;
    end
end

% podzial na podprzedzialy A1,...,An modyfikujemy
% w ten sposob ze tworzymy wektory dlugosci n*stara_dlugosc
n = size(zbior_uczacy);
gotowy_zbior = ones(n(1),n(2)*dyskretyzacja);
ulamek = 1/dyskretyzacja;
srodek = ulamek/2;

%tworzymy inna funkcje gaussowska dla kazdego przedzialu, wybierajac jako
%argument x0 srodek tego przedzialu
for wiersz = 1:n(1)
    for kolumna = 1 : n(2)
        for iter = 1 : dyskretyzacja
            % if(zbior_uczacy(wiersz, kolumna) < iter * ulamek ...
            %         && zbior_uczacy(wiersz, kolumna) >= (iter - 1) * ulamek)
            x0= (iter-1) * ulamek + srodek;
            funkcja_gaussowska = @(x)  exp(-((x-x0)*(x-x0)));
            gotowy_zbior(wiersz, kolumna+iter) = funkcja_gaussowska(zbior_uczacy(wiersz, kolumna));
        end
    end
end

end




