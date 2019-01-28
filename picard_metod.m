%Birinci derecen dif. denkleminin verilen phi0 ba�lang�� ko�ulunu
%kullanarak picard metodu ile ��z�lmesi
function f_n = picard_metod(str_x0, str_y0, str_phi0, str_dy, yaklasim )
%y = phi0;
%y(x1) = y(x0) + int( dy );
x = 'x';
x = sym(x);

find = strfind(str_dy, 'y(x)'); % y'(x) = ... ifadesinde y(x) 'li ifade varsa bu ifadeyi
% y(x) = y olacak �ekilde de�i�tir. matlabda symbolik fonk. olu�tururken
% y(x) yerine y yaz�l�r. find de�eri '1' ise y(x)'li bir ifade
% i�ermektedir.

str_dy = strrep(str_dy, '[', '('); % girilen k��eli parantezleri normal paranteze �evir.
str_dy = strrep(str_dy, ']', ')'); % % girilen k��eli parantezleri normal paranteze �evir.

str_phi_n_1 = str_phi0;
y0 = str2double(str_y0); % string olarak verilen y0 ba�lang�� de�erini normal double de�i�kene ata

%1'den n. yakla��ma kadar
for i = 1:yaklasim
    % find = 1 ise y(x) li ifade yerine phi_n_1 ifadesi ile de�i�tir.
    if find >= 1
        str_phi_n_1 = strrep(str_dy, 'y(x)', ['(' str_phi_n_1 ')']);
    else
        str_phi_n_1 = strrep(str_dy, 'y', ['(' str_phi_n_1 ')']);
    end
    f_n = symfun(y0 + int( sym(str_phi_n_1), x, 'IgnoreAnalyticConstraints', true), x);
    f_n = vpa(f_n, 4);
    str_phi_n_1 = char(f_n);
end

