theta = gallery('uniformdata',[100,1],0)*2*pi;
phi = gallery('uniformdata',[100,1],1)*pi;
x = cos(theta).*sin(phi);
y = sin(theta).*sin(phi);
z = cos(phi);
DT = delaunayTriangulation(x,y,z);
fn2 = faceNormal(DT);
[T,Xb] = freeBoundary(DT);
TR = triangulation(T,Xb);
figure
trisurf(T,Xb(:,1),Xb(:,2),Xb(:,3), ...
     'FaceColor', 'cyan', 'faceAlpha', 0.8);
axis equal;
hold on;  

% Calculate the incenters and face normals. 
P = incenter(TR);
fn = faceNormal(TR);  

% Display the normal vectors on the surface. 
quiver3(P(:,1),P(:,2),P(:,3), ...
     fn(:,1),fn(:,2),fn(:,3),0.5, 'color','r');
hold off;