function CRP = crp(DATASET_MAIN_I,n)

CRP = cell(n,1);
for i=1:n
    CRP{i,1} = zeros(4,4);
end

for i=1:n
    for j=1:11
     if DATASET_MAIN_I{i,1}(j,5) == 1
        if sum(DATASET_MAIN_I{i,1}(j,1:4)==2)>0
            CRP{i,1}(1,2) = CRP{i,1}(1,2)+1;
        end
        if sum(DATASET_MAIN_I{i,1}(j,1:4)==3)>0
            CRP{i,1}(1,3) = CRP{i,1}(1,3)+1;
        end
        if sum(DATASET_MAIN_I{i,1}(j,1:4)==4)>0
            CRP{i,1}(1,4) = CRP{i,1}(1,4)+1;
        end
     elseif DATASET_MAIN_I{i,1}(j,5) == 2
        if sum(DATASET_MAIN_I{i,1}(j,1:4)==1)>0
            CRP{i,1}(2,1) = CRP{i,1}(2,1)+1;
        end
        if sum(DATASET_MAIN_I{i,1}(j,1:4)==3)>0
            CRP{i,1}(2,3) = CRP{i,1}(2,3)+1;
        end
        if sum(DATASET_MAIN_I{i,1}(j,1:4)==4)>0
            CRP{i,1}(2,4) = CRP{i,1}(2,4)+1;
        end        
     elseif DATASET_MAIN_I{i,1}(j,5) == 3
        if sum(DATASET_MAIN_I{i,1}(j,1:4)==1)>0
            CRP{i,1}(3,1) = CRP{i,1}(3,1)+1;
        end
        if sum(DATASET_MAIN_I{i,1}(j,1:4)==2)>0
            CRP{i,1}(3,2) = CRP{i,1}(3,2)+1;
        end
        if sum(DATASET_MAIN_I{i,1}(j,1:4)==4)>0
            CRP{i,1}(3,4) = CRP{i,1}(3,4)+1;
        end    
     elseif DATASET_MAIN_I{i,1}(j,5) == 4
        if sum(DATASET_MAIN_I{i,1}(j,1:4)==1)>0
            CRP{i,1}(4,1) = CRP{i,1}(4,1)+1;
        end
        if sum(DATASET_MAIN_I{i,1}(j,1:4)==2)>0
            CRP{i,1}(4,2) = CRP{i,1}(4,2)+1;
        end
        if sum(DATASET_MAIN_I{i,1}(j,1:4)==3)>0
            CRP{i,1}(4,3) = CRP{i,1}(4,3)+1;
         end
     end
    end
end
end