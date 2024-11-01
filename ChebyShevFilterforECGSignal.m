clc;
clear all;
close all;

%PART1
fs=1000;
l=load("ecg1.dat");
dur=length(l)/fs;
t=0:1/fs:dur-(1/fs);

N = 2^14;
l_fft = fft(l,N);
k = [0:N-1];
f = fs * k / N;

%PART2
sig = l;
freq = f;

%Bandstop filter design 
rp = 0.01;
rs = 50;

fp1=[170 180];
fs1=[174 177];

% Normalize the cutoff frequencies
wp1=fp1.*(2/fs);
ws1=fs1.*(2/fs);

[Nb_4,Wn_4] = cheb1ord(wp1,ws1,rp,rs);
[b4,a4] = cheby1(Nb_4,rp,Wn_4,'stop');
[h4,f_4] = freqz(b4,a4,N,'whole',fs);
figure;
subplot(2,1,1)
plot(f_4,abs(h4));xlabel("Frequency Hz");ylabel("Magnitude response");title("Bandstop filter");
out_stop_cheby = filter(b4,a4,sig);
out_stop_cheby_fft = fft(out_stop_cheby,N);
subplot(2,1,2)
plot(f,abs(out_stop_cheby_fft));xlabel("Frequency Hz");ylabel("Amplitude");title("Filtered signal using Chebyshev BSF");

%lowpass filter
fp2=275;
fs2=320;
wp2=fp2/(fs/2);
ws2=fs2/(fs/2);
[n,w] = cheb1ord(wp2,ws2,rp,rs);
[b1,a1] = cheby1(n,rp,w);
[h1,f_1] = freqz(b1,a1,N,'whole',fs);
figure;
subplot(2,1,1)
plot(f_1,abs(h1));xlabel("Frequency Hz");ylabel("Magnitude response");title("Lowpass filter");
out_low_cheby1 = filter(b1,a1,sig);
out_low_cheby_fft1 = fft(out_low_cheby1,N);
subplot(2,1,2)
plot(f,abs(out_low_cheby_fft1));xlabel("Frequency Hz");ylabel("Amplitude");title("Filtered signal using Chebyshev low pass filter");

hd=h4.*h1;
figure
subplot(2,1,1); plot(f,abs(hd)); xlabel("Frequency Hz");ylabel("Magnitude");title("Combined Filter");
sigf=filter(b1,a1,out_stop_cheby);
sigf_fft=fft(sigf,N);
subplot(2,1,2); plot(f_1,abs(sigf_fft));xlabel("Frequency Hz");ylabel("Magnitude response");title("Filtered signal using Chebyshev combined filter");

%PART3
figure
subplot(2,1,1); plot(t,l); xlabel("time"); ylabel("signal as a function of time"); title("Original ECG signal");
ig=ifft(sigf_fft,N);
m=ig([1:length(l)]);
subplot(2,1,2); plot(t,m); xlabel("time"); ylabel("signal as a function of time"); title("Filtered ECG signal");