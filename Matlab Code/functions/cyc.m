function b = cyc(a)
b = zeros(size(a,2),2);
for i=1:size(a,2)
    if i<size(a,2)
    b(i,1)=a(i);
    b(i,2)=a(i+1);
    elseif i==size(a,2)
    b(i,1)=a(i);
    b(i,2)=a(1);
    end
end
end