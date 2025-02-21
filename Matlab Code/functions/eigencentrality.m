function x=eigencentrality(adj)
[V,D]=eig(adj);
[max_eig,ind]=max(diag(D));
x=V(:,ind);
end
