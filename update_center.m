function [xr yr th] = update_center(xr,yr,th,cx,cy,a)
    % Returns an updated center, for the robot, that is 0.01 closer to the
    % center of the r-limited Voronoi cell
    % (xr,yr) are the coordinates of the center of the robot
    % th is the orientation of the robot [in rads]
    % (cx,cy) are the coordinates of the center of the r-limited Voronoi cell
    % a is the angle of maximum rotation of the supposed car-like
    % wheeled robot for a Dr=0.01 displacement
    phi = atan2(cy-yr,cx-xr);
    if th - phi > a
        th = th - a;
    elseif th - phi < -a
        th = th + a;
    elseif th - phi > 0
        th = th - phi;
    else
        th = th + phi;
    end
    xr = xr + 0.01 * cos(th);
    yr = yr + 0.01 * sin(th);
end