function [loacker_max,nutella_max,oreo_max,ringo_max,loacker_nd,nutella_nd,oreo_nd,ringo_nd,loacker_rd,nutella_rd,oreo_rd,ringo_rd,loacker_th,nutella_th,oreo_th,ringo_th] = eig_value_position(cen,n)

for i=1:n
    loacker_max(i,1) = sum(find(cen(i,:)==max(cen(i,:)))==1)>0;
    nutella_max(i,1) = sum(find(cen(i,:)==max(cen(i,:)))==2)>0;
    oreo_max(i,1) = sum(find(cen(i,:)==max(cen(i,:)))==3)>0;
    ringo_max(i,1) = sum(find(cen(i,:)==max(cen(i,:)))==4)>0;
end

loacker_max = loacker_max.*cen(:,1);
nutella_max = nutella_max.*cen(:,2);
oreo_max = oreo_max.*cen(:,3);
ringo_max = ringo_max.*cen(:,4);

loacker_max(loacker_max==0)=[];
nutella_max(nutella_max==0)=[];
oreo_max(oreo_max==0)=[];
ringo_max(ringo_max==0)=[];

for i=1:n
    temp = sort(cen(i,:));
    temp = temp(1,3);
    loacker_nd(i,1) = sum(find(cen(i,:)==temp)==1)>0;
    nutella_nd(i,1) = sum(find(cen(i,:)==temp)==2)>0;
    oreo_nd(i,1)  = sum(find(cen(i,:)==temp)==3)>0;
    ringo_nd(i,1)   = sum(find(cen(i,:)==temp)==4)>0;
end

loacker_nd = loacker_nd.*cen(:,1);
nutella_nd = nutella_nd.*cen(:,2);
oreo_nd = oreo_nd.*cen(:,3);
ringo_nd = ringo_nd.*cen(:,4);

loacker_nd(loacker_nd==0)=[];
nutella_nd(nutella_nd==0)=[];
oreo_nd(oreo_nd==0)=[];
ringo_nd(ringo_nd==0)=[];

for i=1:n
    temp = sort(cen(i,:));
    temp = temp(1,2);
    loacker_rd(i,1) = sum(find(cen(i,:)==temp)==1)>0;
    nutella_rd(i,1) = sum(find(cen(i,:)==temp)==2)>0;
    oreo_rd(i,1)  = sum(find(cen(i,:)==temp)==3)>0;
    ringo_rd(i,1)   = sum(find(cen(i,:)==temp)==4)>0;
end

loacker_rd = loacker_rd.*cen(:,1);
nutella_rd = nutella_rd.*cen(:,2);
oreo_rd = oreo_rd.*cen(:,3);
ringo_rd = ringo_rd.*cen(:,4);

loacker_rd(loacker_rd==0)=[];
nutella_rd(nutella_rd==0)=[];
oreo_rd(oreo_rd==0)=[];
ringo_rd(ringo_rd==0)=[];
 

for i=1:n
    temp = sort(cen(i,:));
    temp = temp(1,1);
    loacker_th(i,1) = sum(find(cen(i,:)==temp)==1)>0;
    nutella_th(i,1) = sum(find(cen(i,:)==temp)==2)>0;
    oreo_th(i,1)  = sum(find(cen(i,:)==temp)==3)>0;
    ringo_th(i,1)   = sum(find(cen(i,:)==temp)==4)>0;
end

loacker_th = loacker_th.*cen(:,1);
nutella_th = nutella_th.*cen(:,2);
oreo_th = oreo_th.*cen(:,3);
ringo_th = ringo_th.*cen(:,4);

loacker_th(loacker_th==0)=[];
nutella_th(nutella_th==0)=[];
oreo_th(oreo_th==0)=[];
ringo_th(ringo_th==0)=[];