function [xr1_poly yr1_poly xr2_poly yr2_poly xr3_poly yr3_poly xr4_poly yr4_poly]...
       = draw_instant(xa,ya,xr,yr,th,r,step) %#ok<INUSL>
    
    % Instant graph
    figure(2), hold
    % Set background color
    set(gcf,'Color',[1 1 1]);
    % Draw background polygon area
    h = fill(xa,ya,[0.85 0.85 0.85]); set(h,'EdgeColor','none');
    
    % Define the polygon (circle) for each robot
    [xr1_poly yr1_poly] = circle(xr(1),yr(1),r);
    [xr2_poly yr2_poly] = circle(xr(2),yr(2),r);
    [xr3_poly yr3_poly] = circle(xr(3),yr(3),r);
    [xr4_poly yr4_poly] = circle(xr(4),yr(4),r);
    % Find r-limited Voronoi Cell for robot 1 (almost)
    [xr12 yr12] = remove_neighbouring(xr1_poly,yr1_poly,xr2_poly,yr2_poly,xr(2),yr(2));
    [xr13 yr13] = remove_neighbouring(xr1_poly,yr1_poly,xr3_poly,yr3_poly,xr(3),yr(3));
    [xr14 yr14] = remove_neighbouring(xr1_poly,yr1_poly,xr4_poly,yr4_poly,xr(4),yr(4));
    % Find r-limited Voronoi Cell for robot 2 (almost)
    [xr23 yr23] = remove_neighbouring(xr2_poly,yr2_poly,xr3_poly,yr3_poly,xr(3),yr(3));
    [xr24 yr24] = remove_neighbouring(xr2_poly,yr2_poly,xr4_poly,yr4_poly,xr(4),yr(4));
    [xr21 yr21] = remove_neighbouring(xr2_poly,yr2_poly,xr1_poly,yr1_poly,xr(1),yr(1));
    % Find r-limited Voronoi Cell for robot 3 (almost)
    [xr34 yr34] = remove_neighbouring(xr3_poly,yr3_poly,xr4_poly,yr4_poly,xr(4),yr(4));
    [xr31 yr31] = remove_neighbouring(xr3_poly,yr3_poly,xr1_poly,yr1_poly,xr(1),yr(1));
    [xr32 yr32] = remove_neighbouring(xr3_poly,yr3_poly,xr2_poly,yr2_poly,xr(2),yr(2));
    % Find r-limited Voronoi Cell for robot 4 (almost)
    [xr41 yr41] = remove_neighbouring(xr4_poly,yr4_poly,xr1_poly,yr1_poly,xr(1),yr(1));
    [xr42 yr42] = remove_neighbouring(xr4_poly,yr4_poly,xr2_poly,yr2_poly,xr(2),yr(2));
    [xr43 yr43] = remove_neighbouring(xr4_poly,yr4_poly,xr3_poly,yr3_poly,xr(3),yr(3));
    % Remove the excess areas for robot 1
    [xr1_poly yr1_poly] = polybool('&',xr12,yr12,xr13,yr13);
    [xr1_poly yr1_poly] = polybool('&',xr1_poly,yr1_poly,xr14,yr14);
    % Remove the excess areas for robot 2
    [xr2_poly yr2_poly] = polybool('&',xr23,yr23,xr24,yr24);
    [xr2_poly yr2_poly] = polybool('&',xr2_poly,yr2_poly,xr21,yr21);
    % Remove the excess areas for robot 3
    [xr3_poly yr3_poly] = polybool('&',xr34,yr34,xr31,yr31);
    [xr3_poly yr3_poly] = polybool('&',xr3_poly,yr3_poly,xr32,yr32);
    % Remove the excess areas for robot 4
    [xr4_poly yr4_poly] = polybool('&',xr41,yr41,xr42,yr42);
    [xr4_poly yr4_poly] = polybool('&',xr4_poly,yr4_poly,xr43,yr43);
    % Find coverage areas (r-limited Voronoi cells), inside the polygon area
    [xr1_poly yr1_poly] = polybool('&',xa,ya,xr1_poly,yr1_poly);
    [xr2_poly yr2_poly] = polybool('&',xa,ya,xr2_poly,yr2_poly);
    [xr3_poly yr3_poly] = polybool('&',xa,ya,xr3_poly,yr3_poly);
    [xr4_poly yr4_poly] = polybool('&',xa,ya,xr4_poly,yr4_poly);
    % Draw the r-limited Voronoi cells
    h = fill(xr1_poly,yr1_poly,'m'); set(h,'EdgeColor','none');
    h = fill(xr2_poly,yr2_poly,'c'); set(h,'EdgeColor','none');
    h = fill(xr3_poly,yr3_poly,'y'); set(h,'EdgeColor','none');
    h = fill(xr4_poly,yr4_poly,'g'); set(h,'EdgeColor','none');
    % Draw robot orientations
    % Uncomment for car-like wheeled robots
    %plot([xr(1) xr(1)+0.1*cos(th(1))],[yr(1) yr(1)+0.1*sin(th(1))],'k','LineWidth',2);
    %plot([xr(2) xr(2)+0.1*cos(th(2))],[yr(2) yr(2)+0.1*sin(th(2))],'k','LineWidth',2);
    %plot([xr(3) xr(3)+0.1*cos(th(3))],[yr(3) yr(3)+0.1*sin(th(3))],'k','LineWidth',2);
    %plot([xr(4) xr(4)+0.1*cos(th(4))],[yr(4) yr(4)+0.1*sin(th(4))],'k','LineWidth',2);
    % Draw robot centers
    plot(xr,yr,'ko','MarkerSize',3,'MarkerFaceColor','k');
    % Draw polygon
    k = convhull(xa,ya);
    plot(xa(k),ya(k),'k','LineWidth',2); axis([-0.5 3.45 -0.4 2.7]); axis off;
    myaa
    export_fig( ['instant_r=' sprintf('%.1f',r) '_step=' sprintf('%03d',step) '.png'] )
    close; figure(2); close;
end
