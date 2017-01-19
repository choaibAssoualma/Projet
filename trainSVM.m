

load('input.mat');
load('alphabet.mat');
X =input;
Y=alphabet;


t = templateSVM('Standardize',1,'SaveSupportVectors',true);
predictorNames = {'propvect1','propvect2','propvect3','propvect4','propvect5','propvect6','propvect7','propvect8','propvect9','propvect10','propvect11','propvect12','propvect13','propvect14','propvect15','propvect16','propvect17','propvect18','propvect19','propvect20','propvect21','propvect22','propvect23','propvect24','propvect25','propvect26','propvect27','propvect28','propvect29','propvect30','propvect31','propvect32','propvect33','propvect34','propvect35','propvect36','propvect37','propvect38','propvect39','propvect40','propvect41','propvect42','propvect43','propvect44','propvect45','propvect46','propvect47','propvect48','propvect49','propvect50','propvect51','propvect52','propvect53','propvect54','propvect55','propvect56','propvect57','propvect58','propvect59','propvect60','propvect67','propvect68','propvect69','propvect70','propvect71','propvect72','propvect73','propvect74','propvect75','propvect76','propvect77','propvect78','propvect79','propvect80','propvect81','propvect82','propvect83','propvect84','propvect85','propvect86','propvect87','propvect88','propvect89','propvect90','propvect100','propvect101','propvect102','propvect103','propvect104','propvect105','propvect106','propvect107','propvect108','propvect109','propvect120','propvect121','propvect122','propvect123','propvect91','propvect92','propvect93','propvect94','propvect95','propvect96','propvect97','propvect98','propvect99','propvect150'};

responseName = 'ensaOcr';
classNames = {'A','B','C','D','E','F','G','H','I','G','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'}; % Specify class order
Mdl = fitcecoc(X,Y,'Learners',t,'ResponseName',responseName,...
    'PredictorNames',predictorNames,'ClassNames',classNames);



%Mdl.ClassNames;
%Mdl.CodingMatrix;
L = size(Mdl.CodingMatrix,2); % nombre des SVM 



sv = cell(L,1); % Preallocate for support vector indices
for j = 1:L;
    SVM = Mdl.BinaryLearners{j};
    sv{j} = SVM.SupportVectors;
    sv{j} = bsxfun(@plus,bsxfun(@times,sv{j},SVM.Sigma),SVM.Mu);
end



% |sv| is a cell array of matrices containing the unstandardized support
% vectors for the SVMs.
%

% Plot the data, and identify the support vectors.

b=jet(4);
for j = 1:4;
    figure(j);
h = zeros(3 + L,1); % Preallocate for handles
h(1:2) = gscatter(X(25*(j-1)+1:25*(j+1),1),X(25*(j-1)+1:25*(j+1),2),Y(25*(j-1)+1:25*(j+1))); %chaque lettre et represente en 25 exemplaire
hold on;
   svs = sv{j};
  
    h(j + 3)=plot(svs(1,1),svs(1,2),'o',...
       'MarkerSize',10,'Color',b(j,1:3));

legend(h(1:2),[classNames(j:j+1)],...
    'Location','Best')
title 'test';
hold off
end



save   C:\Users\choaib\Desktop\Projet\Mdl Mdl;
