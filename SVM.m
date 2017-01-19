


function SVM(imagen)


figure(1)
imshow(imagen);
title('Image originale')

%% si limage est en couleur  rgb convertir en niveaux de gris
if size(imagen,3)==3 
    imagen=rgb2gray(imagen);
    figure(2)
imshow(imagen);
title('IMAGE  en niveaux de gris')
end

%% seuillage de limage 
threshold = graythresh(imagen);
imagen =~im2bw(imagen,threshold);
    figure(3)
imshow(imagen);
title('image seuillé')
%% supprimer le bruit(les objets de moins de 15 pixels)
imagen =bwareaopen(imagen,15);
%% Show image binary image
figure(4)
imshow(imagen);
title('IMAGE   debruité')

%% detection des contour
Iedge = edge(uint8(imagen));


%dilatation pour remplir les contours
se = strel('square',3);
Iedge2 = imdilate(Iedge, se); 


% remplissage des contours si un contour ne sait
%pas remplis lor de la dilatation

Ifill= imfill(Iedge2,'holes');


%NewIfillPixel=1 si AncienIfillpixel=1 et ImagenPixel=1
%cettre operation laisse dans limage imagen les contours trouve par les
%operation precedetens
Ifill=Ifill & imagen;

re=Ifill;


while 1
    
    
    %extration dune ligne
    [fl re]=lignes(re);
    re2=fl; 
    
while 1
    %extraction dun mot
     [fl2 re2]=mots(re2);
    imgn=fl2; 
    %f1 contient la ligne courante
    % etiquette les differente region connexes dune image avec des num 1..n
    %L matrice qui contient les region connecte chanque region avec un id
    %1..n
    %Ne le nombre des differente region de 1 cest a dire caractere different
    [L Ne] = bwlabel(imgn);    
    % monter ligne par ligne :

%% extraction des caractere
for n=1:Ne  %pour chaque region
    [r,c] = find(L==n); %retourner linterrvale de la region de id n
    n1=imgn(min(r):max(r),min(c):max(c));
    BW2 = bwmorph(n1,'thin',Inf); %normaliser les caractere et lier les trous
    z=imresize(BW2,[50 50]);  %taille du caractere

   
    z=PropExtract(z); %extraire les caracteristique du caracteres
    
    load ('C:\Users\choaib\Desktop\Projet\carProp.mat');
    carProp=z;
    
    save ('C:\Users\choaib\Desktop\Projet\carProp.mat','carProp');
    testSVM
    
end
 %retour a la ligne apres traitement de la ligne
  
if isempty(re2)  %See variable 're' in Fcn 'lines'
        break
end 
fid = fopen('C:\Users\choaib\Desktop\Projet\test.txt','a');
  fprintf(fid,' ');
  
fclose(fid);
end
fid = fopen('C:\Users\choaib\Desktop\Projet\test.txt','a'); %inserer un espace apré
  fprintf(fid,'\r\n');
  
fclose(fid);
if isempty(re)  %See variable 're' in Fcn 'lines'
        break
end  
    
end