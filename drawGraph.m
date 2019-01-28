function graph = drawGraph(handles, a, b)
    axes(handles.axes1); % grafik alaný belirleniyor
    fplot(get(handles.share_data, 'String'), [a b], ' - r'); % fonksiyon grafiði çiziliyor [a,b] aralýðýnda
    grid; % grafik alanýnda ýzgara oluþturuluyor
    % X ve Y ekseni isimleri oluþturuluyor
    xlabel([get(handles.val_a, 'String') ' <= x <= ' get(handles.val_b, 'String')]);
    ylabel([get(handles.phi, 'String') get(handles.yaklasim_n, 'String') '(x)']);
    graph = handles.axes1;
end
