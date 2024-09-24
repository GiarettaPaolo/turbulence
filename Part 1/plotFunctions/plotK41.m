function plotK41(k_vect, E, visE, kintE)
    n_meas = size(E, 1);


    % Create subplots 
    set(groot,'defaultAxesTickLabelInterpreter','latex');   
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultTextFontSize',14);
    set(groot,'defaultAxesFontSize',14);

    figure('Name', 'K41 - Energy spectrum', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 1250 600];
    
    cmap = colormap("jet");
    hold on
    box on;

    leg = cell(1, n_meas);

    % Loop over plots
    for i=1:n_meas
        
        h = plot(k_vect(i, :), E(i, :));
        h.LineStyle = '-';
        h.LineWidth = 2.5;

        leg{i} = num2str(i);
    end
    color = get(gca, 'colororder');

    k_range = 10.^linspace(-1, 4, 100);
    h = plot(k_range, k_range.^(-5/3)*1e-1);
    h.LineWidth = 2;
    h.Color = 'k';
    h.LineStyle = '--';
    leg{i+1} = "$-5/3$ slope ";

    for i=1:n_meas
        E_visaE = interp1(k_vect(i, :), E(i, :), visE(i), 'linear');
        E_int = interp1(k_vect(i, :), E(i, :), kintE(i), 'linear');

        h = plot(visE(i), E_visaE);
        h.LineStyle = 'none';
        h.Color = color(i, :);
        h.Marker = '.';
        h.MarkerSize = 30;


        h = plot(kintE(i), E_int);
        h.LineStyle = 'none';
        h.LineWidth = 3;
        h.Color = color(i, :);
        h.Marker = 'diamond';
        h.MarkerSize = 5;
 
    end
    


    ax = gca;
    xlabel(ax, "$k \; [m^{-1}]$", 'FontSize', 14);
    ylabel(ax, "$E(k) \; [ m^{3} \, s^{-2}]$", 'FontSize', 14);
    ax.XScale = 'log';
    ax.YScale = 'log';
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
    lgd.Location = 'southwest';
    lgd.FontSize = 12;
    lgd.Title.String = 'Anemometer number';
    lgd.Title.FontSize = 12;

    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'K41.png');
    exportgraphics(gcf, name);
end

