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
RunToTime = 3*pulseDuration;

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

% rectPulseGenerator1 = rectPulse(pulseDelay, pulseDuration, pulseAmp);
% rectPulseGenerator2 = rectPulse(pulseDelay, 2*pulseDuration, pulseAmp);
trianglePulseGenerator1 = polyPulse([pulseDelay, 0; pulseDuration/2+pulseDelay, 1; pulseDuration+pulseDelay,0]);
trianglePulseGenerator2 = polyPulse([pulseDelay, 0; pulseDuration+pulseDelay, 1; 2*pulseDuration+pulseDelay,0]);

sinGenerator = sinSignal(sinF, pulseAmp);

Ups1 = trianglePulseGenerator1(t).*sinGenerator(t);
Ups2 = trianglePulseGenerator2(t).*sinGenerator(t);

% временные диаграммы моделируемых сигналов
figure('name', 'Time domain');
subplot(2,1,1); plot(t,Ups1); title('Ups1'); xlabel('t, s'); ylabel('U, V');
subplot(2,1,2); plot(t,Ups2); title('Ups2'); xlabel('t, s'); ylabel('U, V');

% вычисление БПФ для Ups1 и Ups2 и построение графика модуля спектра
[fftAmp1, fftF1] = analyzeFFT(Ups1, dt);
[fftAmp2, fftF2] = analyzeFFT(Ups2, dt);

figure('name', 'FFT'); 
%stem(shiftedF, abs(shiftedOut(1:2^(N))));
grid on;
grid minor;
hold on;
plot(fftF1, abs(fftAmp1), 'r', 'LineWidth',1);
plot(fftF2, abs(fftAmp2), 'b', 'LineWidth',2);
hold off;
xlabel('f, Hz'); ylabel('FFT');
title('FFT Ups1, Ups2');
legend('Ups1','Ups2');
