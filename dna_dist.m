function d=dna_dist(vecs)
% unused dist() support

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

N=size(vecs,1);
g2=sum(vecs.*vecs,2);
try
  d=repmat(g2,1,N)-2*vecs*vecs'+repmat(g2',N,1);
  d=d-diag(diag(d));
  d=0.5*(d+d');
%  d(d<0)=0;
  d=sqrt(d);
catch
  disp('dna_dist: out of memory ... using dna_dist2');
  d=dna_dist2(vecs);
end
