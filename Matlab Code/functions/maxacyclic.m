function M_ACYCLIC = maxacyclic(Revealed,Na,Nc)

M_ACYCLIC= zeros(Na,Na,Nc);

for z=1:Nc   %%%%%%% I am creating the maximum acyclic relation that rationalize the choice function
    if Revealed(z,1)==1
        M_ACYCLIC(2,1,z)=1;
    else
        M_ACYCLIC(1,2,z)=1;
    end
    if Revealed(z,2)==1
        M_ACYCLIC(3,1,z)=1;
    else
        M_ACYCLIC(1,3,z)=1;
    end
    if Revealed(z,3)==1
        M_ACYCLIC(4,1,z)=1;
    else
        M_ACYCLIC(1,4,z)=1;
    end
    if Revealed(z,4)==2
        M_ACYCLIC(3,2,z)=1;
    else
        M_ACYCLIC(2,3,z)=1;
    end
    if Revealed(z,5)==2
        M_ACYCLIC(4,2,z)=1;
    else
        M_ACYCLIC(2,4,z)=1;
    end
    if Revealed(z,6)==3
        M_ACYCLIC(4,3,z)=1;
    else
        M_ACYCLIC(3,4,z)=1;
    end
    if Revealed(z,7)==1
        M_ACYCLIC(2,1,z)=1;
        M_ACYCLIC(3,1,z)=1;
    elseif Revealed(z,7)==2
        M_ACYCLIC(1,2,z)=1;
        M_ACYCLIC(3,2,z)=1;    
    else
        M_ACYCLIC(1,3,z)=1;
        M_ACYCLIC(2,3,z)=1;    
    end
    if Revealed(z,8)==1
        M_ACYCLIC(2,1,z)=1;
        M_ACYCLIC(4,1,z)=1;
    elseif Revealed(z,8)==2
        M_ACYCLIC(1,2,z)=1;
        M_ACYCLIC(4,2,z)=1;    
    else
        M_ACYCLIC(1,4,z)=1;
        M_ACYCLIC(2,4,z)=1;    
    end
    if Revealed(z,9)==1
        M_ACYCLIC(3,1,z)=1;
        M_ACYCLIC(4,1,z)=1;
    elseif Revealed(z,9)==3
        M_ACYCLIC(1,3,z)=1;
        M_ACYCLIC(4,3,z)=1;    
    else
        M_ACYCLIC(1,4,z)=1;
        M_ACYCLIC(3,4,z)=1;    
    end
    if Revealed(z,10)==2
        M_ACYCLIC(3,2,z)=1;
        M_ACYCLIC(4,2,z)=1;
    elseif Revealed(z,10)==3
        M_ACYCLIC(2,3,z)=1;
        M_ACYCLIC(4,3,z)=1;    
    else
        M_ACYCLIC(2,4,z)=1;
        M_ACYCLIC(3,4,z)=1;    
    end  
    if Revealed(z,11)==1
        M_ACYCLIC(2,1,z)=1;
        M_ACYCLIC(3,1,z)=1;
        M_ACYCLIC(4,1,z)=1;
    elseif Revealed(z,11)==2
        M_ACYCLIC(1,2,z)=1;
        M_ACYCLIC(3,2,z)=1;
        M_ACYCLIC(4,2,z)=1;    
    elseif Revealed(z,11)==3
        M_ACYCLIC(1,3,z)=1;
        M_ACYCLIC(2,3,z)=1;
        M_ACYCLIC(4,3,z)=1;           
    else
        M_ACYCLIC(1,4,z)=1;
        M_ACYCLIC(2,4,z)=1;
        M_ACYCLIC(3,4,z)=1; 
    end     
end
end