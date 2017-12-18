%
% draws an ellipse with a(1)x^2 + a(2)xy + a(3)y^2 + a(4)x + a(5)y + a(6) = 0
% overlaid with original points (rx,ry)
%
function drawellip(a,rx,ry)

   %  convert to standard form: ((x-cx)/r1)^2 + ((y-cy)/r2)^2 = 1
   % rotated by theta
   v = solveellipse(a);

   % draw ellipse with N points   
   N = 100;
   dx = 2*pi/N;
   theta = v(5);
   R = [ [ cos(theta) sin(theta)]', [-sin(theta) cos(theta)]'];
   for i = 1:N
        ang = i*dx;
        x = v(1)*cos(ang);
        y = v(2)*sin(ang);
        d1 = R*[x y]';
        X(i) = d1(1) + v(3);
        Y(i) = d1(2) + v(4);
   end

figure(1)
hold off
plot(rx,ry,'ro')
hold on
plot(X,Y,'b')
