function graph = drawGraph(handles, a, b)
    axes(handles.axes1); % grafik alan� belirleniyor
    fplot(get(handles.share_data, 'String'), [a b], ' - r'); % fonksiyon grafi�i �iziliyor [a,b] aral���nda
    grid; % grafik alan�nda �zgara olu�turuluyor
    % X ve Y ekseni isimleri olu�turuluyor
    xlabel([get(handles.val_a, 'String') ' <= x <= ' get(handles.val_b, 'String')]);
    ylabel([get(handles.phi, 'String') get(handles.yaklasim_n, 'String') '(x)']);
    graph = handles.axes1;
end
