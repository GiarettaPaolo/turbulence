function plotReynolds(Re, Re_lam, eps, I)
    
    n = length(Re);

    % Create subplots 
    set(groot,'defaultAxesTickLabelInterpreter','latex');   
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultTextFontSize',14);
    set(groot,'defaultAxesFontSize',14);

    figure('Name', 'Reynolds ', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 800 400];
    
    hold on
    box on;
    
    h = plot(1:n, Re);
    h.LineStyle = '--';
    h.Color = 'b';
    h.Marker = 'diamond';
    h.MarkerSize = 6;
    h.LineWidth = 1.6;
        
    ax = gca;
    xlabel(ax, "Probe position [m]", 'FontSize', 14);
    ylabel(ax, "Re", 'FontSize', 14);
    ax.XRuler.Exponent = 0;
    ax.YRuler.Exponent = 0;
    ax.YRuler.FontSize = 14;
    ax.XRuler.FontSize = 14;
    ax.XLimitMethod = 'tickaligned';
    ax.YLimitMethod = 'tickaligned';
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    ax.XMinorGrid = 'on';
    ax.YMinorGrid = 'on';
    
    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'Reynolds.png');
    exportgraphics(gcf, name);

    figure('Name', 'Reynolds - lambda', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 800 400];
    h = plot(1:n, Re_lam);
    h.LineStyle = '--';
    h.Color = 'b';
    h.Marker = 'diamond';
    h.MarkerSize = 6;
    h.LineWidth = 1.6;
        
    ax = gca;
    xlabel(ax, "Probe position [m]", 'FontSize', 14);
    ylabel(ax, "$Re_{\lambda}$", 'FontSize', 14);
    ax.XRuler.Exponent = 0;
    ax.YRuler.FontSize = 14;
    ax.XRuler.FontSize = 14;
    ax.XLimitMethod = 'tickaligned';
    ax.YLimitMethod = 'tickaligned';
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    ax.XMinorGrid = 'on';
    ax.YMinorGrid = 'on';
    
    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'Reynolds lambda.png');
    exportgraphics(gcf, name);

    figure('Name', 'Dissipation', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 800 400];
    h = plot(1:n, eps);
    h.LineStyle = '--';
    h.Color = 'b';
    h.Marker = 'diamond';
    h.MarkerSize = 6;
    h.LineWidth = 1.6;
        
    ax = gca;
    xlabel(ax, "Probe position [m]", 'FontSize', 14);
    ylabel(ax, "$\epsilon \; [m^2 s^{-3}]$", 'FontSize', 14);
    ax.XRuler.Exponent = 0;
    ax.YRuler.FontSize = 14;
    ax.XRuler.FontSize = 14;
    ax.XLimitMethod = 'tickaligned';
    ax.YLimitMethod = 'tickaligned';
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    ax.XMinorGrid = 'on';
    ax.YMinorGrid = 'on';
    ax.YScale = "log";
    
    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'Dissipation.png');
    exportgraphics(gcf, name);

    figure('Name', 'Turbulence intensity', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 800 400];
    h = plot(1:n, I);
    h.LineStyle = '--';
    h.Color = 'b';
    h.Marker = 'diamond';
    h.MarkerSize = 6;
    h.LineWidth = 1.6;
        
    ax = gca;
    xlabel(ax, "Probe position [m]", 'FontSize', 14);
    ylabel(ax, "Turbulence intenisty", 'FontSize', 14);
    ax.XRuler.Exponent = 0;
    ax.YRuler.FontSize = 14;
    ax.XRuler.FontSize = 14;
    ax.XLimitMethod = 'tickaligned';
    ax.YLimitMethod = 'tickaligned';
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    ax.XMinorGrid = 'on';
    ax.YMinorGrid = 'on';

    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'TurbulenceIntensity.png');
    exportgraphics(gcf, name);