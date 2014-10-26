function a = rozklad_normalny(srednia, wariancja)
a = sqrt(wariancja) .* randn(1,1) +srednia;
