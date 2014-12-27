function [xr_poly yr_poly] = remove_neighbouring(xr_poly,yr_poly,xr_n_poly,yr_n_poly,xr_n,yr_n)
    % Returns a new polygon area, for the robot in interest, which has less that
    % part that intersects with the polygon area of the neighbouring robot
    % {xr_poly,yr_poly} define the polygon area of the robot in interest
    % {xr_n_poly,yr_n_poly} define the polygon area of the neighbouring robot
    % (xr_n,yr_n) are the coordinates of the center of the robot
    [xi yi] = polyxpoly(xr_poly,yr_poly,xr_n_poly,yr_n_poly);
    % If the two circles (polygons) intersect
    if size(xi,1) ~= 0
        % Define a rectangular polygon, with two vertices being the intersection
        % points and the other two vertices being on the side of the neighbouring
        % robot and determined through the center of that robot. Then, subtract
        % this polygon from the coverage area of the robot in interest in order
        % to create the corresponding r-limited Voronoi cell (almost: this process
        % will have to be executed for all neighboring robots).
        % ===================================================
        % Determine the two additional vertices for the polygon
        t1 = [xr_n - xi(1) yr_n - yi(1)]; t2 = [xr_n - xi(2) yr_n - yi(2)];
        t = 10 * ( t1 + t2 );
        % Define the polygon
        xi = [xi; xi(2)+t(1); xi(1)+t(1)]; yi = [yi; yi(2)+t(2); yi(1)+t(2)];
        k = convhull(xi,yi); xi = xi(k(1:(end-1))); yi = yi(k(1:(end-1)));
        % Subtract this polygon from the coverage area (polygon) of the robot in interest
        [xr_poly yr_poly] = polybool('-',xr_poly,yr_poly,xi,yi);
    end
end