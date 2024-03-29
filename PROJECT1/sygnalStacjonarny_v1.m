% Generowanie sygna�u stacjonarnego
    % Parametry systemu
    Fs = 000;         % Cz�stotliwo�� pr�bkowania [Hz]
    T = 1/Fs;          % Okres pr�bkowania [s]
    L = 1000;          % D�ugo�� sygna�u (liczba pr�bek)
    t = (0:L-1)*T;     % Podstawa czasu
    f_step = Fs/L;     % zmiana cz�stotliwo�ci
    f = 0:f_step:Fs/2; % o� cz�stotliwo�ci do wykresu

    % Przygotowanie sygna�u
    N = 3;               % Liczba sinusoid w mieszaninie
    A = [2.0   1.5  0.9]; % Amplitudy kolejnych sinusoid
    B = [ 34    10   90]; % Cz�stotliwo�ci kolejnych sygna��w [Hz]
    C = [  0 -pi/6 pi/4]; % Przesuni�cia fazowe kolejnych sygna��w


    x = zeros(size(t));
    for i = 1:N
      x = x + A(i) * cos(2 * pi * B(i) * t + C(i));
    end
    
    
    figure
    plot(x)
    xlabel('t[ms]')
    ylabel('sygna�')
    title('wygenerowany sygna�')
%     saveas(gcf,'docs/sygna�Stacjonarny.png')
    hold off
    
% Transformata Fouriera
    [A_trans,F_trans]=transformata(x);

    figure;
    plot(f, A_trans);        % wykres amplitudowy
    xlabel('f[Hz]');
    ylabel('amplituda')
    title('widmo amplitudowe')
    saveas(gcf,'docs/widmoAmplitudowe.png')
    hold off
    
    figure;
    plot(f,F_trans);        % wykres fazowy
    xlabel('f[Hz]')
    ylabel('faza')
    title('widmo fazowe')
    saveas(gcf,'docs/widmoFazowe.png')
    hold off
    

% Sygna�y zaszumione
    x_szum=x+wgn(1, L,3); % stworzenie sygnalu zaszumionego

    [A_szum,F_szum]=transformata(x_szum); % wyznaczenie transformaty dla sygnalu zaszumionego
     A_odszum=maxk(A_szum,3); % wybranie 3 najwiekszych wartosci z widma amplitudowego
    [A_odszum, index]=intersect(A_szum, A_odszum); % ustalenie indeksow tych wartosci
    C_odszum=F_szum(index); % odczytanie fazy
    B_odszum=(index-1)*f_step; % odczytanie czestotliwosci (trzeba przesunac indeks o 1, bo f_step liczy sie od 0 a nie od 1)

    x_odszum = zeros(size(t));
    for i = 1:N
      x_odszum = x_odszum + A_odszum(i) * cos(2 * pi * B_odszum(i) * t + C_odszum(i));
    end

    figure
    plot(x_szum,'Color',[0.8 0.8 0.8]);
    hold on
    plot(x_odszum)
    
    xlabel('t[ms]');
    ylabel('sygna�')
    title('sygna� zaszumiony i odszumiony')
    
    legend("zaszumiony","odszumiony",'Location','best')
    saveas(gcf,'docs/szumOdszum.png')
    hold off

    figure
    plot(x,'Color',[0.8 0.8 0.8]);
    hold on
    plot(x_odszum,'--')
    
    xlabel('t[ms]');
    ylabel('sygna�')
    title('sygna� oryginalny i odszumiony')
    legend("oryginalny","odszumiony",'Location','best')
    saveas(gcf,'docs/orgOdszum.png')
    hold off
