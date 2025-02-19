function [alpha23, alpha24, alpha34] = alpha(NEW)

for i=1:size(NEW,1)
    if NEW{i,1}(7,5)==1
        alpha23(1,i) = NEW{i,1}(1,5) ~= 1;
        alpha23(2,i) = NEW{i,1}(2,5) ~= 1;
    elseif NEW{i,1}(7,5)==2
        alpha23(3,i) = NEW{i,1}(1,5) ~= 2;
        alpha23(4,i) = NEW{i,1}(4,5) ~= 2;
    elseif NEW{i,1}(7,5)==3
        alpha23(5,i) = NEW{i,1}(2,5) ~= 3;
        alpha23(6,i) = NEW{i,1}(4,5) ~= 3;        
    end
    if NEW{i,1}(8,5)==1
        alpha23(7,i) = NEW{i,1}(1,5) ~= 1;
        alpha23(8,i) = NEW{i,1}(3,5) ~= 1;
    elseif NEW{i,1}(8,5)==2
        alpha23(9,i) = NEW{i,1}(1,5) ~= 2;
        alpha23(10,i) = NEW{i,1}(5,5) ~= 2;
    elseif NEW{i,1}(8,5)==4
        alpha23(11,i) = NEW{i,1}(3,5) ~= 4;
        alpha23(12,i) = NEW{i,1}(5,5) ~= 4;        
    end
    if NEW{i,1}(9,5)==1
        alpha23(13,i) = NEW{i,1}(2,5) ~= 1;
        alpha23(14,i) = NEW{i,1}(3,5) ~= 1;
    elseif NEW{i,1}(9,5)==3
        alpha23(15,i) = NEW{i,1}(2,5) ~= 3;
        alpha23(16,i) = NEW{i,1}(6,5) ~= 3;
    elseif NEW{i,1}(9,5)==4
        alpha23(17,i) = NEW{i,1}(3,5) ~= 4;
        alpha23(18,i) = NEW{i,1}(6,5) ~= 4;        
    end
    if NEW{i,1}(10,5)==2
        alpha23(19,i) = NEW{i,1}(4,5) ~= 2;
        alpha23(20,i) = NEW{i,1}(5,5) ~= 2;
    elseif NEW{i,1}(10,5)==3
        alpha23(21,i) = NEW{i,1}(4,5) ~= 3;
        alpha23(22,i) = NEW{i,1}(6,5) ~= 3;
    elseif NEW{i,1}(10,5)==4
        alpha23(23,i) = NEW{i,1}(5,5) ~= 4;
        alpha23(24,i) = NEW{i,1}(6,5) ~= 4;        
    end    
end

for i=1:size(NEW,1)
    if NEW{i,1}(11,5)==1
        alpha4(1,i) = NEW{i,1}(1,5) ~= 1;
        alpha4(2,i) = NEW{i,1}(2,5) ~= 1;
        alpha4(3,i) = NEW{i,1}(3,5) ~= 1;  
        alpha4(4,i) = NEW{i,1}(7,5) ~= 1;  
        alpha4(5,i) = NEW{i,1}(8,5) ~= 1;
        alpha4(6,i) = NEW{i,1}(9,5) ~= 1;  
    elseif NEW{i,1}(11,5)==2
        alpha4(7,i) = NEW{i,1}(1,5) ~= 2;
        alpha4(8,i) = NEW{i,1}(4,5) ~= 2;
        alpha4(9,i) = NEW{i,1}(5,5) ~= 2;  
        alpha4(10,i) = NEW{i,1}(7,5) ~= 2;  
        alpha4(11,i) = NEW{i,1}(8,5) ~= 2;
        alpha4(12,i) = NEW{i,1}(10,5) ~= 2; 
    elseif NEW{i,1}(11,5)==3
        alpha4(13,i) = NEW{i,1}(2,5) ~= 3;
        alpha4(14,i) = NEW{i,1}(4,5) ~= 3;
        alpha4(15,i) = NEW{i,1}(6,5) ~= 3;  
        alpha4(16,i) = NEW{i,1}(7,5) ~= 3;  
        alpha4(17,i) = NEW{i,1}(9,5) ~= 3;
        alpha4(18,i) = NEW{i,1}(10,5) ~= 3;  
    elseif NEW{i,1}(11,5)==4
        alpha4(19,i) = NEW{i,1}(3,5) ~= 4;
        alpha4(20,i) = NEW{i,1}(5,5) ~= 4;
        alpha4(21,i) = NEW{i,1}(6,5) ~= 4;  
        alpha4(22,i) = NEW{i,1}(8,5) ~= 4;  
        alpha4(23,i) = NEW{i,1}(9,5) ~= 4;
        alpha4(24,i) = NEW{i,1}(10,5) ~= 4;          
    end
end

for i=1:size(NEW,1)
    if NEW{i,1}(11,5)==1
        alpha24(1,i) = NEW{i,1}(1,5) ~= 1;
        alpha24(2,i) = NEW{i,1}(2,5) ~= 1;
        alpha24(3,i) = NEW{i,1}(3,5) ~= 1;  
    elseif NEW{i,1}(11,5)==2
        alpha24(4,i) = NEW{i,1}(1,5) ~= 2;
        alpha24(5,i) = NEW{i,1}(4,5) ~= 2;
        alpha24(6,i) = NEW{i,1}(5,5) ~= 2;  
    elseif NEW{i,1}(11,5)==3
        alpha24(7,i) = NEW{i,1}(2,5) ~= 3;
        alpha24(8,i) = NEW{i,1}(4,5) ~= 3;
        alpha24(9,i) = NEW{i,1}(6,5) ~= 3;   
    elseif NEW{i,1}(11,5)==4
        alpha24(10,i) = NEW{i,1}(3,5) ~= 4;
        alpha24(11,i) = NEW{i,1}(5,5) ~= 4;
        alpha24(12,i) = NEW{i,1}(6,5) ~= 4;          
    end
end

for i=1:size(NEW,1)
    if NEW{i,1}(11,5)==1
        alpha34(1,i) = NEW{i,1}(7,5) ~= 1;  
        alpha34(2,i) = NEW{i,1}(8,5) ~= 1;
        alpha34(3,i) = NEW{i,1}(9,5) ~= 1;  
    elseif NEW{i,1}(11,5)==2
        alpha34(4,i) = NEW{i,1}(7,5) ~= 2;  
        alpha34(5,i) = NEW{i,1}(8,5) ~= 2;
        alpha34(6,i) = NEW{i,1}(10,5) ~= 2; 
    elseif NEW{i,1}(11,5)==3
        alpha34(7,i) = NEW{i,1}(7,5) ~= 3;  
        alpha34(8,i) = NEW{i,1}(9,5) ~= 3;
        alpha34(9,i) = NEW{i,1}(10,5) ~= 3;  
    elseif NEW{i,1}(11,5)==4
        alpha34(10,i) = NEW{i,1}(8,5) ~= 4;  
        alpha34(11,i) = NEW{i,1}(9,5) ~= 4;
        alpha34(12,i) = NEW{i,1}(10,5) ~= 4;          
    end
end
end