function plotIntegralScaleFitting(TKE, Lc, pol)

    n_meas =  size(TKE, 1);
    xFitted = linspace(0.95*min(Lc), max(Lc)*1.05, 1000)';
    yFitted = 10.^polyval(pol, log10(xFitted));
    y_Saffman = (xFitted/Lc(1)) .^ (-3) * TKE(1);
    y_Loitsyanskii = (xFitted/Lc(1)) .^ (-5) * TKE(1);
    y_self_similar = (xFitted/Lc(1)) .^ (-2) * TKE(1);

    % Create subplots 
    set(groot,'defaultAxesTickLabelInterpreter','latex');   
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultTextFontSize',14);
    set(groot,'defaultAxesFontSize',14);

    figure('Name', 'IntegralScaleFitting', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 1250 600];
    
    colormap("jet")

    subplot(1, 2, 1)
    hold on;
    box on;

    h1 = plot(Lc, TKE);
    h1.Color = 'b';
    h1.LineStyle = 'none';
    h1.Marker = 'o';
    h1.MarkerSize = 6;
    h1.LineWidth = 2;

    h2 = plot(xFitted', yFitted');
    h2.LineWidth = 1.5;
    h2.Color = 'k';
    h2.LineStyle = '--';
    

    h3 = plot(xFitted', y_Saffman');
    h3.LineWidth = 1.5;
    h3.LineStyle = '--';

    h3 = plot(xFitted', y_Loitsyanskii');
    h3.LineWidth = 1.5;
    h3.LineStyle = '--';

    h3 = plot(xFitted', y_self_similar');
    h3.LineWidth = 1.5;
    h3.LineStyle = '--';

    leg = {'Measurement', 'Least Squares', 'Saffman', 'Loitsyanskii', 'Self-Similar'};

    ax = gca;
    xlabel(ax, "$l_0\; [m]$", 'FontSize', 14);
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
    h1 = plot(Lc, TKE);
    h1.Color = 'b';
    h1.LineStyle = 'none';
    h1.Marker = 'o';
    h1.MarkerSize = 6;
    h1.LineWidth = 2;

    h2 = plot(xFitted', yFitted');
    h2.LineWidth = 1.5;
    h2.Color = 'k';
    h2.LineStyle = '--';

    h3 = plot(xFitted', y_Saffman');
    h3.LineWidth = 1.5;
    h3.LineStyle = '--';

    h3 = plot(xFitted', y_Loitsyanskii');
    h3.LineWidth = 1.5;
    h3.LineStyle = '--';

    h3 = plot(xFitted', y_self_similar');
    h3.LineWidth = 1.5;
    h3.LineStyle = '--';

    leg = {'Measurement', 'Least Squares', 'Saffman', 'Loitsyanskii', 'Self-Similar'};

    ax = gca;
    xlabel(ax, "$l_0 \; [m]$", 'FontSize', 14);
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
    name = fullfile(path, 'integralScaleFitting.png');
    exportgraphics(gcf, name);


end

