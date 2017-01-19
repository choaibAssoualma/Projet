%D
%fonction qui retourne un mot de limage en entre


function [partie1 reste]=mots(image)

image=couperNul(image);


height=size(image,2); 
for i=1:height
    if i+20 < height 
        Q=i+20; %pour dire que deux mot sans different il doivent etre separe par au moins 20 pix
    else
        Q=height;
    end
    if sum(image(:,i:Q))==0  
        p1=image(:,1:i-1); 
        p2=image(:,i:end);
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