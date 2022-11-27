clc;
close all;

t=(0:200)';
nt= numel(t);
y=zeros(size(t));
x=(t<=100);
y(x)=pi*t(x);
x=t>100;
y(t>100)=y(100)+0.1*pi*(t(x)-100);
y=-y+8*randn(nt,1);

close all
plot(t,y,'.');

thetha=[1.5;3]; % slope and intercept
rls=recursiveLS(2,single(thetha));
rls.ForgettingFactor=0.95;
ax=gca;

fcn=@(p) [ones(numel(t),1),t]*p;
ly=line('parent',ax,'xdata',t,'ydata',fcn(thetha),'color','r');
lx=line('parent',ax,'xdata',[t(1) t(1)],'ydata',[min(y) 1.1*max(y)]);

for ct=1:nt
    thetha= step(rls,y(ct),[1 t(ct)]);
    set(ly,'xdata',t,'ydata',fcn(thetha));
    set(lx,'xdata',[t(ct) t(ct)],'ydata',[min(y),1,1*max(y)]);
    pause(0.1)
end

    
    