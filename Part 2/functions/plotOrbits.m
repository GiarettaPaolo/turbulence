function plotOrbits(vt, orbits, plot_not_converged)
    
     n = size(orbits, 2);            % Number of orbits
    
    % Create subplots 
    set(groot,'defaultAxesTickLabelInterpreter','latex');   
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultTextFontSize',14);
    set(groot,'defaultAxesFontSize',14);

    figure('Name', 'Periodic orbits', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 1250 600];
    
    hold on
    leg = {'Trajectory'};
    h = plot(vt(1, :), vt(2, :));
    h.LineStyle = ':';
    h.Color = [0.1 0.1 0.1];
    h.LineWidth = 1;
    % Loop over plots
    for i=1:n
        if orbits{3, i} <= 0 && ~plot_not_converged
            continue
        end    
        plot(orbits{2, i}(1, :), orbits{2, i}(2, :), 'LineWidth', 2.5, 'LineStyle', '-');
        leg{length(leg)+1} = "$t = " + num2str(orbits{5, i}, '%.2f') + ...
            ", \quad T_{best}  = " + num2str(orbits{4, i}, '%.2f') + "$";
    end
    
    ax = gca;
    cmap = colormap(jet(7));
    set(ax, 'ColorOrder', cmap);
    xlabel(ax, "$v_1$", 'FontSize', 14);
    ylabel(ax, "$v_2$", 'FontSize', 14);
    ax.XRuler.Exponent = 0;
    ax.YRuler.FontSize = 14;
    ax.XRuler.FontSize = 14;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    ax.XMinorGrid = 'on';
    ax.YMinorGrid = 'on';
    lgd = legend(ax, leg); 
    lgd.Location = 'southeast';
    lgd.FontSize = 12;
    lgd.Title.FontSize = 12;
    
    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'orbits1.png');
    exportgraphics(gcf, name);

    figure('Name', 'Periodic orbits - Separate', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 1500 600];
    
    row = 2;
    col = ceil(n / row);


    % colormap("jet")
    % Loop over plots
    for i=1:n
        
        subplot(row, col, i)
        hold on
        
        h = plot(orbits{2, i}(1, :), orbits{2, i}(2, :));
        h.LineStyle = '-';
        h.LineWidth = 1.2;
        h.Color = 'b';

        h = plot(orbits{2, i}(1, 1), orbits{2, i}(2, 1));
        h.LineStyle = 'none';
        h.Marker = 'o';
        h.Color = 'r';
        h.MarkerSize = 6;
        h.LineWidth = 3;

        h = plot(orbits{2, i}(1, end), orbits{2, i}(2, end));
        h.LineStyle = 'none';
        h.Marker = 'x';
        h.Color = 'r';
        h.MarkerSize = 6;
        h.LineWidth = 3;
            
        ax = gca;
        xlabel(ax, "$v_1$", 'FontSize', 14);
        ylabel(ax, "$v_2$", 'FontSize', 14);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 14;
        ax.XRuler.FontSize = 14;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        title(ax, "$t = " + num2str(orbits{5, i}, '%.2f') + ...
            ",T_{best} =" + num2str(orbits{4, i}, '%.2f') + "$")
 
    end
    
    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'orbits2.png');
    exportgraphics(gcf, name);

end

