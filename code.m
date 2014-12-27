function code()
    % Polygon area
    xa = [0 2.125 2.9325 2.975 2.9325 2.295 0.85 0.17];
    ya = [0 0 1.5 1.6 1.7 2.1 2.3 1.2];
    % Initial coordinates of the 4 robots
    xr = [0.25 0.5 0.75 1.0];
    yr = [0.25 0.5 0.75 1.0];
    % Various radius of interest
    R = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0];
    % Initial orientations of the 4 robots
    th = [0 pi/6 pi/3 pi/2];
    % Maximum angle of rotation for a supposed car-like wheeled robot
    % and a Dr=0.01 displacement
    a = pi / 180 * 15; %#ok<NASGU>
    
    % Trajectory graph
    figure(1); hold;
    % Set background color
    set(gcf,'Color',[1 1 1]);
    % Draw background polygon area
    h = fill(xa,ya,[0.85 0.85 0.85]); set(h,'EdgeColor','none');
    % Draw polygon
    k = convhull(xa,ya);
    plot(xa(k),ya(k),'k','LineWidth',2); axis([-0.5 3.45 -0.4 2.7]); axis off;
    % Draw initial positions for the robots
    plot(xr,yr,'ro','MarkerSize',10);
    plot(xr,yr,'r.','MarkerSize',16);
    
    r = R(10);  % Choose radius for the coverage area of the robots
    for step = 1:300
        % Calculate the r-limited Voronoi cells
        [xr1_poly yr1_poly xr2_poly yr2_poly xr3_poly yr3_poly xr4_poly yr4_poly]...
        = draw_instant(xa,ya,xr,yr,th,r,step);
        % Calculate the centers of the r-limited Voronoi cells
        % and move the robots towards those centers
        [~,cx,cy] = polycenter(xr1_poly,yr1_poly);
        %[xr(1) yr(1) th(1)] = update_center(xr(1),yr(1),th(1),cx,cy,a);
        % Uncomment the previous line and comment the next line, if there
        % is a hypothesis of a car-like wheeled robot
        [xr(1) yr(1)] = update_center_unconstrainted(xr(1),yr(1),cx,cy);
        [~,cx,cy] = polycenter(xr2_poly,yr2_poly);
        %[xr(2) yr(2) th(2)] = update_center(xr(2),yr(2),th(2),cx,cy,a);
        % Uncomment the previous line and comment the next line, if there
        % is a hypothesis of a car-like wheeled robot
        [xr(2) yr(2)] = update_center_unconstrainted(xr(2),yr(2),cx,cy);
        [~,cx,cy] = polycenter(xr3_poly,yr3_poly);
        %[xr(3) yr(3) th(3)] = update_center(xr(3),yr(3),th(3),cx,cy,a);
        % Uncomment the previous line and comment the next line, if there
        % is a hypothesis of a car-like wheeled robot
        [xr(3) yr(3)] = update_center_unconstrainted(xr(3),yr(3),cx,cy);
        [~,cx,cy] = polycenter(xr4_poly,yr4_poly);
        %[xr(4) yr(4) th(4)] = update_center(xr(4),yr(4),th(4),cx,cy,a);
        % Uncomment the previous line and comment the next line, if there
        % is a hypothesis of a car-like wheeled robot
        [xr(4) yr(4)] = update_center_unconstrainted(xr(4),yr(4),cx,cy);
        figure(1);
        % Draw current positions of the robots
        plot(xr(1),yr(1),'m.','MarkerSize',5,'MarkerFaceColor','m');
        plot(xr(2),yr(2),'c.','MarkerSize',5,'MarkerFaceColor','c');
        plot(xr(3),yr(3),'y.','MarkerSize',5,'MarkerFaceColor','y');
        plot(xr(4),yr(4),'g.','MarkerSize',5,'MarkerFaceColor','g');
        myaa
        export_fig( ['trajectory_r=' sprintf('%.1f',r) '_step=' sprintf('%03d',step) '.png'] )
        close
    end   
end
