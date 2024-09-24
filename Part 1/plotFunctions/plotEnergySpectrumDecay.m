function plotEnergySpectrumDecay(k, E)
    n_meas = size(E, 1);


    % Create subplots 
    set(groot,'defaultAxesTickLabelInterpreter','latex');   
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultTextFontSize',14);
    set(groot,'defaultAxesFontSize',14);

    figure('Name', 'Energy Spectrum for decyaing turbulence', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [100 100 1250 600];
    
    colormap("jet")
    hold on
    box on;

    leg = cell(1, n_meas);

    % Loop over plots
    for i=1:n_meas
        
        h = plot(k(i, :), E(i, :));
        h.LineStyle = '-';
        h.LineWidth = 2;

        leg{i} = num2str(i);

    end
    
    k_range = 10.^linspace(-1.25, 4, 100);
    h1 = plot(k_range, k_range.^(-5/3)*1e-1);
    h1.LineWidth = 2.5;
    h1.LineStyle = '--';
    h1.Color = 'k';
    leg{i+1} = " $K41$";
    
    k_vect = 10.^linspace(-3, 0.5, 100);
    h_exp = -5/2;
    h2 = plot(k_vect, k_vect.^-(1 + 2 * h_exp) * 1e3);
    h2.LineWidth = 2.5;
    h2.LineStyle = ':';
    h2.Color = 'k';
    leg{i+2} = " $Loitsyanskii$";

    k_vect = 10.^linspace(-3, 0.5, 100);
    h_exp = -3/2;
    h2 = plot(k_vect, k_vect.^-(1 + 2 * h_exp)*10^(0.4));
    h2.LineWidth = 2.5;
    h2.LineStyle = ':';
    h2.Color = 'b';
    leg{i+3} = " $Saffman$";

    k_vect = 10.^linspace(-3, 0.5, 100);
    h_exp = -2/2;
    h2 = plot(k_vect, k_vect.^-(1 + 2 * h_exp)*10^(-1));
    h2.LineWidth = 2.5;
    h2.Color = 'r';
    h2.LineStyle = ':';
    leg{i+4} = " $Self-similar$";

    ax = gca;
    xlabel(ax, "$k \; [m^{-1}]$", 'FontSize', 14);
    ylabel(ax, "$E(k) \; [m^{3} \, s^{-2}]$", 'FontSize', 14);
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
    lgd.Location = 'northeast';
    lgd.FontSize = 12;
    lgd.Title.String = 'Anemometer number';
    lgd.Title.FontSize = 12;

    path = fullfile(pwd, 'Plots');
    name = fullfile(path, 'energySpectrumDecay.png');
    exportgraphics(gcf, name);  
    
end