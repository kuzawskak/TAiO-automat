function [macierz] = generuj_macierz(macierz)
% GENERUJ_MACIERZ modyfikuje macierz zwracana przez funkcje PSO w sposob zalezny 
% od automatu, dla determistycznego wybiera maksymalna wartosc w kolumnie
% i w jej miejsce wstawia 1, natomiast reszta wartosci w danej kolumnie to 0;
% dla niedetermistycznego wybiera maksymalnie k najwiekszych wartosci w kolumnie
%(k to podane przy wywolaniu ograniczenie automatu % niedetermistycznego) 
% i w ich miejsce wstawia 1, reszta to 0; dla automatu iedetermistycznego;
% dla rozmytego nie ma dyskretyzacji, elementy macierzy sa losowe

global rodzaj_automatu;
global dyskretyzacja;
global liczba_wierszy;
global ograniczenie_automatu_niedet;
global liczba_symboli;

ograniczenie=ceil((ograniczenie_automatu_niedet*liczba_symboli)/100);
liczba_stron=dyskretyzacja;

if(rodzaj_automatu == 1) % Deterministyczny
  for i = 1 : liczba_stron
      for j = 1 : liczba_wierszy
          maxx = max(macierz(:, j, i));
          for k = 1 : liczba_wierszy
              if(macierz(k, j, i) == maxx)
                  macierz(k, j, i) = 1;
              else
                  macierz(k, j, i) = 0;
              end
          end
      end
  end
elseif(rodzaj_automatu == 2) % Niedeterministyczny
  for i = 1 : liczba_stron
      for j = 1 : liczba_wierszy
          p = randi(ograniczenie + 1);
          [~, sortingIndices] = sort(macierz(:, j, i), 'descend');
          sortingIndices = sortingIndices(1 : p);
          for k = 1 : liczba_wierszy
              if(any(sortingIndices == k) == 1)
                  macierz(k, j, i) = 1;
              else
                  macierz(k, j, i) = 0;
              end
          end
      end
  end
elseif(rodzaj_automatu == 3)% Rozmyty
    macierz = rand(liczba_wierszy, liczba_wierszy, liczba_stron);
end

end
