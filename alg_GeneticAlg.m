function BestGene = alg_GeneticAlg(data,label,Gen,Popu,Pc,Pm)
%alg_GeneticAlg   Genetic Algorithm
%
%   BESTGENE = alg_GeneticAlg(DATA,LABEL,GEN,POPU,Pc,Pm)
%   returns the best gene vector.
%
%   GA for feature selection
%   November 21, 2016, by HanzheTeng

[datarow,datacol]=size(data);
[labelrow,labelcol]=size(label);
if datarow~=labelrow
    error('DATA and LABEL must have the same number of rows.');
end
if labelcol~=1
    error('LABEL must have only one column.');
end

% initialization
Genes = logical(randi([0 1],Popu,datacol));
Fits = zeros(1,Popu);
BestGene = Genes(1,:);
BestFit = 0;
testrow = randperm(datarow,ceil(datarow/10));
test = data(testrow,:);
testlabel = label(testrow);
data(testrow,:) = [];
label(testrow,:) = [];

for i=1:Gen
    % compute fitness
    for j=1:Popu
        Fits(j) = Fitness(data,label,test,testlabel,Genes(j,:));
    end

    % save the best gene
    BestFitNow = max(Fits);
    if BestFitNow > BestFit
        GeneRow = find(Fits==BestFitNow,1); % save only the first index
        BestGene = Genes(GeneRow,:);
        BestFit = BestFitNow;
    end

    % Selection Operator based on Roulette
    Genes = Selection(Genes,Fits,Popu);

    % CrossOver Operator
    for j=1:Popu
        row1 = randi([1 Popu]);
        row2 = randi([1 Popu]);
        [Genes(row1,:),Genes(row2,:)] = CrossOver(Genes(row1,:),Genes(row2,:),Pc);
    end

    % Mutation Operator
    for j=1:Popu
        Genes(j,:) = Mutation(Genes(j,:),Pm);
    end
end
end % End of function alg_GeneticAlg


% Selection Operator based on Roulette
function NewGenes = Selection(Genes,Fits,Popu)
    % Cumulative Probability
    CumuProb = zeros(1,Popu);
    for i=1:Popu
        CumuProb(i) = sum(Fits(1:i));
    end
    MaxProb = CumuProb(Popu);
    % New Genes
    NewGenes = Genes;
    for j=1:Popu
        P = rand * MaxProb;
        Ind = find(CumuProb > P,1); % return only the first index
        NewGenes(j,:) = Genes(Ind,:);
    end
end

% CrossOver Operator
function [Gene1,Gene2] = CrossOver(Gene1,Gene2,Pc)
    if rand>Pc
        return
    end
    num = length(Gene1);
    r = randi([1 num]);
    Gene3 = Gene1;
    Gene1(1,r:num) = Gene2(1,r:num);
    Gene2(1,r:num) = Gene3(1,r:num);
end

% Mutation Operator
function Gene = Mutation(Gene,Pm)
    if rand>Pm
        return
    end
    num = length(Gene);
    r = randi([1 num]);
    Gene(1,r) = ~Gene(1,r);
end

% Fitness Function
function accuracy = Fitness(train,trainlabel,test,testlabel,Gene)
    % Fitness based on accuracy
    testpredict = alg_KNN(train(:,Gene),trainlabel,test(:,Gene),3);
    accuracy = alg_Accuracy(testpredict,testlabel);
end
