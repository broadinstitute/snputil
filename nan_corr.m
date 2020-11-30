function rho=nan_corr(X,Y)
% nan-aware Pearson correlation calculation?

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

Yp=Y';
n=double(~isnan(X))*double(~isnan(Yp));
sx=nan_mat_prod(X,double(~isnan(Yp)));
sy=nan_mat_prod(double(~isnan(X)),Yp);
xy=nan_mat_prod(X,Yp);

sx2=nan_mat_prod(X.^2,double(~isnan(Yp)));
sy2=nan_mat_prod(double(~isnan(X)),Yp.^2);


rho=(xy-sx.*sy./n)./sqrt((sx2-(sx.^2)./n).*(sy2-(sy.^2)./n));
      
return

% TEST

rho2=zeros(size(X,1),size(Y,1));
for i=1:size(X,1)
  for j=1:size(Y,1)
    nonnan=find(~isnan(X(i,:)+Y(j,:)));
    rho2(i,j)=corr(X(i,nonnan)',Y(j,nonnan)');
  end
end
