


load ('C:\Users\choaib\Desktop\Projet\carProp.mat');
load ('C:\Users\choaib\Desktop\Projet\Mdl.mat');

    car=carProp; %caracteristique du caractere
    %prediction du caractere en utilisante le classifieur entrainé Mdl
     p=predict(Mdl,car');
     fichier = fopen('C:\Users\choaib\Desktop\Projet\test.txt','a');
  
    fprintf(fichier,'%s',p{1});
    fclose(fichier);     


 
 