function TAIO2014( varargin )
%TAIO2014 - funkcja uruchamiaj¹ca program

global typ_wejscia;
global sciezka_zbior_uczacy;
global sciezka_zbior_testujacy;
global sciezka_plik_wynikowy;
global sciezka_plik_dodatkowy;
global sciezka_obce_zbior_uczacy;
global sciezka_obce_zbior_testujacy;
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

typ_wejscia =-1;
sciezka_zbior_testujacy='_';
sciezka_plik_wynikowy='_';
sciezka_plik_dodatkowy='_';
sciezka_obce_zbior_uczacy='_';
sciezka_obce_zbior_testujacy='_';
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
                        disp('AUTOMAT DETERMISTYCZNY BEZ ELEMENTOW OBCYCH');
                    case{'a2'}
                        rodzaj_automatu=1;
                        czy_odrzucanie=0;
                        liczba_st_odrzucajacych=1;
                        disp('AUTOMAT DETERMISTYCZNY Z ELEMENTAMI OBCYMI');
                    case{'a3'}
                        rodzaj_automatu=2;
                        ile_procent_symboli_obcych=0;
                        czy_odrzucanie=-1;
                        liczba_st_odrzucajacych = 0;
                        disp('AUTOMAT NIEDETERMISTYCZNY BEZ ELEMENTOW OBCYCH');
                    case{'a4'}
                        rodzaj_automatu=2;
                        czy_odrzucanie=0;
                        liczba_st_odrzucajacych=1;
                        disp('AUTOMAT NIEDETERMISTYCZNY Z ELEMENTAMI OBCYMI');
                    case{'a5'}
                        rodzaj_automatu=3;
                        ile_procent_symboli_obcych=0;
                        czy_odrzucanie=-1;
                        liczba_st_odrzucajacych = 0;
                        disp('AUTOMAT ROZMYTY BEZ ELEMENTOW OBCYCH');
                    case{'a6'}
                        rodzaj_automatu=3;
                        czy_odrzucanie=0;
                        liczba_st_odrzucajacych=1;
                        disp('AUTOMAT ROZMYTY Z ELEMENTAMI OBCYMI');
                end
            case'wejscieTyp'
                switch varargin{i+1}
                    case{'gen'}
                        typ_wejscia=-1;
                    case{'czyt'}
                        typ_wejscia=0;
                end
            case'sciezkaTrain'
                if(typ_wejscia==0)
                    sciezka_zbior_uczacy=varargin(i+1);
                end
            case{'sciezkaTest'}
                if(typ_wejscia==0)
                    sciezka_zbior_testujacy=varargin(i+1);
                end
            case'sciezkaObceTrain'
                if(typ_wejscia==0)
                    sciezka_obce_zbior_uczacy=varargin(i+1);
                end
            case{'sciezkaObceTest'}
                if(typ_wejscia==0)
                    sciezka_obce_zbior_testujacy=varargin(i+1);
                end
            case{'sciezkaOutputClass'}
                sciezka_plik_wynikowy=varargin(i+1);
            case{'sciezkaOutputR'}
                sciezka_plik_dodatkowy=varargin(i+1);
            case{'iloscKlas'}
                if(typ_wejscia==-1)
                    if(cell2mat(varargin(i+1))<=1)
                        error('Ilosc klas jest liczba naturalna wieksza od 1!');
                    else
                        liczba_symboli=cell2mat(varargin(i+1));
                    end
                end
            case{'iloscCech'}
                if(typ_wejscia==-1)
                    if(cell2mat(varargin(i+1))<=0)
                        error('Ilosc cech jest liczba naturalna wieksza od 0!');
                    else
                        liczba_cech=cell2mat(varargin(i+1));
                    end
                end
            case{'iloscPowtorzenWKlasie'}
                if(typ_wejscia==-1)
                    if(cell2mat(varargin(i+1))<=0)
                        error('Ilosc klas jest liczba naturalna wieksza od 0!');
                    else
                        liczba_kopii=cell2mat(varargin(i+1));
                    end
                end
            case{'minLos'}
                if(typ_wejscia==-1)
                    min_wartosc=cell2mat(varargin(i+1));
                end
            case{'maxLos'}
                if(typ_wejscia==-1)
                    if(cell2mat(varargin(i+1))<min_wartosc)
                        error('Wartosc minLos <= maxLos!');
                    else
                        max_wartosc=cell2mat(varargin(i+1));
                    end
                end
            case{'zaburzenie'}
                if(typ_wejscia==-1)
                    wariancja=cell2mat(varargin(i+1));
                end
            case{'procRozmTest'}
                if(sciezka_zbior_testujacy=='_')
                    rozmiar_zb_testowy=cell2mat(varargin(i+1));
                end
            case{'procRozmObce'}
                if(czy_odrzucanie==0)
                    ile_procent_symboli_obcych=cell2mat(varargin(i+1));
                end
            case{'procRozmZaburz'}
            case{'dyskretyzacja'}
                if(typ_wejscia==-1)
                    if(cell2mat(varargin(i+1))<=1)
                        error('Dyskretyzacja jest liczba naturalna wieksza od 1!');
                    else
                        dyskretyzacja=cell2mat(varargin(i+1));
                    end
                end
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

main();

end
