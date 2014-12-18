function TAIO2014( varargin )
% %TAIO2014 - funkcja uruchamiaj¹ca program
% 
global typ_wejscia;
global sciezka_zbior_uczacy;
global sciezka_zbior_testujacy;
global sciezka_plik_wynikowy;
global sciezka_plik_dodatkowy;
global rozmiar_zb_testowy;
global dyskretyzacja;
global liczba_rojow;
global liczba_iteracji;
global liczba_symboli;
global max_wartosc;
global min_wartosc;
global wariancja;
global liczba_kopii;
global rodzaj_automatu;
global ograniczenie_automatu_niedet;
global liczba_st_odrzucajacych;
global czy_odrzucanie;
global liczba_cech;
global ile_procent_symboli_obcych;

if(length(varargin)<3)
    disp('Niepoprawna ilosc obowiazkowych argumentow')
else
    for i=1:length(varargin)
        switch varargin{i}
            case {'etap'}
                switch varargin{i+1}
                    case{'a1'}
                        rodzaj_automatu=1;
                        ile_procent_symboli_obcych=0;
                        czy_odrzucanie=-1;
                        liczba_st_odrzucajacych = 0;
                    case{'a2'}
                        rodzaj_automatu=1;
                        czy_odrzucanie=0;
                        liczba_st_odrzucajacych=1;
                    case{'a3'}
                        rodzaj_automatu=2;
                        ile_procent_symboli_obcych=0;
                        czy_odrzucanie=-1;
                        liczba_st_odrzucajacych = 0;
                    case{'a4'}
                        rodzaj_automatu=2;
                        czy_odrzucanie=0;
                        liczba_st_odrzucajacych=1;
                    case{'a5'}
                        rodzaj_automatu=3;
                        ile_procent_symboli_obcych=0;
                        czy_odrzucanie=-1;
                        liczba_st_odrzucajacych = 0;
                    case{'a6'}
                        rodzaj_automatu=3;
                        czy_odrzucanie=0;
                        liczba_st_odrzucajacych=1;
                end
            case'wejscieTyp'
                switch varargin{i+1}
                    case{'gen'}
                      typ_wejscia=-1;
                    case{'czyt'}
                        typ_wejscia=0;
                end
            case'sciezkaTrain'
                sciezka_zbior_uczacy=varargin(i+1);
            case{'sciezkaTest'}
                sciezka_zbior_testujacy=varargin(i+1);
            case{'sciezkaOutputClass'}
                sciezka_plik_wynikowy=varargin(i+1);
            case{'sciezkaOutputR'}
                sciezka_plik_dodatkowy=varargin(i+1);
            case{'iloscKlas'}
                liczba_symboli=cell2mat(varargin(i+1));
            case{'iloscCech'}
                liczba_cech=cell2mat(varargin(i+1));
            case{'iloscPowtorzenWKlasie'}
                liczba_kopii=cell2mat(varargin(i+1));
            case{'minLos'}
                min_wartosc=cell2mat(varargin(i+1));
            case{'maxLos'}
                max_wartosc=cell2mat(varargin(i+1));
            case{'zaburzenie'}
                wariancja=cell2mat(varargin(i+1));
            case{'procRozmTest'}
                rozmiar_zb_testowy=cell2mat(varargin(i+1));
            case{'procRozmObce'}
                ile_procent_symboli_obcych=cell2mat(varargin(i+1));
            case{'procRozmZaburz'}
            case{'dyskretyzacja'}
                dyskretyzacja=cell2mat(varargin(i+1));
            case{'ograniczNietermin'}
                ograniczenie_automatu_niedet=cell2mat(varargin(i+1));
            case{'rownolegle'}
            case{'PSOiter'}
                liczba_iteracji=cell2mat(varargin(i+1));
            case{'PSOs'}
                liczba_rojow=cell2mat(varargin(i+1));
            case{'PSOk'}
            case{'PSOp'}
        end
    end
end



 typ_wejscia
 sciezka_zbior_uczacy
 sciezka_zbior_testujacy
 sciezka_plik_wynikowy
 sciezka_plik_dodatkowy
 rozmiar_zb_testowy
 dyskretyzacja
 liczba_rojow
 liczba_iteracji
 liczba_symboli
 max_wartosc
 min_wartosc
 wariancja
 liczba_kopii
 rodzaj_automatu
 ograniczenie_automatu_niedet
 liczba_st_odrzucajacych
 czy_odrzucanie
 liczba_cech
 ile_procent_symboli_obcych

disp('koniec switcha');

main();

end
