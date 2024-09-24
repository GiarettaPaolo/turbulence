function plotGraphicalFitting(TKE, d0_range, coeff, n_meas)
        
    n = length(d0_range);
    xFitted = linspace(1-0.05, n_meas+0.05, 1000)';

    % Create subplots 
    set(groot,'defaultAxesTickLabelInterpreter','latex');   
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultTextFontSize',14);
    set(groot,'defaultAxesFontSize',14);

    figure('Name', 'Graphical Fitting', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [20 20 1500 720];
    
    % Calculatae number of subplots
    row = 2;
    col = ceil(n/2);
    
    for i = 1:n

        subplot(row, col, i)
        hold on;
        box on;
    
        yFitted = 10^coeff(i, 2) * (xFitted - d0_range(i)).^coeff(i, 1);
        h = plot(xFitted-d0_range(i), yFitted);
        h.LineWidth = 1.2;
        h.LineStyle = '--';
        h.Color = 'k';
        
        h2 = plot((1:n_meas)-d0_range(i), TKE);
        h2.Color = 'b';
        h2.LineStyle = 'none';
        h2.Marker = 'o';
        h2.MarkerSize = 5;
        h2.LineWidth = 2;

        ax = gca;
        xlabel(ax, "$d - d_{0}\; [m]$", 'FontSize', 14);
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
        str = "$d_{0} \; = \;$" + num2str(d0_range(i), '%.2f');
        title(str);
        leg = {'Fit', 'Measurement'};
        lgd = legend(ax, leg); 
        lgd.Location = 'northeast';
        lgd.FontSize = 12;
        lgd.Title.String = '';
        lgd.Title.FontSize = 12;
    end
    
    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'graphicalFitting1.png');
    exportgraphics(gcf, name);

    figure('Name', 'Graphical Fitting - Linear scale', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [20 20 1500 720];
    
    % Calculatae number of subplots
    row = 2;
    col = ceil(n/2);
    
    for i = 1:n

        subplot(row, col, i)
        hold on;
        box on;
    
        yFitted = 10^coeff(i, 2) * (xFitted - d0_range(i)).^coeff(i, 1);
        h = plot(xFitted-d0_range(i), yFitted);
        h.LineWidth = 1.2;
        h.LineStyle = '--';
        h.Color = 'k';
        
        h2 = plot((1:n_meas)-d0_range(i), TKE);
        h2.Color = 'b';
        h2.LineStyle = 'none';
        h2.Marker = 'o';
        h2.MarkerSize = 5;
        h2.LineWidth = 2;

        ax = gca;
        xlabel(ax, "$d - d_{0}\; [m]$", 'FontSize', 14);
        ylabel(ax, "$\mathcal{E} \; [m^2 \, s^{-2}]$ ", 'FontSize', 14);
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
        str = "$d_{0} \; = \;$" + num2str(d0_range(i), '%.2f');
        title(str);
        leg = {'Fit', 'Measurement'};
        lgd = legend(ax, leg); 
        lgd.Location = 'northeast';
        lgd.FontSize = 12;
        lgd.Title.String = '';
        lgd.Title.FontSize = 12;
    end
    
    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'graphicalFitting2.png');
    exportgraphics(gcf, name);

end

