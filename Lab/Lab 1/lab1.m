P = [0,0,10]';

b = 60;
f = 6;
ps = 0.006/1000;
xNumPix = 752;
yNumPix = 480;
cxLeft = xNumPix/2;
cyLeft = yNumPix/2;
cxRight = xNumPix/2;
cyRight = yNumPix/2;

camLeft = CentralCamera('focal', 0.006, 'pixel', 6.0000e-06, 'resolution', [xNumPix,yNumPix],'centre',[cxLeft,cyLeft],'name','Left Camera');
Tcam = SE3(-.03,0,0);
camLeft.T = Tcam;
camRight = CentralCamera('focal', f/1000, 'pixel', ps/1000, 'resolution', [xNumPix,yNumPix],'centre',[cxRight,cyRight],'name','Right Camera');
Tcam = SE3(.03,0,0);
camRight.T = Tcam;

depth = 0:.1:10;
numPoints = length(depth);
x = zeros(1,numPoints);
y = zeros(1,numPoints);

P = [x;y;depth];
leftPixel = camLeft.project(P);
rightPixel = camRight.project(P);

xLeft = leftPixel(1,:);
xRight = rightPixel(1,:);
d = (abs((xLeft-cxLeft)-(xRight-cxRight))*ps);
Z = (b*f)./d;
calcDepth = Z/1000;

subplot(2,1,1)
plot(depth,d)
xlabel("depth [m]")
ylabel("disparity [pixels]")
subplot(2,1,2)
plot(depth,calcDepth-depth)
xlabel("depth [m]")
ylabel("depth error [m]")

% Part 2
f = 10;

camLeft = CentralCamera('focal', f/1000, 'pixel', ps/1000, 'resolution', [xNumPix,yNumPix],'centre',[cxLeft,cyLeft],'name','Left Camera');
Tcam = SE3(-.03,0,0);
camLeft.T = Tcam;
camRight = CentralCamera('focal', f/1000, 'pixel', ps/1000, 'resolution', [xNumPix,yNumPix],'centre',[cxRight,cyRight],'name','Right Camera');
Tcam = SE3(.03,0,0);
camRight.T = Tcam;

leftPixel = camLeft.project(P);
rightPixel = camRight.project(P);

xLeft = leftPixel(1,:);
xRight = rightPixel(1,:);
d = (abs((xLeft-cxLeft)-(xRight-cxRight))*ps);
Z = (b*f)./d;
calcDepth = Z/1000;

subplot(2,1,1)
hold on
plot(depth,d)
legend("f = 6mm", "f = 10mm")
subplot(2,1,2)
hold on
plot(depth,calcDepth-depth)
legend("f = 6mm", "f = 10mm")

%save output.mat xLeft calcDepth