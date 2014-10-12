function matrix = generate_automat(zbior_uczacy,liczba_symboli,liczba_podzialow)

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
        normalized(i,j) = zbior_uczacy(i,j)/maxim;
    end
end
%%display normalized
normalized
%podzial na podprzedzialy A1,...,An

n=size(zbior_uczacy);
tablica_symboli = zeros(n(1),n(2));
ulamek = 1/liczba_podzialow;

for wiersz = 1:n(1)
    for kolumna = 1:n(2)
         for iter=0:liczba_podzialow
            if(normalized(wiersz,kolumna)<(iter+1)*ulamek && normalized(wiersz,kolumna)>= iter*ulamek)
                tablica_symboli(wiersz,kolumna) = iter;
            end
         end
    end
end

% lososwanie funkcji przejscia
% za stan poczatkowy uznaje [1 0 0 0 0 ...0]
% skoro losowa  - to moge wziac diagonalna - najprosciej :p
funk_przejscia = diag(liczba_symboli,liczba_symboli);
stan_poczatkowy = zeros(1,liczba_symboli);
stan_poczatkowy(1) = 1;




matrix = zeros(liczba_symboli,liczba_symboli);


end