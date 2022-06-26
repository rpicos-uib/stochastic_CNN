R=1;
C=0.01;


w=1:1000;


Z=R./(1+(1i)*w.*R.*C);

close all;
loglog(w,abs(Z))
hold on

R=2;
Z=R./(1+(1i)*w.*R.*C);
loglog(w,abs(Z))

R=4;
Z=R./(1+(1i)*w.*R.*C);
loglog(w,abs(Z))

figure()

loglog(w,angle(Z))
