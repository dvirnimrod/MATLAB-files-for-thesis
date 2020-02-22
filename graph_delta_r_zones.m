% Graph the difference between the optimal profit under the two policies as
% a fuction of the system's parameters.

% Parameters:
global mu1 mu2 Cw;
mu1 = 1;
mu2 = 1;
Cw = 1;

% Resolution, scope and initialization:
V = [1:0.5:14.5,15:1:55,56:2:100,105:5:150];
Cs = [0.5,0.999,1.5:0.5:20,21:150];
rMd = zeros(length(V),length(Cs));
zones = zeros(length(V),length(Cs));

% Calculating the values:
for v=1:length(V)
    flag1 = false;
    flag2 = false;
    for c=1:length(Cs)
        if flag1 == false
        	[~,~,~,r1,flag1] = Opt_Val(Cs(c),V(v));
        else
            r1 = 0;
        end     
        if flag2 == false
        	[~,~,~,r2,flag2] = Opt_Val2(Cs(c),V(v));
        else
            r2 = 0;
        end
        if abs(r1-r2)<10^-5
            rMd(v,c) = 0;
        else
            rMd(v,c) = r1-r2;
        end
        if r1==0 && r2==0
            zones(v,c)=Inf;
        end
        if r1==0 && r2>0
            zones(v,c)=-1;
        end
        if r2==0 && r1>0
            zones(v,c)=1;
        end
        if flag1==true && flag2==true
            break;
        end
    end
end

[X,Y] = meshgrid(V,Cs);
Z = rMd';

% Creating poligons of the different ares for coloring:
v0 = 0;
c0 = 0;
vl = 0;
cl = [];
cl2 = [];
ve = 0;
ce = [];
ce2 = [];

for v=1:length(V)
    for c=1:length(Cs)
        if zones(v,c)==-1 && V(v)~=vl(length(vl))
            vl = [vl,V(v)];
            cl = [cl,Cs(c)];
        elseif zones(v,c)==1 && V(v)~=ve(length(ve))
            ve = [ve,V(v)];
            ce = [ce,Cs(c)];
        elseif zones(v,c)==Inf && V(v)~=v0(length(v0))
            v0 = [v0,V(v)];
            c0 = [c0,Cs(c)];
            if ~isempty(find(vl==V(v)))
                i = find(v0==V(v));
                cl2 = [cl2,c0(i)];
            elseif ~isempty(find(ve==V(v)))
                i = find(v0==V(v));
                ce2 = [ce2,c0(i)];
            end
        end
    end
end


vl(1) = [];
cl = [cl,fliplr(cl2)];
vl = [vl,fliplr(vl)];
ve(1) = [];
ce = [ce,Cs(length(Cs)),Cs(length(Cs)),Cs(length(Cs)),fliplr(ce2)];
ve = [ve,fliplr(ve)];
v0 = [v0,v0(length(v0)),0];
c0 = [c0,Cs(length(Cs)),Cs(length(Cs))];

%ploting:
figure
hold on;
contour(X,Y,Z,'ShowText','on');
xlabel('$\hat{V}$','Interpreter', 'latex');
ylabel('$\hat{C_S}$','Interpreter', 'latex');
fill(v0,c0,'k');
fill(vl,cl,'b');
fill(ve,ce,'r');
hold off;
