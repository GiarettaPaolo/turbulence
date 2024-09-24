function plotAnemometers(l, u, U, num)
    
    n_meas = size(l, 1);
    % Plot only this amount of points
    idx = round(linspace(1, size(l, 2), num));

    % Create subplots 
    set(groot,'defaultAxesTickLabelInterpreter','latex');   
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultTextFontSize',14);
    set(groot,'defaultAxesFontSize',14);

    figure('Name', 'Raw Anemometers measurements', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 1250 600];
    
    colormap("jet")
    hold on
    box on;

    leg = cell(1, n_meas);
    
    % Loop over plots
    for i=1:n_meas
        subplot(2, 3, i)

        h = plot(l(i, idx) ./ U(i), u(i, idx));
        h.LineStyle = '-';
        h.LineWidth = 0.8;

        h = yline(U(i));
        h.LineStyle = '--';
        h.LineWidth = 1.5;
        h.Color = 'r';

        ax = gca;
        xlabel(ax, "$t$ [s]", 'FontSize', 14);
        ylabel(ax, "$u_{tot}$ [m/s]", 'FontSize', 14);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 14;
        ax.XRuler.FontSize = 14;
        ax.XLimitMethod = 'tight';
        ax.YLim = [8 13];
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        title(ax, "Anemometer " + num2str(i))
        leg{i} = num2str(i);

    end
    
    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'plotAnemometers1.png');
    exportgraphics(gcf, name);

    figure('Name', 'Raw Anemometers measurements', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 1250 600];
    
    colormap("jet")
    hold on
    box on;

    idx = 1:9400*2;
    % Loop over plots
    for i=1:n_meas

        h = plot(l(i, idx), u(i, idx));
        h.LineStyle = '-';
        h.LineWidth = 1.6;

    end

        ax = gca;
        xlabel(ax, "$x$ [m]", 'FontSize', 14);
        ylabel(ax, "$u_{tot}$ [m/s]", 'FontSize', 14);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 14;
        ax.XRuler.FontSize = 14;
        ax.XLimitMethod = 'tickaligned';
        ax.YLimitMethod = "tickaligned";
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
    name = fullfile(path, 'plotAnemometers2.png');
    exportgraphics(gcf, name);

    figure('Name', 'Histograms', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 1250 600];
    
    colormap("jet")
    hold on
    box on;

    % Loop over plots
    for i=1:n_meas
        
        [N, edges] = histcounts(u(i, :), 'Normalization','pdf');
        edges = edges(2:end) - (edges(2)-edges(1))/2;
        h = plot(edges, N);
        h.LineStyle = '-';
        h.LineWidth = 2;

    end
        
    ax = gca;
    xlabel(ax, "$u_{tot}$ [m/s]", 'FontSize', 14);
    ylabel(ax, "Probability density [s/m]", 'FontSize', 14);
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
    name = fullfile(path, 'plotAnemometers3.png');
    exportgraphics(gcf, name);

end

