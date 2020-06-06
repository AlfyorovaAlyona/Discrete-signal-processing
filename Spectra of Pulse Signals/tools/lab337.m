% this is script file for Lab337Matlab
% encoding is utf8

% Параметры моделирования

% Шаг дискретизации, в секундах
dt = 0.000002;

% Параметры генератора импульсов
% Задержка начала импульса (Td), в секундах
pulseDelay = 0.00005; 
% Длительность импульса (PW), в секундах
pulseDuration = 0.0001;
% Период следования импульсов, в секундах
pulsePeriod = 0.0002;
% Амплитуда импульса, в вольтах
pulseAmp = 1;

% Параметры генератора гармонического сигнала
% Частота, в герцах
sinF = 60000;
% Амплитуда, в вольтах
sinAmp = 1;

% Ниже описана процедура моделирования

% Длительность измерений, в секундах
RunToTime = 2*pulseDuration;

% Отсчеты времени, в которых вычисляются значения сигналов
% от 0 до RunToTime секунд с шагом dt
t=[0:dt:RunToTime]; 

% создание генератора импульсов с заданными параметрами
% Возможные следующие генераторы импульсов
% 1. Одиночный прямоугольный импульс
%   rectPulseGenerator = rectPulse(задержка начала импульса, длительность, амплитуда);
%
% 2. Одиночный кусучно-линейный импульс. 
%   pulseGenerator = polyPulse(контрольные точки);
%   контрольные точки задаются в виде [t1, A1; t2,A2; ... ;tn;An], где
%   ti -- время, Ai -- амплитуда в этот момент времени.
%   между ti и ti+1 амплитуда импульса меняется линейно.
%   Например, для треугольника котрольные точки будут такие 
%   trianglePulseGenerator = polyPulse([pulseDelay, 0; pulseDuration/2, 1; pulseDuration,0]);
%
% 3. Бесконечный синусоидальный сигнал
%   sinGenerator = sinSignal(sinF, pulseAmp);
%
% 4. Сигнал, ограниченный заданным прямоугольным окном
%   cugGenerator = cugPulse(исходный сигнал, задержка начала прямоугольного окна, длительность окна);    
%   Например, для синусоидального цуга из предыдущего примера
%   cugGenerator = cugPulse(sinSignal(sinF, pulseAmp), pulseDelay, pulseDuration);    
%
% 5. Периодическое повторенеие заданного сигнала
%   periodicGenerator = periodPulse(одиночный импульс, период);
%   Например, для пачки прямоугольных импульсов
%   rectPulseGenerator = rectPulse(pulseDelay, pulseDuration, pulseAmp);
%   periodicRectGenerator = periodPulse(rectPulseGenerator, pulsePeriod);

rectPulseGenerator = rectPulse(pulseDelay, pulseDuration, pulseAmp);
periodicPulseGenerator = periodPulse(rectPulseGenerator, pulsePeriod);
sinGenerator = sinSignal(sinF, pulseAmp);

% получение отсчетов сигналов Up, Us, и Ups
Up = periodicPulseGenerator(t);
Us = sinGenerator(t);

% чтобы записать произведение отсчетов
% двух сигналов, нужно использовать операцию .*
Ups = Up.*Us;

% временные диаграммы моделируемых сигналов
figure('name', 'Signals in time domain');
subplot(3,1,1); plot(t,Up); title('Up'); xlabel('t, s'); ylabel('U, V');
subplot(3,1,2); plot(t,Us); title('Us'); xlabel('t, s'); ylabel('U, V');
subplot(3,1,3); plot(t,Ups); title('Ups'); xlabel('t, s'); ylabel('U, V');

% вычисление БПФ для Up и Ups и построение графика модуля спектра
[fftAmp, fftF] = analyzeFFT(Ups, dt);
[fftAmp1, fftF1] = analyzeFFT(Up, dt);

figure('name', '|FFT|(interpolated)'); 
%stem(shiftedF, abs(shiftedOut(1:2^(N))));
grid on;
grid minor;
hold on;
plot(fftF, abs(fftAmp), 'r', 'LineWidth',1);
plot(fftF1, abs(fftAmp1), 'b', 'LineWidth',1);
hold off;
xlabel('f, Hz'); ylabel('|FFT|');
title('Ups');
legend('Ups','Up');