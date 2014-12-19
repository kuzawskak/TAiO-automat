function [macierz] = generuj_macierz(macierz)
% Generuje macierz o podanych wymiarach x, y, liczba_stron w zale¿noœci
% od rodzaju automatu

global rodzaj_automatu;
global dyskretyzacja;
global liczba_wierszy;
global ograniczenie_automatu_niedet;
global liczba_symboli;

ograniczenie=(ograniczenie_automatu_niedet*liczba_symboli)/100;
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
          p = randi(ograniczenie + 1) - 1;
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
