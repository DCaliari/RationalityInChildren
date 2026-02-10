function [AC,BC,OneBest] = AC_BC(data)

BINARYSETS=data(1:6,:);

binary_pref = zeros(4,4,size(data,2));
for i=1:size(data,2)
    binary_pref(:,:,i) = [0, BINARYSETS(1,i)==1 BINARYSETS(2,i)==1 BINARYSETS(3,i)==1;
                            BINARYSETS(1,i)==2 0 BINARYSETS(4,i)==2 BINARYSETS(5,i)==2;
                            BINARYSETS(2,i)==3 BINARYSETS(4,i)==3 0 BINARYSETS(6,i)==3;
                            BINARYSETS(3,i)==4 BINARYSETS(5,i)==4 BINARYSETS(6,i)==4 0];
end
% cycles
for i=1:size(data,2)
    binarygraph{i,1}=digraph(binary_pref(:,:,i));
    OneBest(i,1) = max(sum(binary_pref(:,:,i),2)==3);
    BC(i,1) = length(allcycles(binarygraph{i,1}));
end

for i=1:size(data,2)
   always_chosen(:,i) = [data(1,i)==1 & data(2,i)==1 & data(7,i)~=1;
                         data(1,i)==2 & data(4,i)==2 & data(7,i)~=2;
                         data(2,i)==3 & data(4,i)==3 & data(7,i)~=3;

                         data(1,i)==1 & data(3,i)==1 & data(8,i)~=1;
                         data(1,i)==2 & data(5,i)==2 & data(8,i)~=2;
                         data(3,i)==4 & data(5,i)==4 & data(8,i)~=4;

                         data(2,i)==1 & data(3,i)==1 & data(9,i)~=1;
                         data(2,i)==3 & data(6,i)==3 & data(9,i)~=3;
                         data(3,i)==4 & data(6,i)==4 & data(9,i)~=4;

                         data(4,i)==2 & data(5,i)==2 & data(10,i)~=2;
                         data(4,i)==3 & data(6,i)==3 & data(10,i)~=3;
                         data(5,i)==4 & data(6,i)==4 & data(10,i)~=4;

                         data(1,i)==1 & data(2,i)==1 & data(3,i)==1 & data(11,i)~=1;
                         data(1,i)==2 & data(4,i)==2 & data(5,i)==2 & data(11,i)~=2;
                         data(2,i)==3 & data(4,i)==3 & data(6,i)==3 & data(11,i)~=3;
                         data(3,i)==4 & data(5,i)==4 & data(6,i)==4 & data(11,i)~=4; 
   ];   
end
for i=1:size(data,2)
AC(i,1) = sum(always_chosen(:,i));
end
end