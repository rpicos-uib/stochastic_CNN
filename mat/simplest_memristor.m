function simplest_memristor()

close all;
v=[];
g0=0.1;
v_cycle=-1:0.01:1;
dt=0.5;

N_cycles=10;

for i=1:N_cycles
    v=[v v_cycle];
    v_cycle=flip(v_cycle);
end

% figure(1)
% plot(v);
% 
% figure(2)
f=cumtrapz(v)*dt;
% plot(f);
% 
% figure(3)
% plot(f,g(v,f));



figure(4)
plot(v,v.*g(0,f));
xlabel('V_{in} (V)');
ylabel('I (mA)');
grid on
hold on
ll=2*length(v)/N_cycles;
ind=1:ceil(ll/100):ll;
plot(v(ind),v(ind).*g(0,f(ind)),'bo');


dt=0.05;
f=cumtrapz(v)*dt;
plot(v,v.*g(0,f),'g');
plot(v(ind),v(ind).*g(0,f(ind)),'gx');


dt=1.0;
f=cumtrapz(v)*dt;
plot(v,v.*g(0,f),'r');
plot(v(ind),v(ind).*g(0,f(ind)),'rd');




    function gg=g(v,f)
        gg = 0.1*g0+max(0,g0*(1+0.1*f));
    end


end