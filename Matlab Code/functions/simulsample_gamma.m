function sample = simulsample_gamma(pref, Q)

iter = 0;
for i = 1:size(pref,2)
       if pref(i)>0
       for z = 1: pref(i)
           iter = iter+1;
           sample(iter,:) = [mnrnd(1,Q(1:2,i)'),mnrnd(1,Q(3:4,i)'),mnrnd(1,Q(5:6,i)'),mnrnd(1,Q(7:8,i)'),mnrnd(1,Q(9:10,i)'),mnrnd(1,Q(11:12,i)'),...
                                mnrnd(1,Q(13:15,i)'),mnrnd(1,Q(16:18,i)'),mnrnd(1,Q(19:21,i)'),mnrnd(1,Q(22:24,i)'),mnrnd(1,Q(25:28,i)')]';
       end
       end
end

end

    