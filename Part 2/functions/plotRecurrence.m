function plotRecurrence(tsol, r, recurrence_guess)
    
    if nargin < 2
        recurrence_guess = [nan; nan];
    end
    
    dt = tsol(2) - tsol(1);

    % Create subplots 
    set(groot,'defaultAxesTickLabelInterpreter','latex');   
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultTextFontSize',14);
    set(groot,'defaultAxesFontSize',14);

    figure('Name', 'Reccurence contour', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 1250 600];
    
    
    cmap = jet;

    % 
    Tsol = tsol(1:size(r, 2));
    [~, h] = contourf(tsol, Tsol, r', 200);
    h.LineStyle = 'none';
    c=colorbar('eastoutside');
    c.TickLabelInterpreter='latex';
    c.Limits = [0 2];
    colormap(cmap);
    hold on
    h = plot(recurrence_guess(1, :) * dt, (recurrence_guess(2, :) - 1) * dt);
    h.LineStyle = 'none';
    h.Marker = 'o';
    h.MarkerSize = 10;
    h.LineWidth = 2;
    h.Color = 'r';
        
    ax = gca;
    xlabel(ax, "t", 'FontSize', 14);
    ylabel(ax, "T", 'FontSize', 14);
    ax.XRuler.Exponent = 0;
    ax.YRuler.FontSize = 14;
    ax.XRuler.FontSize = 14;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    ax.XMinorGrid = 'on';
    ax.YMinorGrid = 'on';
    
    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'recurrence.png');
    exportgraphics(gcf, name);

    % figure('Name', 'Recurrence Surface', 'NumberTitle', 'off');
    % fig = gcf;
    % fig.Color = 'w';
    % fig.Position = [100 100 1250 600];
    % 

    % h = surface(tsol, Tsol, r');
    % h.EdgeColor = 'k';
    % h.FaceColor = 'none';
    % h.LineWidth = 0.01;
    % h.FaceColor = 'interp';
    % h.EdgeLighting = "flat";
    % h.EdgeColor = 'k';
    % colormap(cmap);
    % 
    % ax = gca;
    % xlabel(ax, "t", 'FontSize', 14);
    % ylabel(ax, "T", 'FontSize', 14);
    % ax.XRuler.Exponent = 0;
    % ax.YRuler.FontSize = 14;
    % ax.XRuler.FontSize = 14;
    % ax.XMinorTick = 'on';
    % ax.YMinorTick = 'on';
    % ax.XGrid = 'on';
    % ax.YGrid = 'on';
    % ax.XMinorGrid = 'on';
    % ax.YMinorGrid = 'on';


end

