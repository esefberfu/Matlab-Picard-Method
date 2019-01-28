function f = createOzelDenklem(handles, denklem)
%UNTÝTLED8 Summary of this function goes here
%   Detailed explanation goes here
if denklem == 1
    set(handles.x0_text, 'enable', 'off');
    set(handles.y0_text, 'enable', 'off');
    set(handles.phi0_text, 'enable', 'off');
    set(handles.dy_text, 'enable', 'off');
    set(handles.x0_text, 'String', '0');
    set(handles.y0_text, 'String', '1');
    set(handles.phi0_text, 'String', '1');
    set(handles.dy_text, 'String', 'y(x)');
elseif denklem == 2
    set(handles.x0_text, 'enable', 'off');
    set(handles.y0_text, 'enable', 'off');
    set(handles.phi0_text, 'enable', 'off');
    set(handles.dy_text, 'enable', 'off');
    set(handles.x0_text, 'String', '0');
    set(handles.y0_text, 'String', '0');
    set(handles.phi0_text, 'String', '0');
    set(handles.dy_text, 'String', '3*x - [y(x)]^2');
elseif denklem == 3
    set(handles.x0_text, 'enable', 'off');
    set(handles.y0_text, 'enable', 'off');
    set(handles.phi0_text, 'enable', 'off');
    set(handles.dy_text, 'enable', 'off');
    set(handles.x0_text, 'String', '2');
    set(handles.y0_text, 'String', '0');
    set(handles.phi0_text, 'String', 'x-2');
    set(handles.dy_text, 'String', '3*[y(x)]^(2/3)');
elseif denklem == 4
    set(handles.x0_text, 'enable', 'on');
    set(handles.y0_text, 'enable', 'on');
    set(handles.phi0_text, 'enable', 'on');
    set(handles.dy_text, 'enable', 'on');
    set(handles.x0_text, 'String', '0');
    set(handles.y0_text, 'String', '0');
    set(handles.phi0_text, 'String', '0');
    set(handles.dy_text, 'String', '0');
end


end

