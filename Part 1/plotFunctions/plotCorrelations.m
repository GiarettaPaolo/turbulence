function plotCorrelations(c_lag, l_lag)
    n_meas = size(l_lag, 1);


    % Create subplots 
    set(groot,'defaultAxesTickLabelInterpreter','latex');   
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultTextFontSize',14);
    set(groot,'defaultAxesFontSize',14);

    figure('Name', 'Autocorrelatino function', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 1250 600];
    
    colormap("jet")
    hold on
    box on;

    leg = cell(1, n_meas);

    % Loop over plots
    for i=1:n_meas
        
        h = plot(l_lag(i, :), c_lag(i, :));
        h.LineStyle = '-';
        h.LineWidth = 2;

        leg{i} = num2str(i);

    end
    
    color = get(gca, 'colororder');
    for i=1:n_meas
        
        idx = find(c_lag(i, :) >= exp(-1), 1, "last");
        h = plot(l_lag(i, idx), c_lag(i, idx));
        h.MarkerSize = 30;
        h.Marker ='.';
        h.Color = color(i, :);

        h = xline(l_lag(i, idx));
        h.LineWidth = 2;
        h.LineStyle = ':';
        h.Color = color(i, :);

    end

    h = yline(1/exp(1));
    h.LineWidth = 2;
    h.Color = 'r';
    h.LineStyle = '--';

    h = yline(0);
    h.LineWidth = 1.5;
    h.Color = 'k';
    h.LineStyle = '--';

    ax = gca;
    xlabel(ax, "$l$ [m]", 'FontSize', 14);
    ylabel(ax, "$C(l)$", 'FontSize', 20);
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
    lgd = legend(ax, leg); 
    lgd.Location = 'northeast';
    lgd.FontSize = 12;
    lgd.Title.String = 'Anemometer number';
    lgd.Title.FontSize = 12;

    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'correlations.png');
    exportgraphics(gcf, name);   

end


