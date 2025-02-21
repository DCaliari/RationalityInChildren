function RationalChoices = rational(linear)
    RationalChoices = zeros(24,11);
for i=1:24
    for j = 1:11
        if linear(1,2,i)==1
            RationalChoices(i,1)=1;
        else, RationalChoices(i,1)=2;
        end
        if linear(1,3,i)==1
            RationalChoices(i,2)=1;
        else, RationalChoices(i,2)=3;
        end
        if linear(1,4,i)==1
            RationalChoices(i,3)=1;
        else, RationalChoices(i,3)=4;
        end        
        if linear(2,3,i)==1
            RationalChoices(i,4)=2;
        else, RationalChoices(i,4)=3;
        end  
        if linear(2,4,i)==1
            RationalChoices(i,5)=2;
        else, RationalChoices(i,5)=4;
        end            
        if linear(3,4,i)==1
            RationalChoices(i,6)=3;
        else, RationalChoices(i,6)=4;
        end    
        if linear(1,2,i)==1 && linear(1,3,i)==1
            RationalChoices(i,7)=1;
        elseif linear(2,1,i)==1 && linear(2,3,i)==1 
            RationalChoices(i,7)=2;
        elseif linear(3,1,i)==1 && linear(3,2,i)==1 
            RationalChoices(i,7)=3;
        end 
        if linear(1,2,i)==1 && linear(1,4,i)==1
            RationalChoices(i,8)=1;
        elseif linear(2,1,i)==1 && linear(2,4,i)==1 
            RationalChoices(i,8)=2;
        elseif linear(4,1,i)==1 && linear(4,2,i)==1 
            RationalChoices(i,8)=4;
        end    
        if linear(1,3,i)==1 && linear(1,4,i)==1
            RationalChoices(i,9)=1;
        elseif linear(3,1,i)==1 && linear(3,4,i)==1 
            RationalChoices(i,9)=3;
        elseif linear(4,1,i)==1 && linear(4,3,i)==1 
            RationalChoices(i,9)=4;
        end    
        if linear(2,3,i)==1 && linear(2,4,i)==1
            RationalChoices(i,10)=2;
        elseif linear(3,2,i)==1 && linear(3,4,i)==1 
            RationalChoices(i,10)=3;
        elseif linear(4,2,i)==1 && linear(4,3,i)==1 
            RationalChoices(i,10)=4;
        end      
        if sum(linear(1,:,i))==3
            RationalChoices(i,11)=1;
        elseif sum(linear(2,:,i))==3 
            RationalChoices(i,11)=2;
        elseif sum(linear(3,:,i))==3
            RationalChoices(i,11)=3;
        else, RationalChoices(i,11)=4;
        end     
    end
end
end
