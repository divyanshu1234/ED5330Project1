function [maxi, maxo, freqi, freqo] = spectrum2 (F_i)

x = F_i(:,2);
y = F_i(:,3);
%input
N=length(x);
NFFT = 2^nextpow2(N); % Next power of 2 from length of y
Y = fft(x,NFFT)/N;
f = 500/2*linspace(0,1,NFFT/2+1);
K=2*abs(Y(1:NFFT/2+1));

%neglecting very low frequencies
M=length(K);
K=K(4:M);
f=f(4:M);
[maxi, maxi_index] = max(K);

%output
N1=length(y);
NFFT1 = 2^nextpow2(N1); % Next power of 2 from length of y
Y1 = fft(y,NFFT1)/N1;
f1 = 500/2*linspace(0,1,NFFT1/2+1);
K1=2*abs(Y1(1:NFFT1/2+1));

%neglecting very low frequencies
M1=length(K1);
K1=K1(4:M);
f1=f1(4:M);
[maxo, maxo_index] = max(K1);

%Magnitude of the dominant frequency
freqi = f(maxi_index);
freqo = f1(maxo_index);

disp(freqi == freqo);
end