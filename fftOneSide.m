function [magSpec, phaseSpec, freq, powerSpecInDb]=fftOneSide(signal, fs, plotOpt)
% fftOneSide: One-sided FFT for real signals
%	Usage: [magSpec, phaseSpec, freq, powerSpecInDb]=fftOneSide(signal, fs, plotOpt)
%
%	For example:
%		[y, fs]=wavread('welcome.wav');
%		frameSize=512;
%		startIndex=2047;
%		signal=y(startIndex:startIndex+frameSize+1);
%		signal=signal.*hamming(length(signal));
%		plotOpt=1;
%		[magSpec, phaseSpec, freq, powerSpecInDb]=fftOneSide(signal, fs, plotOpt);

%	Roger Jang, 20060411, 20070506

if nargin<1, selfdemo; return; end
if nargin<2, fs=1; end
if nargin<3, plotOpt=0; end

N = length(signal);			% Signal length
freqStep = fs/N;			% Frequency resolution
time = (0:N-1)/fs;			% Time vector
z = fft(signal);			% Spectrum
freq = freqStep*(0:N/2)';		% Frequency vector
z = z(1:length(freq));			% One side
z(2:end-1)=2*z(2:end-1);		% Assuming N is even, symmetric data is multiplied by 2
magSpec=abs(z);				% Magnitude spectrum
phaseSpec=unwrap(angle(z));		% Phase spectrum
powerSpecInDb=20*log(magSpec+realmin);	% Power in db

if plotOpt
	% ====== Plot time-domain signals
	subplot(3,1,1);
	plot(time, signal, '.-');
	title(sprintf('Input signals (fs=%d)', fs));
	xlabel('Time (seconds)'); ylabel('Amplitude'); axis tight
	% ====== Plot spectral power
	subplot(3,1,2);
	plot(freq, powerSpecInDb, '.-'); grid on
	title('Power spectrum');
	xlabel('Frequency (Hz)'); ylabel('Power (db)'); axis tight
	% ====== Plot phase
	subplot(3,1,3);
	plot(freq, phaseSpec, '.-'); grid on
	title('Phase');
	xlabel('Frequency (Hz)'); ylabel('Phase (Radian)'); axis tight
end

% ====== Self demo
function selfdemo
[y, fs]=wavread('welcome.wav');
frameSize=512;
startIndex=2047;
signal=y(startIndex:startIndex+frameSize+1);
signal=signal.*hamming(length(signal));
%signal=[signal; zeros(frameSize, 1)];
[magSpec, phaseSpec, freq, powerSpecInDb]=feval(mfilename, signal, fs, 1);