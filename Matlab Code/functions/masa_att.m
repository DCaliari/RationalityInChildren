function Attention_pref = masa_att(NEW)

Attention_pref = zeros(4,4,size(NEW,1));
for i=1:size(NEW,1)
    if NEW{i,1}(7,5)==1 && NEW{i,1}(1,5)==2
        Attention_pref(1,3,i)=Attention_pref(1,3,i)+1;
    elseif NEW{i,1}(7,5)==1 && NEW{i,1}(2,5)==3
        Attention_pref(1,2,i)=Attention_pref(1,2,i)+1;
    elseif NEW{i,1}(7,5)==2 && NEW{i,1}(1,5)==1
        Attention_pref(2,3,i)=Attention_pref(2,3,i)+1;
    elseif NEW{i,1}(7,5)==2 && NEW{i,1}(4,5)==3
        Attention_pref(2,1,i)=Attention_pref(2,1,i)+1;
    elseif NEW{i,1}(7,5)==3 && NEW{i,1}(2,5)==1
        Attention_pref(3,2,i)=Attention_pref(3,2,i)+1;
    elseif NEW{i,1}(7,5)==3 && NEW{i,1}(4,5)==2
        Attention_pref(3,1,i)=Attention_pref(3,1,i)+1;
    end
    if NEW{i,1}(8,5)==1 && NEW{i,1}(1,5)==2
        Attention_pref(1,4,i)=Attention_pref(1,4,i)+1;
    elseif NEW{i,1}(8,5)==1 && NEW{i,1}(3,5)==4
        Attention_pref(1,2,i)=Attention_pref(1,2,i)+1;
    elseif NEW{i,1}(8,5)==2 && NEW{i,1}(1,5)==1
        Attention_pref(2,4,i)=Attention_pref(2,4,i)+1;
    elseif NEW{i,1}(8,5)==2 && NEW{i,1}(5,5)==4
        Attention_pref(2,1,i)=Attention_pref(2,1,i)+1;
    elseif NEW{i,1}(8,5)==4 && NEW{i,1}(3,5)==1
        Attention_pref(4,2,i)=Attention_pref(4,2,i)+1;
    elseif NEW{i,1}(8,5)==4 && NEW{i,1}(5,5)==2
        Attention_pref(4,1,i)=Attention_pref(4,1,i)+1;
    end
    if NEW{i,1}(9,5)==1 && NEW{i,1}(2,5)==3
        Attention_pref(1,4,i)=Attention_pref(1,4,i)+1;
    elseif NEW{i,1}(9,5)==1 && NEW{i,1}(3,5)==4
        Attention_pref(1,3,i)=Attention_pref(1,3,i)+1;
    elseif NEW{i,1}(9,5)==3 && NEW{i,1}(2,5)==1
        Attention_pref(3,4,i)=Attention_pref(3,4,i)+1;
    elseif NEW{i,1}(9,5)==3 && NEW{i,1}(6,5)==4
        Attention_pref(3,1,i)=Attention_pref(3,1,i)+1;
    elseif NEW{i,1}(9,5)==4 && NEW{i,1}(3,5)==1
        Attention_pref(4,3,i)=Attention_pref(4,3,i)+1;
    elseif NEW{i,1}(9,5)==4 && NEW{i,1}(6,5)==3
        Attention_pref(4,1,i)=Attention_pref(4,1,i)+1;
    end
    if NEW{i,1}(10,5)==2 && NEW{i,1}(4,5)==3
        Attention_pref(2,4,i)=Attention_pref(2,4,i)+1;
    elseif NEW{i,1}(10,5)==2 && NEW{i,1}(5,5)==4
        Attention_pref(2,3,i)=Attention_pref(2,3,i)+1;
    elseif NEW{i,1}(10,5)==3 && NEW{i,1}(4,5)==2
        Attention_pref(3,4,i)=Attention_pref(3,4,i)+1;
    elseif NEW{i,1}(10,5)==3 && NEW{i,1}(6,5)==4
        Attention_pref(3,2,i)=Attention_pref(3,2,i)+1;
    elseif NEW{i,1}(10,5)==4 && NEW{i,1}(5,5)==2
        Attention_pref(4,3,i)=Attention_pref(4,3,i)+1;
    elseif NEW{i,1}(10,5)==4 && NEW{i,1}(6,5)==3
        Attention_pref(4,2,i)=Attention_pref(4,2,i)+1;
    end
    if NEW{i,1}(11,5)==1 && (NEW{i,1}(7,5)==2 || NEW{i,1}(7,5)==3)
        Attention_pref(1,4,i)=Attention_pref(1,4,i)+1;
    elseif NEW{i,1}(11,5)==1 && (NEW{i,1}(8,5)==2 || NEW{i,1}(8,5)==4)
        Attention_pref(1,3,i)=Attention_pref(1,3,i)+1;
    elseif NEW{i,1}(11,5)==1 && (NEW{i,1}(9,5)==3 || NEW{i,1}(9,5)==4)
        Attention_pref(1,2,i)=Attention_pref(1,2,i)+1;
    elseif NEW{i,1}(11,5)==2 && (NEW{i,1}(7,5)==1 || NEW{i,1}(7,5)==3)
        Attention_pref(2,4,i)=Attention_pref(2,4,i)+1;
    elseif NEW{i,1}(11,5)==2 && (NEW{i,1}(8,5)==1 || NEW{i,1}(8,5)==4)
        Attention_pref(2,3,i)=Attention_pref(2,3,i)+1;
    elseif NEW{i,1}(11,5)==2 && (NEW{i,1}(10,5)==3 || NEW{i,1}(10,5)==4)
        Attention_pref(2,1,i)=Attention_pref(2,1,i)+1;
    elseif NEW{i,1}(11,5)==3 && (NEW{i,1}(7,5)==1 || NEW{i,1}(7,5)==2)
        Attention_pref(3,4,i)=Attention_pref(3,4,i)+1;
    elseif NEW{i,1}(11,5)==3 && (NEW{i,1}(9,5)==1 || NEW{i,1}(9,5)==4)
        Attention_pref(3,2,i)=Attention_pref(3,2,i)+1;
    elseif NEW{i,1}(11,5)==3 && (NEW{i,1}(10,5)==2 || NEW{i,1}(10,5)==4)
        Attention_pref(3,1,i)=Attention_pref(3,1,i)+1;     
    elseif NEW{i,1}(11,5)==4 && (NEW{i,1}(8,5)==1 || NEW{i,1}(8,5)==2)
        Attention_pref(4,3,i)=Attention_pref(4,3,i)+1;
    elseif NEW{i,1}(11,5)==4 && (NEW{i,1}(9,5)==1 || NEW{i,1}(9,5)==3)
        Attention_pref(4,2,i)=Attention_pref(4,2,i)+1;
    elseif NEW{i,1}(11,5)==4 && (NEW{i,1}(10,5)==2 || NEW{i,1}(10,5)==3)
        Attention_pref(4,1,i)=Attention_pref(4,1,i)+1;    
    end
end

end