function czy_liczba(src, event)
str = get(src, 'String');
if isempty(str2double(str))
    set(src, 'string', '0');
    warndlg('Ustaw poprawne wartoœci parametrów');
end