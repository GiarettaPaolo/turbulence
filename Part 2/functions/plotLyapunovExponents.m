function plotLyapunovExponents(sol)
    
    n = length(sol);            % Number of plots
    p = size(sol(1).X, 1);      % Number of exponents
    
    % Create subplots 
    set(groot,'defaultAxesTickLabelInterpreter','latex');   
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultTextFontSize',14);
    set(groot,'defaultAxesFontSize',14);

    figure('Name', 'Lyapunov Exponents', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 1800 600];
    
    % Set number of subplots
    col = floor(n / 3);
    row = ceil(n / col);
    
    colormap(hsv);
    
    % Loop over plots
    for i=1:n

        subplot(col, row, i);
        hold on
        plot(sol(i).X', 'LineWidth', 1.2)

        h = yline(0);
        h.LineStyle = '--';
        h.Color = 'k';
        h.LineWidth = 1.2;
        
        ax = gca;
        xlabel(ax, "iter", 'FontSize', 14);
        ylabel(ax, "$\chi_{Lyapunov}$", 'FontSize', 14);
        ax.XRuler.Exponent = 0;
        ax.XScale = "log";
        ax.YRuler.FontSize = 14;
        ax.XRuler.FontSize = 14;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        title(ax, "System " + num2str(i))
 
    end
    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'exponents1.png');
    exportgraphics(gcf, name);
    %% PLOT CONVERGENCE
    figure('Name', 'Lyapunov Exponents convergence', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 1800 600];
    
    % Set number of subplots
    col = floor(n / 3);
    row = ceil(n / col);
    
    colormap(hsv);

    % Loop over plots
    for i=1:n

        subplot(col, row, i);
        hold on
        plot(abs((diff(sol(i).X, 2, 2))'), 'LineWidth', 1.2)

        h = yline(0);
        h.LineStyle = '--';
        h.Color = 'k';
        h.LineWidth = 1.2;

        h = plot(1./(1:size(sol(1).X, 2)));
        h.LineStyle = '--';
        h.Color = 'r';
        h.LineWidth = 1.2;

        
        ax = gca;
        xlabel(ax, "iter", 'FontSize', 14);
        ylabel(ax, "$|\chi_{i} - \chi_{i-1}|$", 'FontSize', 14);
        ax.XRuler.Exponent = 0;
        ax.XScale = "log";
        ax.YScale = "log";
        ax.YRuler.FontSize = 14;
        ax.XRuler.FontSize = 14;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        title(ax, "System " + num2str(i))
 
    end
    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'exponents2.png');
    exportgraphics(gcf, name);

end

