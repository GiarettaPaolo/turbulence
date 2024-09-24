function plotSpaceTimeCountour(sol)
    
    n = length(sol);            % Number of plots
    
    % Create subplots 
    set(groot,'defaultAxesTickLabelInterpreter','latex');   
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultTextFontSize',14);
    set(groot,'defaultAxesFontSize',14);
    figure('Name', 'Space-Time contours', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 1250 600];
    
    % Set number of subplots
    col = floor(n / 3);
    row = ceil(n / col);
    
    cmap = jet;

    % Loop over plots
    for i=1:n

        subplot(col, row, i);
        [~, h] = contourf(sol(i).x, sol(i).tsol, sol(i).ut', 500);
        h.LineStyle = 'none';
        c=colorbar('southoutside');
        c.TickLabelInterpreter='latex';
        c.Limits = [-3 3];
        colormap(cmap);

        ax = gca;
        xlabel(ax, "x", 'FontSize', 14);
        ylabel(ax, "t", 'FontSize', 14);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 14;
        ax.XRuler.FontSize = 14;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.XGrid = 'off';
        ax.YGrid = 'off';
        ax.XMinorGrid = 'off';
        ax.YMinorGrid = 'off';
        title(ax, "L = " + num2str(sol(i).L, '%.2f'));
 
    end
    
    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'spacetimecontours.png');
    exportgraphics(gcf, name);

end

