

function [props]=PropExtract(image);

width=size(image,1);    %ligne pour calculer Gy du caractere
height=size(image,2); %collone pour calculer Gx


% si la dimmension de limage est inferieur à 9x9 on ladapte 
%pour le calcule du gradient par des fenetre de 3x3

%calcul du nombre de colonnes et de lignes à ajouter pour avoir 9x9
add_rows=0; 
add_columns=0; 
if width<9
    add_rows=9-width;
end
if height<9
    add_columns=9-height;
end
%on ajoute les lignes manquantes des 0
if mod(add_rows,2)==0
    image=[zeros(add_rows/2,height);image;zeros(add_rows/2,height)];
else
    image=[zeros((add_rows-1)/2,height);image;zeros((add_rows+1)/2,height)];
end

%nouveau nombre de lignes
width=size(image,1);

%ajout des colonne manquante
if mod(add_columns,2)==0
    image=[zeros(width,(add_columns)/2),image,zeros(width,(add_columns)/2)];
else
    image=[zeros(width,(add_columns-1)/2),image,zeros(width,(add_columns+1)/2)];
end
%nouveau nombre de colonne
height=size(image,2); %updating the column value

%si la taille de limage nest pas de lordre 3x3 on ajoute des ligne pour que
%chaque pixel et 8 voisin avec un pavage carée
n_rows=ceil(width/3)*3-width; % nombre de ligne de zero a ajouter
n_columns=ceil(height/3)*3-height; % nombre de colonne a ajouter
% par exemple si le nombre de ligne est row=13, alors 2 rows de  zeros
% doivent etre ajoute.  par exemple ceil(13/3)*3=15
%  alors n_rows=15-13=2  de ligne  a ajouter pour avoir un multiple de 3

%ajout des lignes
if mod(n_rows,2)==0
    image=[zeros(n_rows/2,height);image;zeros(n_rows/2,height)];
else
    image=[zeros((n_rows-1)/2,height);image;zeros((n_rows+1)/2,height)];
end
width=size(image,1);

%Ajout des colonnes
if mod(n_columns,2)==0
    image=[zeros(width,(n_columns)/2),image,zeros(width,(n_columns)/2)];
else
    image=[zeros(width,(n_columns-1)/2),image,zeros(width,(n_columns+1)/2)];
end
height=size(image,2);

% maintenant limage sera devise on neuf fenetre

Fwidth=height/3;
Fheight=width/3;

%si limage est de taille 12x9, alors le nombre de ligne de chaque zone est 
%12/3=4, et les colonne  9/3=3. 
fen11=image(1:Fheight,1:Fwidth); % zone11 contient pour lexemple image(1:4,1:3)
fen12=image(1:Fheight,(Fwidth+1):2*Fwidth); %image(1:4,4:6)
fen13=image(1:Fheight,(2*Fwidth+1):end); %image(1:4,7:12)

fen21=image((Fheight+1):2*Fheight,1:Fwidth); %image(5:8,1:3)
fen22=image((Fheight+1):2*Fheight,(Fwidth+1):2*Fwidth);%image(5:8,4:6)
fen23=image((Fheight+1):2*Fheight,(2*Fwidth+1):end) ;%image(5:8,7:12)

fen31=image((2*Fheight+1):end,1:Fwidth);%image(8:9,1:3)
fen32=image((2*Fheight+1):end,(Fwidth+1):2*Fwidth);%image(8:9,4:6)
fen33=image((2*Fheight+1):end,(2*Fwidth+1):end);%image(8:9,7:12)

% feature_vectors
fen11Prop=gradFen(fen11);
fen12Prop=gradFen(fen12);
fen13Prop=gradFen(fen13);

fen21Prop=gradFen(fen21);
fen22Prop=gradFen(fen22);
fen23Prop=gradFen(fen23);

fen31Prop=gradFen(fen31);
fen32Prop=gradFen(fen32);
fen33Prop=gradFen(fen33);



props=[fen11Prop;fen12Prop;fen13Prop;fen21Prop;fen22Prop;fen23Prop;fen31Prop;fen32Prop;fen33Prop];


function [propVect]=gradFen(fenetre)

width=size(fenetre,1); 
height=size(fenetre,2); 

[Gmag, Gdir]=imgradient(fenetre); %calcul du gradient de limage  Gmag=magnitude du gradient 
code0=0;                          %et Gdir=direction du gradient
code1=0;
code2=0;
code3=0;
code4=0;
code5=0;
code6=0;
code7=0;
code8=0;
code9=0;
code10=0;
code11=0;

for i = 1:width
    for j = 1:height
        if Gdir(i,j) >= 0 && Gdir(i,j) < 30
           code0=code0+1;
        elseif Gdir(i,j) >= 30 && Gdir(i,j) < 60
                code1=code1+1;
        elseif Gdir(i,j) >= 60 && Gdir(i,j) < 90
                code2=code2+1;
        elseif Gdir(i,j) >= 90 && Gdir(i,j) < 120
                code3=code3+1;
        elseif Gdir(i,j) >= 120 && Gdir(i,j) < 150
                code4=code4+1;
        elseif Gdir(i,j) >= 150 && Gdir(i,j) <180
                code5=code5+1;
        elseif Gdir(i,j) >= -180 && Gdir(i,j) < -150
                code6=code6+1;
        elseif Gdir(i,j) >= -150 && Gdir(i,j) < -120
                code7=code7+1;
        elseif Gdir(i,j) >= -120 && Gdir(i,j) < -90
                code8=code8+1;
        elseif Gdir(i,j) >= -90 && Gdir(i,j) < -60
                code9=code9+1;
        elseif Gdir(i,j) >= -60 && Gdir(i,j) < -30
                code10=code10+1;
        elseif Gdir(i,j) >= -30 && Gdir(i,j) < 0
                code11=code11+1;
        end        
    end
end

propVect=[code0;code1;code2;code3;code4;code5;code6;code7;code8;code9;code10;code11];

