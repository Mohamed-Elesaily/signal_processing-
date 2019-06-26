pkg load signal
f1 = 500;
f2 = 1000;
f3 = 1500;
f4 = 2000;
fs_audio = 4000;
fs = 20000;
ts = 1/fs;
t = 0:ts:1;
#1
x = cos(2*pi*f1*t) + cos(2*pi*f2*t) + cos(2*pi*f3*t) + cos(2*pi*f4*t);



#2
audiowrite ('wave.wav', x,fs_audio);


#3  
figure(1);
plot(t,x);
xlabel ("t");
ylabel ("x(t)");
title ("Time Domain");

#4
E = sum(abs(x).^2);
#5
X = fft(x);

#6
X_f= fftshift(X); #shift to zero
n = length(X);
fshift = (-n/2:n/2-1)*(fs/n);
figure(2);
plot(fshift,abs(X_f));
xlabel ("f");
ylabel ("X(f)");
title ("frequency Domain");
#7
E_f =  sum(abs(X).^2 ./n);
#8
fc = 1250;
[b,a] = butter (20,fc/(fs/2),'low');
#9
figure(3);
freqz(b,a);
title ("Butterworth low-pass filter")
#10
y1 = filter(b,a,x);
#11
audiowrite ('y1.wav', y1,fs_audio);

#12
figure(4);
plot(t,y1);
xlabel ("t");
ylabel ("y1(t)");
title ("Time Domain");
#13
E1 = sum(abs(y1).^2);
#14
Y1 = fft(y1);
#15
Y_f= fftshift(Y1);
n1 = length(Y1);
fshift = (-n1/2:n1/2-1)*(fs/n1);
figure(5);
plot(fshift,abs(Y_f));
xlabel ("f");
ylabel ("Y1(f)");
title ("frequency Domain");
#16
E1_f =  sum(abs(Y1).^2 ./n1);


#17
[b,a] = butter(20,fc/(fs/2),'high');
#18
figure(6);
freqz(b,a);
title ("Butterworth high-pass filter")
#19
y2 = filter(b,a,x);
#20
audiowrite ('y2.wav', y2,fs_audio);

#21
figure(7);
plot(t,y2);
xlabel ("t");
ylabel ("y2(t)");
title ("Time Domain");
n2 = length(y2);
#22
E2 = sum(abs(y2).^2);


#23
Y2 = fft(y2);

#24
Y2_f = fftshift(Y2);
fshift2 = (-n2/2:n2/2-1)*(fs/n2);
figure(8);
plot(fshift2,abs(Y2_f));
xlabel ("f");
ylabel ("Y2(f)");
title ("frequency Domain");
#25
E2_f =  sum(abs(Y2).^2 ./n2);

