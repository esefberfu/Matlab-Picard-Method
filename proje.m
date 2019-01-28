function varargout = proje(varargin)
% PROJE MATLAB code for proje.fig
%      PROJE, by itself, creates a new PROJE or raises the existing
%      singleton*.
%
%      H = PROJE returns the handle to a new PROJE or the handle to
%      the existing singleton*.
%
%      PROJE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJE.M with the given input arguments.
%
%      PROJE('Property','Value',...) creates a new PROJE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before proje_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to proje_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help proje

% Last Modified by GUIDE v2.5 01-Nov-2017 23:14:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proje_OpeningFcn, ...
                   'gui_OutputFcn',  @proje_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before proje is made visible.
function proje_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proje (see VARARGIN)

% Choose default command line output for proje
handles.output = hObject;
createOzelDenklem(handles, 1);
disp(varargin);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes proje wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = proje_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in draw.
function draw_Callback(hObject, eventdata, handles)
% hObject    handle to draw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

denklem = get(handles.denklem, 'Value'); % Hangi denklemin çözüleceði bilgisi alýnýyor
yaklasim = str2double(get(handles.yaklasim_n, 'String')); % kaçýncý yaklaþým yapýlacaðý alýnýyor
a = str2double(get(handles.val_a, 'String')); % a <= x <= b için a,b aralýðý alýnýyor
b = str2double(get(handles.val_b, 'String'));
set(handles.f_name, 'String', [get(handles.phi, 'String') get(handles.yaklasim_n, 'String') '(x) = ']);%Fonksiyonun ismi Phi_n(x) olacak þekilde yazýlýyor.

x = sym('x');

str_x0 = get(handles.x0_text, 'String');
str_y0 = get(handles.y0_text, 'String');
str_phi0 = get(handles.phi0_text, 'String');
str_dy = get(handles.dy_text, 'String');

f_n = picard_metod(str_x0, str_y0, str_phi0, str_dy, yaklasim);

%handles.F_n = f_n;
set(handles.share_data, 'String', char(f_n));
%handles.str_F_n = char(f_n); % Global fonksiyon oluþturuluyor
%guidata(hObject, handles); % Global fonksiyon string tipinde oluþturuluyor

set(handles.sonuc, 'string', get(handles.share_data, 'String')); % textbox'a yazdýrýlýyor

drawGraph(handles, a, b);% Grafik çizdiriliyor

createValueTable(handles); % Grafikteki nokta ve deðerler tabloya yazdýrýlýyor
  


% --- Executes on button press in goster.
function goster_Callback(hObject, eventdata, handles)
% hObject    handle to goster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = figure;
h.MenuBar = 'none';
figure(h);
a = axes();
axes(a);
imshow('denklemler.png');

% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in hesapla.
function hesapla_Callback(hObject, eventdata, handles)
% hObject    handle to hesapla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = sym('x');

input_x = str2double(get(handles.input_text, 'String'));
F_n = symfun(sym(get(handles.share_data, 'String')), x);
output_y = F_n(input_x);
disp(double(output_y));
output_double_y = double(output_y);
set(handles.edit16, 'String', [get(handles.phi, 'String') get(handles.yaklasim_n, 'String') '(' get(handles.input_text, 'String') ') ='] );
set(handles.output_text, 'String', output_double_y);

% --- Executes on button press in goster_nokta.
function goster_nokta_Callback(hObject, eventdata, handles)
% hObject    handle to goster_nokta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = sym('x');
input_x = str2double(get(handles.input_text, 'String'));
F_n = symfun(sym(get(handles.share_data, 'String')), x);
output_y = F_n(input_x);
output_double_y = double(output_y);
text(input_x, output_double_y, strcat('\leftarrow (', get(handles.input_text, 'String'), ', ', get(handles.output_text, 'String'), ')'), 'Parent', handles.axes1);


function denklem_Callback(hObject, eventdata, handles)
denklem = get(handles.denklem, 'Value');
createOzelDenklem(handles, denklem);

%*******************************************************************************************
%*******************************************************************************************
%*******************************************************************************************
%*******************************************************************************************



function edit18_Callback(hObject, eventdata, handles)
function yaklasim_n_Callback(hObject, eventdata, handles)

function val_a_Callback(hObject, eventdata, handles)
function val_b_Callback(hObject, eventdata, handles)
function output_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function input_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function sonuc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function val_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function val_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function yaklasim_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function denklem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_text_Callback(hObject, eventdata, handles)
% hObject    handle to input_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_text as text
%        str2double(get(hObject,'String')) returns contents of input_text as a double



function output_text_Callback(hObject, eventdata, handles)
% hObject    handle to output_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output_text as text
%        str2double(get(hObject,'String')) returns contents of output_text as a double



function x0_text_Callback(hObject, eventdata, handles)
% hObject    handle to x0_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x0_text as text
%        str2double(get(hObject,'String')) returns contents of x0_text as a double


% --- Executes during object creation, after setting all properties.
function x0_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x0_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y0_text_Callback(hObject, eventdata, handles)
% hObject    handle to y0_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y0_text as text
%        str2double(get(hObject,'String')) returns contents of y0_text as a double


% --- Executes during object creation, after setting all properties.
function y0_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y0_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function phi0_text_Callback(hObject, eventdata, handles)
% hObject    handle to phi0_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of phi0_text as text
%        str2double(get(hObject,'String')) returns contents of phi0_text as a double


% --- Executes during object creation, after setting all properties.
function phi0_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phi0_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dy_text_Callback(hObject, eventdata, handles)
% hObject    handle to dy_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dy_text as text
%        str2double(get(hObject,'String')) returns contents of dy_text as a double


% --- Executes during object creation, after setting all properties.
function dy_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dy_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
