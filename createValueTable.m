function valueTable = createValueTable( handles )
    axObj = handles.axes1;
    dataObj = get(axObj, 'Children');
    xdata = get(dataObj, 'XData');
    ydata = get(dataObj, 'YData');
    [row, size_x] = size(xdata);
    valueTable = zeros(size_x, 2);
    for index=1:size_x
        valueTable(index,1) = xdata(index);
        valueTable(index,2) = ydata(index);
        if mod(xdata(index), 1) == 0
            text(xdata(index), ydata(index), char(index));
        end
    end
    set(handles.table, 'data', valueTable);
end

