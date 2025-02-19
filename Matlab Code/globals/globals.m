%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% GLOBAL VARIABLES - ATTENTION MODELS  %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% CHOICE STRUCTURE

R =[ 1     1     0     0
     1     0     1     0
     1     0     0     1
     0     1     1     0
     0     1     0     1
     0     0     1     1
     1     1     1     0
     1     1     0     1
     1     0     1     1
     0     1     1     1
     1     1     1     1]; 

%%%% PREFERENCES

PER = flipud(perms(1:4));

%%%% STRUCTURE CHOICES

STRUCTURE = [
    0,0,1,2;
    0,0,1,3;
    0,0,1,4;
    0,0,2,3;
    0,0,2,4;
    0,0,3,4;
    0,1,2,3;
    0,1,2,4;
    0,1,3,4;
    0,2,3,4;
    1,2,3,4];

%%% various sizes
sp=sum(sum(R)); % 28 elements in the choices across occasions
spp=prod(sum(R')); % 20736 size of the tensor
lc=factorial(4); % 24 number of latent classes (preferences types)
O=size(R,1); % 11 number of occasions

% matrix of elements in each subset
D=R.*kron(ones(O,1),1:4); 

% B describes the structure of the choice sets
d=sum(R,2);

B=blkdiag(ones(1,d(1)),ones(1,d(2)),ones(1,d(3)),ones(1,d(4)),ones(1,d(5)),ones(1,d(6)),ones(1,d(7)),ones(1,d(8)),...
ones(1,d(9)),ones(1,d(10)),ones(1,d(11)));


%%%% CATEGORIES FOR PENCILS AND PENS FOR PLOTS

CAT_PENCILS = categorical({'YellowPencil','RedPencil','OrangePencil','BluePencil'});
CAT_PEN = categorical({'YellowPen','RedPen','BluePen','GreenPen'});



