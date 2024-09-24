function plotVirtualOriginFit(TKE, h, pol)

    n =  size(TKE, 1);
    d_fit = (1:n);
    TKE_fit = TKE.'.^((1-h)/(2*h));
    xFitted = linspace(0.95, n+0.05, 1000);
    yFitted = polyval(pol, xFitted);

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

    hold on;
    box on;

    h1 = plot(d_fit, TKE_fit);
    h1.Color = 'b';
    h1.LineStyle = 'none';
    h1.Marker = 'o';
    h1.MarkerSize = 6;
    h1.LineWidth = 2;

    h2 = plot(xFitted', yFitted');
    h2.LineWidth = 1.5;
    h2.Color = 'k';
    h2.LineStyle = '--';
    
    leg = {'Measurement', 'Least Squares'};

    ax = gca;
    xlabel(ax, "$d [m]$", 'FontSize', 14);
    ylabel(ax, "$\mathcal{E}^{(1-h)/(2h)} \, [(m/s)^{(1-h)/h}]$ ", 'FontSize', 14);
    ax.XScale = 'linear';
    ax.YScale = 'linear';
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
    lgd.Location = 'southeast';
    lgd.FontSize = 12;
    lgd.Title.String = ' ';
    lgd.Title.FontSize = 12;
    
    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'virtualOriginFit.png');
    exportgraphics(gcf, name);

end