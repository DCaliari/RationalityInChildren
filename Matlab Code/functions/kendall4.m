function kt = kendall4(n,A,B)

kt=zeros(n,1);
for i=1:n
       t1= find(A(i,:)==1)<find(A(i,:)==2);
       t2= find(B(i,:)==1)<find(B(i,:)==2);
       kt(i) = double(t1~=t2); 
       t1= find(A(i,:)==1)<find(A(i,:)==3);
       t2= find(B(i,:)==1)<find(B(i,:)==3);
       kt(i)=kt(i)+double(t1~=t2);
       t1= find(A(i,:)==1)<find(A(i,:)==4);
       t2= find(B(i,:)==1)<find(B(i,:)==4);
       kt(i)=kt(i)+double(t1~=t2);
       t1= find(A(i,:)==2)<find(A(i,:)==3);
       t2= find(B(i,:)==2)<find(B(i,:)==3);       
       kt(i)=kt(i)+double(t1~=t2);
       t1= find(A(i,:)==2)<find(A(i,:)==4);
       t2= find(B(i,:)==2)<find(B(i,:)==4);       
       kt(i)=kt(i)+double(t1~=t2);
       t1= find(A(i,:)==3)<find(A(i,:)==4);
       t2= find(B(i,:)==3)<find(B(i,:)==4);       
       kt(i)=kt(i)+double(t1~=t2);
end
end