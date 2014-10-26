function [ ready_training_dataset ] = prepare_training_dataset(csvfile, liczba_symboli, liczba_cech, liczba_kopii )
%PREPARE_TRAINING_DATASET zczytujemy dane do zbioru ucz¹cego, zwiêkszamy
%ich iloœæ przez rozk³ad i normalizujemy, dzielimy na przedzialy

% macierz danych wejsciowych
dane_wejsciowe = csvread(csvfile,0,1);

%rozszerzamy macierz do zbioru uczacego - bedzie x razy wieksza, gdzie x=liczba_kopii
%zbior_uczacy = int(liczba_kopii*liczba_symboli,liczba_cech);
zbior_uczacy = zeros(liczba_kopii*liczba_symboli,liczba_cech);


for i = 0:liczba_symboli 
zbior_uczacy(i*liczba_kopii+1) = dane_wejsciowe(i+1);
end
% generowanie szumu rozkladem normalnym

for i = 0:liczba_symboli-1 
    for powt = 2:liczba_kopii    
        for cecha = 1:liczba_cech
            zbior_uczacy(i*liczba_kopii+powt,cecha) = dane_wejsciowe(i+1,cecha)+ abs(rozklad_normalny(0,3));
            % ale na razie nie wiem jak wygenerowac rozklad z paraemtrami
            % innymi niz 0 i 1
        end
    end
end

%normalizacja macierzy
maxim = 0;
for i=1:size(zbior_uczacy,1)
    vec=zbior_uczacy(i,:);
    m=max(vec);
    if(m>maxim)
        maxim = m;
    end
end

for i=1:size(zbior_uczacy,1)
    for j=1:size(zbior_uczacy,2)
        zbior_uczacy(i,j) = zbior_uczacy(i,j)/maxim;
    end
end

%podzial na podprzedzialy A1,...,An
n=size(zbior_uczacy);
ready_training_dataset = ones(n(1),n(2));
ulamek = 1/liczba_cech;

for wiersz = 1:n(1)
    for kolumna = 1:n(2)
        for iter=1:liczba_cech
            if(zbior_uczacy(wiersz,kolumna)<iter*ulamek && zbior_uczacy(wiersz,kolumna)>= (iter-1)*ulamek)
                ready_training_dataset(wiersz,kolumna) = iter;
            
            end
         end
    end
end


end

