%% Inspect Binary Leaner Properties of ECOC Classifiers
% You can access properties of binary learners, such as estimated
% parameters, using dot notation.
%%
% Load Fisher's iris data set. Use the petal dimensions as predictors.

% Copyright 2015 The MathWorks, Inc.

load fisheriris
X = meas(:,3:4);
Y = species;
%%
% Train an ECOC classifier using the SVM binary learners (SVM) and the
% default coding design (one-versus-one).  Specify to standardize the
% predictors, and to use the default linear kernel.
t = templateSVM('Standardize',1,'SaveSupportVectors',true);
predictorNames = {'petalLength','petalWidth'};
responseName = 'irisSpecies';
classNames = {'setosa','versicolor','virginica'}; % Specify class order
Mdl = fitcecoc(X,Y,'Learners',t,'ResponseName',responseName,...
    'PredictorNames',predictorNames,'ClassNames',classNames)
%%
% |t| is a template object that contains options for SVM classification. All
% properties are empty (|[]|), except for |Method|,
% |StandardizeData|, and |Type|.  |fitcecoc| uses the default values of the
% empty properties. |Mdl| is a |ClassificationECOC| classifier.  You can
% access its properties using dot notation.
%%
% Display the class names and coding design matrix.
Mdl.ClassNames
Mdl.CodingMatrix
L = size(Mdl.CodingMatrix,2); % Number of SVMs
%%
% The columns correspond to SVM binary learners, and the rows to the
% distinct classes.  The row order corresponds to the order of the
% |ClassNames| property of |Mdl|.  For each column:
%
% * A |1| indicates that |fitcecoc| trained the SVM using observations in the
% corresponding class as members of the positive group.
% * A |-1| indicates that |fitcecoc| trained the SVM using observations in the
% corresponding class as members of the negative group.
% * A |0| indicates that the SVM did not use observations in the
% corresponding class.
%
% For example, |fitcecoc| assigns all observations to 
% |'setosa'| or |'versicolor'|, but not |'virginica'| in the first SVM.
%%
% You can access properties of the SVMs using cell subscripting and dot
% notation.  Store the standardized support vectors of each SVM.
% Unstandardize the support vectors.
sv = cell(L,1); % Preallocate for support vector indices
for j = 1:3;
    SVM = Mdl.BinaryLearners{j};
    sv{j} = SVM.SupportVectors;
   % sv{j} = bsxfun(@plus,bsxfun(@times,sv{j},SVM.Sigma),SVM.Mu);
end
%%
% |sv| is a cell array of matrices containing the unstandardized support
% vectors for the SVMs.
%%
% Plot the data, and identify the support vectors.






markers = {'ko','ro','bo'};
for j = 1:L-1;
    figure(j);
h = zeros(3 + L,1); % Preallocate for handles
h(1:2) = gscatter(X(50*(j-1)+1:50*(j+1),1),X(50*(j-1)+1:50*(j+1),2),Y(50*(j-1)+1:50*(j+1)));
hold on;
    svs = sv{j};
    h(j + 3) = plot(svs(:,1),svs(:,2),markers{j},...
        'MarkerSize',10 + (j - 1)*3);
    title 'Fisher''s Iris -- ECOC Support Vectors';
xlabel(predictorNames{1});
ylabel(predictorNames{2});
legend(h(1:2),[classNames(j:j+1),{'Support vectors - SVM 1',...
    'Support vectors - SVM 2','Support vectors - SVM 3'}],...
    'Location','Best')
hold off
end





%%
% You can pass |Mdl| to:
%
% * |predict| to classify new observations
% * |resubLoss| to estimate the in-sample classification error
% * |crossval| to perform 10-fold cross validation.
%