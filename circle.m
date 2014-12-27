function [xunit yunit] = circle(x,y,r)
    % Returns a polygon (circle) that is centered at (x,y) and has a radius r
    th = 0:pi/50:2*pi;
    xunit = r * cos(th) + x;
    yunit = r * sin(th) + y;
end