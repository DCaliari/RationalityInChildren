function support = supp(likelihood, DATA, preferences, N)

support = repmat(likelihood,1,N);

for i=1:N
    for z=1:length(likelihood)
        if (DATA(i,1)==1 || DATA(i,7)==1 || DATA(i,8)==1 ||DATA(i,11)==1) && preferences(2,1,z)==1
            support(z,i)=0;
        end
        if (DATA(i,1)==2 || DATA(i,7)==2 || DATA(i,8)==2 ||DATA(i,11)==2) && preferences(1,2,z)==1
            support(z,i)=0;
        end
        if (DATA(i,2)==1 || DATA(i,7)==1 || DATA(i,9)==1 ||DATA(i,11)==1) && preferences(3,1,z)==1
            support(z,i)=0;
        end
        if (DATA(i,2)==3 || DATA(i,7)==3 || DATA(i,9)==3 ||DATA(i,11)==3) && preferences(1,3,z)==1
            support(z,i)=0;
        end        
        if (DATA(i,3)==1 || DATA(i,8)==1 || DATA(i,9)==1 ||DATA(i,11)==1) && preferences(4,1,z)==1
            support(z,i)=0;
        end        
        if (DATA(i,3)==4 || DATA(i,8)==4 || DATA(i,9)==4 ||DATA(i,11)==4) && preferences(1,4,z)==1
            support(z,i)=0;
        end     
        if (DATA(i,4)==2 || DATA(i,7)==2 || DATA(i,10)==2 ||DATA(i,11)==2) && preferences(3,2,z)==1
            support(z,i)=0;
        end   
        if (DATA(i,4)==3 || DATA(i,7)==3 || DATA(i,10)==3 ||DATA(i,11)==3) && preferences(2,3,z)==1
            support(z,i)=0;
        end          
        if (DATA(i,5)==2 || DATA(i,8)==2 || DATA(i,10)==2 ||DATA(i,11)==2) && preferences(4,2,z)==1
            support(z,i)=0;
        end   
        if (DATA(i,5)==4 || DATA(i,8)==4 || DATA(i,10)==4 ||DATA(i,11)==4) && preferences(2,4,z)==1
            support(z,i)=0;
        end     
        if (DATA(i,6)==3 || DATA(i,9)==3 || DATA(i,10)==3 ||DATA(i,11)==3) && preferences(4,3,z)==1
            support(z,i)=0;
        end 
        if (DATA(i,6)==4 || DATA(i,9)==4 || DATA(i,10)==4 ||DATA(i,11)==4) && preferences(3,4,z)==1
            support(z,i)=0;
        end 
    end
end

end