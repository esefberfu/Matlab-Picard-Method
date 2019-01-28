%Birinci derecen dif. denkleminin verilen phi0 baþlangýç koþulunu
%kullanarak picard metodu ile çözülmesi
function f_n = picard_metod(str_x0, str_y0, str_phi0, str_dy, yaklasim )
%y = phi0;
%y(x1) = y(x0) + int( dy );
x = 'x';
x = sym(x);

find = strfind(str_dy, 'y(x)'); % y'(x) = ... ifadesinde y(x) 'li ifade varsa bu ifadeyi
% y(x) = y olacak þekilde deðiþtir. matlabda symbolik fonk. oluþtururken
% y(x) yerine y yazýlýr. find deðeri '1' ise y(x)'li bir ifade
% içermektedir.

str_dy = strrep(str_dy, '[', '('); % girilen köþeli parantezleri normal paranteze çevir.
str_dy = strrep(str_dy, ']', ')'); % % girilen köþeli parantezleri normal paranteze çevir.

str_phi_n_1 = str_phi0;
y0 = str2double(str_y0); % string olarak verilen y0 baþlangýç deðerini normal double deðiþkene ata

%1'den n. yaklaþýma kadar
for i = 1:yaklasim
    % find = 1 ise y(x) li ifade yerine phi_n_1 ifadesi ile deðiþtir.
    if find >= 1
        str_phi_n_1 = strrep(str_dy, 'y(x)', ['(' str_phi_n_1 ')']);
    else
        str_phi_n_1 = strrep(str_dy, 'y', ['(' str_phi_n_1 ')']);
    end
    f_n = symfun(y0 + int( sym(str_phi_n_1), x, 'IgnoreAnalyticConstraints', true), x);
    f_n = vpa(f_n, 4);
    str_phi_n_1 = char(f_n);
end

