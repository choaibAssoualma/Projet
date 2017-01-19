



load ('C:\Users\choaib\Desktop\Projet\carProp.mat');
 car=carProp; %caracteristique du caractere


net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
load C:\Users\choaib\Desktop\Projet\net.mat;
load net;

  y5=sim(net,car); %retourner le vecteur sortie pour lentre CAR qui contient le  caracteristique du caractere extrait de limage

 [val indice]=max(y5);
 

 
  
  fichier = fopen('C:\Users\choaib\Desktop\Projet\test.txt','a');
 
  
if (indice==1)
    fprintf(fichier,'A');
elseif (indice==2)
    fprintf(fichier,'B');
elseif (indice==3)
    fprintf(fichier,'C');
elseif (indice==4)
    fprintf(fichier,'D');
elseif (indice==5)
    fprintf(fichier,'E');
elseif (indice==6)
    fprintf(fichier,'F');
elseif (indice==7)
    fprintf(fichier,'G');
elseif (indice==8)
    fprintf(fichier,'H');
elseif (indice==9)
    fprintf(fichier,'I');
elseif (indice==10)
    fprintf(fichier,'J');
elseif (indice==11)
    fprintf(fichier,'K');
    fclose(fichier);     
elseif (indice==12)
    fprintf(fichier,'L');
elseif (indice==13)
    fprintf(fichier,'M');
elseif (indice==14)
    fprintf(fichier,'N');
elseif (indice==15)
    fprintf(fichier,'O');
elseif (indice==16)
    fprintf(fichier,'P');
elseif (indice==17)
    fprintf(fichier,'Q');
elseif (indice==18)
    fprintf(fichier,'R');
elseif (indice==19)
    fprintf(fichier,'S');
elseif (indice==20)
    fprintf(fichier,'T');
elseif (indice==21)
    fprintf(fichier,'U');
elseif (indice==22)
    fprintf(fichier,'V');
elseif (indice==23)
    fprintf(fichier,'W');
elseif (indice==24)
    fprintf(fichier,'X');
elseif (indice==25)
    fprintf(fichier,'Y');
elseif (indice==26)
    fprintf(fichier,'Z');
 else
    fprintf(fichier,'?');
end
    fclose(fichier);     


 
 
 