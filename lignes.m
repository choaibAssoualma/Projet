%fonction qui retourne une ligne de limage 

function [partie1 reste]=lignes(image)

image=couperNul(image);


width=size(image,1); %1 pour le width et 2 pour le height
for i=1:width
    if sum(image(i,:))==0   % si la ligne courante contient que des 0
        p1=image(1:i-1, :); % contient les ligne de 1 jusqua la  ligne precedente
        p2=image(i:end, :);% contient de la ligne courante a la fin
        partie1 = couperNul(p1);
        reste=couperNul(p2);
        break
    else  
        partie1=image;
        reste=[ ];
    end
end

function img_out=couperNul(img_in)
[f c]=find(img_in); %find retourne les partie non 0 de limage
img_out=img_in(min(f):max(f),min(c):max(c));%couper les parties 0 de limage