function [gamma23, gamma24, gamma34] = sen_gamma(NEW)

for i=1:size(NEW,1)
    gamma23(1,i)= NEW{i,1}(1,5)==NEW{i,1}(2,5) & NEW{i,1}(1,5)~=NEW{i,1}(7,5); % (ab)(ac) to (abc)
    gamma23(2,i)= NEW{i,1}(1,5)==NEW{i,1}(3,5) & NEW{i,1}(1,5)~=NEW{i,1}(8,5); % (ab)(ad) to (abd)
    gamma23(3,i)= NEW{i,1}(2,5)==NEW{i,1}(3,5) & NEW{i,1}(2,5)~=NEW{i,1}(9,5); % (ac)(ad) to (acd)
    gamma23(4,i)= NEW{i,1}(1,5)==NEW{i,1}(4,5) & NEW{i,1}(1,5)~=NEW{i,1}(7,5); % (ab)(bc) to (abc)
    gamma23(5,i)= NEW{i,1}(1,5)==NEW{i,1}(5,5) & NEW{i,1}(1,5)~=NEW{i,1}(8,5); % (ab)(bd) to (abd)
    gamma23(6,i)= NEW{i,1}(2,5)==NEW{i,1}(6,5) & NEW{i,1}(2,5)~=NEW{i,1}(9,5); % (ac)(cd) to (acd)
    gamma23(7,i)= NEW{i,1}(2,5)==NEW{i,1}(4,5) & NEW{i,1}(2,5)~=NEW{i,1}(7,5); % (ac)(bc) to (abc)
    gamma23(8,i)= NEW{i,1}(3,5)==NEW{i,1}(5,5) & NEW{i,1}(3,5)~=NEW{i,1}(8,5); % (ad)(bd) to (abd)
    gamma23(9,i)= NEW{i,1}(3,5)==NEW{i,1}(6,5) & NEW{i,1}(3,5)~=NEW{i,1}(9,5); % (ac)(cd) to (acd)
    gamma23(10,i)= NEW{i,1}(4,5)==NEW{i,1}(6,5) & NEW{i,1}(4,5)~=NEW{i,1}(10,5); % (bc)(cd) to (bcd)
    gamma23(11,i)= NEW{i,1}(5,5)==NEW{i,1}(6,5) & NEW{i,1}(5,5)~=NEW{i,1}(10,5); % (bd)(cd) to (bcd)
    gamma23(12,i)= NEW{i,1}(4,5)==NEW{i,1}(5,5) & NEW{i,1}(4,5)~=NEW{i,1}(10,5); % (bc)(bd) to (bcd)

    gamma34(1,i)= NEW{i,1}(7,5)==NEW{i,1}(8,5) & NEW{i,1}(7,5)~=NEW{i,1}(11,5);
    gamma34(2,i)= NEW{i,1}(7,5)==NEW{i,1}(10,5) & NEW{i,1}(7,5)~=NEW{i,1}(11,5);
    gamma34(3,i)= NEW{i,1}(7,5)==NEW{i,1}(9,5) & NEW{i,1}(7,5)~=NEW{i,1}(11,5);
    gamma34(4,i)= NEW{i,1}(8,5)==NEW{i,1}(9,5) & NEW{i,1}(8,5)~=NEW{i,1}(11,5);
    gamma34(5,i)= NEW{i,1}(8,5)==NEW{i,1}(10,5) & NEW{i,1}(8,5)~=NEW{i,1}(11,5);
    gamma34(6,i)= NEW{i,1}(9,5)==NEW{i,1}(10,5) & NEW{i,1}(9,5)~=NEW{i,1}(11,5);

    gamma24(1,i)= NEW{i,1}(1,5)==NEW{i,1}(2,5) & NEW{i,1}(1,5)==NEW{i,1}(3,5) & NEW{i,1}(1,5)~=NEW{i,1}(11,5);
    gamma24(2,i)= NEW{i,1}(1,5)==NEW{i,1}(4,5) & NEW{i,1}(1,5)==NEW{i,1}(5,5) & NEW{i,1}(1,5)~=NEW{i,1}(11,5);
    gamma24(3,i)= NEW{i,1}(2,5)==NEW{i,1}(4,5) & NEW{i,1}(2,5)==NEW{i,1}(6,5) & NEW{i,1}(2,5)~=NEW{i,1}(11,5);
    gamma24(4,i)= NEW{i,1}(3,5)==NEW{i,1}(5,5) & NEW{i,1}(3,5)==NEW{i,1}(6,5) & NEW{i,1}(3,5)~=NEW{i,1}(11,5);
end
end