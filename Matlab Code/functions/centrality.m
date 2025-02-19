function [cen, eig_marg, Pref_types] = centrality(CRP,n)

Per = flipud(perms([1:4]));

for i=1:n
    CRP{i,1}(CRP{i,1}==0)=0.001;
end

Centrality = cell(n,1);

for i=1:n
   Centrality{i,1} = eigencentrality(CRP{i,1});
end

for i = 1:n
    if Centrality{i,1}(1,1)<0
        Centrality{i,1} = Centrality{i,1}*-1;
    end
end

Pref_types = zeros(n,4);
max1 = zeros(n,4);
ind1 = zeros(n,4);
for i=1:n
    for j = 1:4
        [max1(i,j),ind1(i,j)] = max(Centrality{i,1});
        Centrality{i,1}(ind1(i,j),1) = -100;
        Pref_types(i,j) = ind1(i,j);
    end
end

Centrality = cell(n,1);

for i=1:n
   Centrality{i,1} = eigencentrality(CRP{i,1});
end

for i = 1:n
    if Centrality{i,1}(1,1)<0
        Centrality{i,1} = Centrality{i,1}*-1;
    end
end

cen = [];
for i =1:n
    temp = Centrality{i,1}';
    cen(i,:) = temp;
end

for i=1:n
    for j=1:size(Per,1)
        temp(j)=isequal(Pref_types(i,:),Per(j,:));
    end
    t(i) = find(temp==1);
end
t=sort(t)';
for i=1:size(Per,1)
    eig_marg(i)=sum(t==i);
end
eig_marg=(eig_marg./n)';
end