function [xr yr] = update_center_unconstrainted(xr,yr,cx,cy)
    % Returns an updated center, for the supposed skid-steer wheeled robot,
    % that is 0.01 closer to the center of the r-limited Voronoi cell
    % (xr,yr) are the coordinates of the center of the robot
    % (cx,cy) are the coordinates of the center of the r-limited Voronoi cell
    phi = atan2(cy-yr,cx-xr);
    xr = xr + 0.01 * cos(phi);
    yr = yr + 0.01 * sin(phi);
end