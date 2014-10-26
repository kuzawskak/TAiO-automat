function czy_liczba(src, eventdata)
str = get(src, 'String');
if isempty(str2num(str))
    set(src, 'string', '0');
    warndlg('Ustaw poprawne wartoœci parametrów');
end