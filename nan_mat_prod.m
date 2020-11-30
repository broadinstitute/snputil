function res=nan_mat_prod(X,Y)
% nan-aware matrix product

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

X(isnan(X))=0;
Y(isnan(Y))=0;
res=X*Y;

