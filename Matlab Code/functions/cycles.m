function [cycle,onebest,ternary_cycle] = cycles(NEW)
BINARYSETS = zeros(6,size(NEW,1));
for i=1:size(NEW,1)
    BINARYSETS(:,i)=NEW{i,1}(1:6,5);
end
binary_pref = zeros(4,4,size(NEW,1));
for i=1:size(NEW,1)
    binary_pref(:,:,i) = [0, BINARYSETS(1,i)==1 BINARYSETS(2,i)==1 BINARYSETS(3,i)==1;
                            BINARYSETS(1,i)==2 0 BINARYSETS(4,i)==2 BINARYSETS(5,i)==2;
                            BINARYSETS(2,i)==3 BINARYSETS(4,i)==3 0 BINARYSETS(6,i)==3;
                            BINARYSETS(3,i)==4 BINARYSETS(5,i)==4 BINARYSETS(6,i)==4 0];
end
% cycles
for i=1:size(NEW,1)
    binarygraph{i,1}=digraph(binary_pref(:,:,i));
    cycle(i,1)=isdag(binarygraph{i,1});
    onebest(i,1)=sum(sum(binary_pref(:,:,i))==3);
end
cycle=double(cycle);

% CYCLE IN TERNARY SETS

TERNARYSETS = cell(size(NEW,1),1);
for i=1:size(NEW,1)
    TERNARYSETS{i,1}=NEW{i,1}(7:10,:);
end
CRP_ter = cell(size(NEW,1),1);
for i=1:size(NEW,1)
    CRP_ter{i,1} = zeros(4,4);
end

for i=1:size(NEW,1)
    for j=1:4
     if TERNARYSETS{i,1}(j,5) == 1
        if sum(TERNARYSETS{i,1}(j,1:4)==2)>0
            CRP_ter{i,1}(1,2) = CRP_ter{i,1}(1,2)+1;
        end
        if sum(TERNARYSETS{i,1}(j,1:4)==3)>0
            CRP_ter{i,1}(1,3) = CRP_ter{i,1}(1,3)+1;
        end
        if sum(TERNARYSETS{i,1}(j,1:4)==4)>0
            CRP_ter{i,1}(1,4) = CRP_ter{i,1}(1,4)+1;
        end
     elseif TERNARYSETS{i,1}(j,5) == 2
        if sum(TERNARYSETS{i,1}(j,1:4)==1)>0
            CRP_ter{i,1}(2,1) = CRP_ter{i,1}(2,1)+1;
        end
        if sum(TERNARYSETS{i,1}(j,1:4)==3)>0
            CRP_ter{i,1}(2,3) = CRP_ter{i,1}(2,3)+1;
        end
        if sum(TERNARYSETS{i,1}(j,1:4)==4)>0
            CRP_ter{i,1}(2,4) = CRP_ter{i,1}(2,4)+1;
        end        
     elseif TERNARYSETS{i,1}(j,5) == 3
        if sum(TERNARYSETS{i,1}(j,1:4)==1)>0
            CRP_ter{i,1}(3,1) = CRP_ter{i,1}(3,1)+1;
        end
        if sum(TERNARYSETS{i,1}(j,1:4)==2)>0
            CRP_ter{i,1}(3,2) = CRP_ter{i,1}(3,2)+1;
        end
        if sum(TERNARYSETS{i,1}(j,1:4)==4)>0
            CRP_ter{i,1}(3,4) = CRP_ter{i,1}(3,4)+1;
        end    
     elseif TERNARYSETS{i,1}(j,5) == 4
        if sum(TERNARYSETS{i,1}(j,1:4)==1)>0
            CRP_ter{i,1}(4,1) = CRP_ter{i,1}(4,1)+1;
        end
        if sum(TERNARYSETS{i,1}(j,1:4)==2)>0
            CRP_ter{i,1}(4,2) = CRP_ter{i,1}(4,2)+1;
        end
        if sum(TERNARYSETS{i,1}(j,1:4)==3)>0
            CRP_ter{i,1}(4,3) = CRP_ter{i,1}(4,3)+1;
         end
     end
    end
end

WARP_ter = zeros(size(NEW,1),1);
for i=1:size(NEW,1)
    WARP_ter(i,1)=sum(sum(CRP_ter{i,1}.*(CRP_ter{i,1})'))/2;
end

for i=1:size(NEW,1)
    ternary_graph{i,1}=digraph(CRP_ter{i,1});
    ternary_cycle(i,1)=isdag(ternary_graph{i,1});
end
end