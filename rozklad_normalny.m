function a = rozklad_normalny(srednia, wariancja)
%ROZKLAD_NORMALNY wyznacza wartosci rozkladu normalnego na podstawie 
%danej sredniej i wariancji

a = sqrt(wariancja) .* randn(1,1) + srednia;
end