function [AC,BC,OneBest] = AC_BC_merletti(data_acbc)

BINARYSETS=data_acbc(:,1:10);

binary_pref = zeros(5,5,size(data_acbc,1));
for i=1:size(data_acbc,1)
    binary_pref(:,:,i) = [0, BINARYSETS(i,1)==8 BINARYSETS(i,2)==8 BINARYSETS(i,3)==8 BINARYSETS(i,4)==8;
                            BINARYSETS(i,1)==9 0 BINARYSETS(i,5)==9 BINARYSETS(i,6)==9 BINARYSETS(i,7)==9;
                            BINARYSETS(i,2)==10 BINARYSETS(i,5)==10 0  BINARYSETS(i,8)==10 BINARYSETS(i,9)==10;
                            BINARYSETS(i,3)==11 BINARYSETS(i,6)==11 BINARYSETS(i,8)==11 0 BINARYSETS(i,10)==11;
                            BINARYSETS(i,4)==13 BINARYSETS(i,7)==13 BINARYSETS(i,9)==13 BINARYSETS(i,10)==13 0];
end

BC = zeros(size(data_acbc,1),1);
for i=1:size(data_acbc,1)
    binarygraph{i,1}=digraph(binary_pref(:,:,i));
    OneBest(i,1) = max(sum(binary_pref(:,:,i),2)==4);
    cycles{i,1} = allcycles(binarygraph{i,1});
    if isempty(allcycles(binarygraph{i,1}))
    BC(i,1) = 0;
    else
    BC(i,1) = size(allcycles(binarygraph{i,1}),1);
    end
end

for i=1:size(data_acbc,1)
   always_chosen(:,i) = [data_acbc(i,1)==8 & data_acbc(i,2)==8 & data_acbc(i,3)==8 & data_acbc(i,11)~=8;
                         data_acbc(i,1)==8 & data_acbc(i,2)==8 & data_acbc(i,4)==8 & data_acbc(i,12)~=8;
                         data_acbc(i,1)==8 & data_acbc(i,3)==8 & data_acbc(i,4)==8 & data_acbc(i,13)~=8;
                         data_acbc(i,2)==8 & data_acbc(i,3)==8 & data_acbc(i,4)==8 & data_acbc(i,14)~=8;
                         data_acbc(i,1)==8 & data_acbc(i,2)==8 & data_acbc(i,3)==8 & data_acbc(i,4)==8 & data_acbc(i,16)~=8;

                         data_acbc(i,1)==9 & data_acbc(i,5)==9 & data_acbc(i,6)==9 & data_acbc(i,11)~=9;
                         data_acbc(i,1)==9 & data_acbc(i,5)==9 & data_acbc(i,7)==9 & data_acbc(i,12)~=9;
                         data_acbc(i,1)==9 & data_acbc(i,6)==9 & data_acbc(i,7)==9 & data_acbc(i,13)~=9;
                         data_acbc(i,5)==9 & data_acbc(i,6)==9 & data_acbc(i,7)==9 & data_acbc(i,15)~=9;
                         data_acbc(i,1)==9 & data_acbc(i,5)==9 & data_acbc(i,6)==9 & data_acbc(i,7)==9 & data_acbc(i,16)~=9;

                         data_acbc(i,2)==10 & data_acbc(i,5)==10 & data_acbc(i,8)==10 & data_acbc(i,11)~=10;
                         data_acbc(i,2)==10 & data_acbc(i,5)==10 & data_acbc(i,9)==10 & data_acbc(i,12)~=10;
                         data_acbc(i,2)==10 & data_acbc(i,8)==10 & data_acbc(i,8)==10 & data_acbc(i,14)~=10;
                         data_acbc(i,5)==10 & data_acbc(i,8)==10 & data_acbc(i,9)==10 & data_acbc(i,15)~=10;
                         data_acbc(i,2)==10 & data_acbc(i,5)==10 & data_acbc(i,8)==10 & data_acbc(i,9)==10 & data_acbc(i,16)~=10;

                         data_acbc(i,3)==11 & data_acbc(i,6)==11 & data_acbc(i,8)==11 & data_acbc(i,11)~=11;
                         data_acbc(i,3)==11 & data_acbc(i,6)==11 & data_acbc(i,10)==11 & data_acbc(i,13)~=11;
                         data_acbc(i,3)==11 & data_acbc(i,8)==11 & data_acbc(i,10)==11 & data_acbc(i,14)~=11;
                         data_acbc(i,6)==11 & data_acbc(i,8)==11 & data_acbc(i,10)==11 & data_acbc(i,15)~=11;
                         data_acbc(i,3)==11 & data_acbc(i,6)==11 & data_acbc(i,8)==11 & data_acbc(i,10)==11 & data_acbc(i,16)~=11;

                         data_acbc(i,4)==13 & data_acbc(i,7)==13 & data_acbc(i,9)==13 & data_acbc(i,12)~=13;
                         data_acbc(i,4)==13 & data_acbc(i,7)==13 & data_acbc(i,10)==13 & data_acbc(i,13)~=13;
                         data_acbc(i,4)==13 & data_acbc(i,9)==13 & data_acbc(i,10)==13 & data_acbc(i,14)~=13;
                         data_acbc(i,7)==13 & data_acbc(i,9)==13 & data_acbc(i,10)==13 & data_acbc(i,15)~=13;
                         data_acbc(i,4)==13 & data_acbc(i,7)==13 & data_acbc(i,9)==13 & data_acbc(i,10)==13 & data_acbc(i,16)~=13;                         
                         ];   
end
for i=1:size(data_acbc,1)
AC(i,1) = sum(always_chosen(:,i));
end
end