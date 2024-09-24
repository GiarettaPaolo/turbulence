function plotAutomaticFitting(beta, TKE, modelfun)
        
    n_meas = size(TKE, 1);
    xFitted = linspace(1, n_meas, 1000)';
    yFitted = modelfun(beta, xFitted);

    % Create subplots 
    set(groot,'defaultAxesTickLabelInterpreter','latex');   
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultTextFontSize',14);
    set(groot,'defaultAxesFontSize',14);

    figure('Name', 'Automatic fitting', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 1250 600];
    
    subplot(1, 2, 1)
    hold on;
    box on;
    h1 = plot(xFitted' - beta(2), yFitted');
    h1.LineWidth = 1.5;
    h1.Color = 'k';
    h1.LineStyle = '--';
    
    h2 = plot((1:n_meas) - beta(2), TKE);
    h2.Color = 'b';
    h2.LineStyle = 'none';
    h2.Marker = 'o';
    h2.MarkerSize = 6;
    h2.LineWidth = 2;

    leg = {'Automatic Fit', 'Measurement'};

    ax = gca;
    xlabel(ax, "$d - d_0 \; [m]$", 'FontSize', 14);
    ylabel(ax, "$\mathcal{E} \; [m^2 \, s^{-2}]$ ", 'FontSize', 14);
    ax.XScale = 'log';
    ax.YScale = 'log';
    ax.XRuler.Exponent = 0;
    ax.YRuler.FontSize = 14;
    ax.XRuler.FontSize = 14;
    ax.XLimitMethod = 'padded';
    ax.YLimitMethod = 'padded';
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    ax.XMinorGrid = 'on';
    ax.YMinorGrid = 'on';
    lgd = legend(ax, leg); 
    lgd.Location = 'northeast';
    lgd.FontSize = 12;
    lgd.Title.String = ' ';
    lgd.Title.FontSize = 12;

    subplot(1, 2, 2)
    hold on;
    box on;
    h1 = plot(xFitted', yFitted');
    h1.LineWidth = 1.5;
    h1.Color = 'k';
    h1.LineStyle = '--';
    
    h2 = plot(1:n_meas, TKE);
    h2.Color = 'b';
    h2.LineStyle = 'none';
    h2.Marker = 'o';
    h2.MarkerSize = 6;
    h2.LineWidth = 2;

    leg = {'Automatic Fit', 'Measurement'};

    ax = gca;
    xlabel(ax, "$d \; [m]$", 'FontSize', 14);
    ylabel(ax, "$\mathcal{E} \; [m^2 \, s^{-2}]$ ", 'FontSize', 14);
    ax.XScale = 'lin';
    ax.YScale = 'lin';
    ax.XRuler.Exponent = 0;
    ax.YRuler.FontSize = 14;
    ax.XRuler.FontSize = 14;
    ax.XLimitMethod = 'padded';
    ax.YLimitMethod = 'padded';
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    ax.XMinorGrid = 'on';
    ax.YMinorGrid = 'on';
    lgd = legend(ax, leg); 
    lgd.Location = 'northeast';
    lgd.FontSize = 12;
    lgd.Title.String = ' ';
    lgd.Title.FontSize = 12;

    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'AutomaticFittings.png');
    exportgraphics(gcf, name);

end

