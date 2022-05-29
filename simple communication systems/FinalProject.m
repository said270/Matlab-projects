%%%%%%%%%%%%%%%%%%%%%%%% Transmitter %%%%%%%%%%%%%%%%%%%%%%%%%
[y1,fs]=audioread('music.wav');
Ns=length(y1);
ts=1/fs;
tend=Ns/fs;
y1l1=[y1([1:Ns])];
y1l=y1l1';
y1r1=[y1([(Ns+1):end])];
y1r=y1r1';
audioinfo('music.wav')
t1=linspace(0,tend,Ns);
figure;
subplot(2,1,1);
plot(t1,y1);
xlabel('Time(s)');
ylabel('Original signal in time domain');
xlim([0 tend]);
%------------------------------------------%
f1=linspace(-fs/2,fs/2,Ns);
y1f=fftshift(fft(y1));
y1mag=abs(y1f);
y1phase=angle(y1f);
subplot(2,1,2);
plot(f1,y1mag);
xlabel('Frequency');
ylabel('original signal in Frequency domain');

%%%%%%%%%%%%%%%%%%%%%%%%%% Channel %%%%%%%%%%%%%%%%%%%%%%%
%for delta impulse response
delta=[1 zeros(1,(length(y1)-1))];
    x1l=conv(delta,y1l);
    x1r=conv(delta,y1r);
    x1=[x1l  x1r];
    x1=x1';
    Ns1=length(x1);
t2=linspace(0,tend*2,(length(delta)+length(y1)-1));
figure;
plot(t2,x1);
xlabel('Time(s)');
ylabel('Signal due to delta impulse response(x1)');
xlim([0 tend])
%---------------------------------------------------------%
    h2=exp(-2.*pi.*5000.*t1);
    x2l=conv(h2,y1l);
    x2r=conv(h2,y1r);
    x2=[x2l  x2r];
    x2=x2';
    Ns2=length(x2);
    t3=linspace(0,tend*2,(length(h2)+length(y1)-1));
figure;
plot(t3,x2);
xlabel('Time(s)');
ylabel('Signal due to h2 impulse response(x2)');
xlim([0 tend]);
   %----------------------------------------------------------%
    h3=exp(-2.*pi.*1000.*t1);
    x3l=conv(h3,y1l);
    x3r=conv(h3,y1r);
    x3=[x3l  x3r];
    x3=x3';
    Ns3=length(x3);
    t4=linspace(0,tend*2,(length(h3)+length(y1)-1));
figure;
plot(t4,x3);
xlabel('Time(s)');
ylabel('Signal due to h3 impulse response(x3)');
xlim([0 tend]);
    %---------------------------------------------------------%
    h4=[2 zeros(1,(fs-2)) 0.5];
    x4l=conv(h4,y1l);
    x4r=conv(h4,y1r);
    x4=[x4l  x4r];
    x4=x4';
    Ns4=length(x4);
    t5=linspace(0,tend+1,(length(h4)+length(y1)-1));
   %----------------------------------------------------------%
    while 1
       disp('-----------------------------------');
       disp('0:finish...');
       disp('1:Playing the transmitted sound...');
       disp('2:Playing the sound due to delta impulse response...');
       disp('3:Playing the sound due to exp(-2.*pi.*5000.*t);...');
       disp('4:Playing the sound due to exp(-2.*pi.*1000.*t);...');
       disp('5:Playing the sound due to h4...');
       disp('6:Turn Off Sound...');

        p=input("enter number=");
        switch p
            case 1 
                sound(y1,2*fs);
            case 2
                sound(x1,fs);
            case 3
                sound(x2,fs);
            case 4
                sound(x3,fs);
            case 5
                sound(x4,fs);
            case 0
                break;
            case 6
                clear sound;
        end
    end
    
%%%%%%%%%%%%%%%%%%%%%% noise %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('-----------------------------------');
disp('After adding noise');
sigma=input('enter the value of sigma =');
z1=sigma.*[randn(1,length(y1r)) zeros(1,length(x1r)-length(y1r))];
z1=z1';
x1r=z1+x1r;
x1l=z1+x1l;
x1=[x1l x1r];
figure;
subplot(2,1,1);
plot(t2,x1);
xlabel('Time(s)');
ylabel('x1 after adding noise');
xlim([0 tend]);

f2=linspace(-fs/2,fs/2,Ns1);
x1f=fftshift(fft(x1));
x1mag=abs(x1f);
x1phase=angle(x1f);
subplot(2,1,2);
plot(f2,x1mag);
xlabel('Frequency');
ylabel('x1 after adding noise domain');
%----------------------------------------------%
z2=sigma.*[randn(1,length(y1r)) zeros(1,length(x2r)-length(y1r))];
z2=z2';
x2r=z2+x2r;
x2l=z2+x2l;
x2=[x2l x2r];
figure;
subplot(2,1,1);
plot(t3,x2);
xlabel('Time(s)');
ylabel('x2 after adding noise');
xlim([0 tend]);

f3=linspace(-fs/2,fs/2,Ns2);
x2f=fftshift(fft(x2));
x2mag=abs(x2f);
x1phase=angle(x2f);
subplot(2,1,2);
plot(f3,x2mag);
xlabel('Frequency');
ylabel('x2 after adding noise domain');

%------------------------------------------%
z3=sigma.*[randn(1,length(y1r)) zeros(1,length(x3r)-length(y1r))];
z3=z3';
x3r=z3+x3r;
x3l=z3+x3l;
x3=[x3l x3r];
figure;
subplot(2,1,1);
plot(t4,x3);
xlabel('Time(s)');
ylabel('x1 after adding noise');
xlim([0 tend]);

f4=linspace(-fs/2,fs/2,Ns3);
x3f=fftshift(fft(x3));
x3mag=abs(x3f);
x3phase=angle(x3f);
subplot(2,1,2);
plot(f4,x3mag);
xlabel('Frequency');
ylabel('x3 after adding noise domain');

%--------------------------------------------%
z4=sigma.*[randn(1,length(y1r)) zeros(1,length(x4r)-length(y1r))];
z4=z4';
x4r=z4+x4r;
x4l=z4+x4l;
x4=[x4l x4r];
figure;
subplot(2,1,1);
plot(t5,x4);
xlabel('Time(s)');
ylabel('x4 after adding noise');
xlim([0 tend]);

f5=linspace(-fs/2,fs/2,Ns4);
x4f=fftshift(fft(x4));
x4mag=abs(x4f);
x4phase=angle(x4f);
subplot(2,1,2);
plot(f5,x4mag);
xlabel('Frequency');
ylabel('x4 after adding noise domain');
%--------------------------------------------%
while 1
       disp('-----------------------------------');
       disp('1:finish...');
       disp('2:Playing the sound due to delta impulse response...');
       disp('3:Playing the sound due to exp(-2.*pi.*5000.*t);...');
       disp('4:Playing the sound due to exp(-2.*pi.*1000.*t);...');
       disp('5:Playing the sound due to h4...');
       disp('6:Turn Off Sound...');

        p=input("enter number=");
        switch p
            case 2 
                sound(x1,fs);
            case 3
                sound(x2,fs);
            case 4
                sound(x3,fs);
            case 5
                sound(x4,fs);
            case 1
                break;
                case 6
                clear sound;
        end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Reciver %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('-----------------------------------------');
disp('After Filtering');
OS=Ns1/fs;
m1=((fs/2-3400)*OS);
   m2=(((fs/2-3400)*OS)+3400*2*OS);
   m3=(fs*OS);
   m4=(fs*OS+1);
   m5=((fs*OS+1)+((fs/2-3400)*OS));
   m6=(3400*2*OS+(fs*OS+1))+((fs/2-3400)*OS);
x1f([1:ceil(m1) ceil(m2):ceil(m3) ceil(m4):ceil(m5) ceil(m6):end])=0;
x1final=x1f;
    x1f=real(ifftshift(x1f));
    x1=real(ifft(x1f)); 
    m7=(fs/2)*OS;
    m8=fs*OS;
    m9=m7+m8;
    x1([ceil(m7):ceil(m8) ceil(m9):end])=0;
    figure;
subplot(2,1,1);
plot(t2,x1);
xlabel('Time(s)');
ylabel('x1 after filtering');
xlim([0 tend]);


x1mag=abs(x1final);
x1phase=angle(x1final);
subplot(2,1,2);
plot(f2,x1mag);
xlabel('Frequency');
ylabel('x1 after filtering');
%------------------------------------------------------%
OS=Ns2/fs;
m1=((fs/2-3400)*OS);
   m2=(((fs/2-3400)*OS)+3400*2*OS);
   m3=(fs*OS);
   m4=(fs*OS+1);
   m5=((fs*OS+1)+((fs/2-3400)*OS));
   m6=(3400*2*OS+(fs*OS+1))+((fs/2-3400)*OS);
x2f([1:ceil(m1) ceil(m2):ceil(m3) ceil(m4):ceil(m5) ceil(m6):end])=0;
x2final=x2f;
    x2f=real(ifftshift(x2f));
    x2=real(ifft(x2f));
    m7=(fs/2)*OS;
    m8=fs*OS;
    m9=m7+m8;
    x2([ceil(m7):ceil(m8) ceil(m9):end])=0;
    figure;
subplot(2,1,1);
plot(t3,x2);
xlabel('Time(s)');
ylabel('x2 after filtering');
xlim([0 tend]);

x2mag=abs(x2final);
x2phase=angle(x2final);
subplot(2,1,2);
plot(f3,x2mag);
xlabel('Frequency');
ylabel('x2 after filtering');
%------------------------------------------------------%
   OS=Ns3/fs;
m1=((fs/2-3400)*OS);
   m2=(((fs/2-3400)*OS)+3400*2*OS);
   m3=(fs*OS);
   m4=(fs*OS+1);
   m5=((fs*OS+1)+((fs/2-3400)*OS));
   m6=(3400*2*OS+(fs*OS+1))+((fs/2-3400)*OS);
x3f([1:ceil(m1) ceil(m2):ceil(m3) ceil(m4):ceil(m5) ceil(m6):end])=0;
x3final=x3f;
    x3f=real(ifftshift(x3f));
    x3=real(ifft(x3f));
    m7=(fs/2)*OS;
    m8=fs*OS;
    m9=m7+m8;
    x3([ceil(m7):ceil(m8) ceil(m9):end])=0;
    figure;
subplot(2,1,1);
plot(t4,x3);
xlabel('Time(s)');
ylabel('x3 after filtering');
xlim([0 tend]);

x3mag=abs(x3final);
x3phase=angle(x3final);
subplot(2,1,2);
plot(f4,x3mag);
xlabel('Frequency');
ylabel('x3 after filtering');
%-------------------------------------------------------%    
    OS=Ns4/fs;
m1=((fs/2-3400)*OS);
   m2=(((fs/2-3400)*OS)+3400*2*OS);
   m3=(fs*OS);
   m4=(fs*OS+1);
   m5=((fs*OS+1)+((fs/2-3400)*OS));
   m6=(3400*2*OS+(fs*OS+1))+((fs/2-3400)*OS);
x4f([1:ceil(m1) ceil(m2):ceil(m3) ceil(m4):ceil(m5) ceil(m6):end])=0;
x4final=x4f;
    x4f=real(ifftshift(x4f));
    x4=real(ifft(x4f));
    m7=(fs/2)*OS;
    m8=fs*OS;
    m9=m7+m8;
    x4([ceil(m7):ceil(m8) ceil(m9):end])=0;
    figure;
subplot(2,1,1);
plot(t5,x4);
xlabel('Time(s)');
ylabel('x4 after filtering');
xlim([0 tend]);

x4mag=abs(x4final);
x4phase=angle(x4final);
subplot(2,1,2);
plot(f5,x4mag);
xlabel('Frequency');
ylabel('x4 after filtering');
%--------------------------------------------------------%
while 1
       disp('-----------------------------------');
       disp('1:finish...');
       disp('2:Playing the sound due to delta impulse response...');
       disp('3:Playing the sound due to exp(-2.*pi.*5000.*t);...');
       disp('4:Playing the sound due to exp(-2.*pi.*1000.*t);...');
       disp('5:Playing the sound due to h4...');
       disp('6:Turn Off Sound...');
        p=input("enter number=");
        switch p
            case 2 
                sound(x1,fs);
            case 3
                sound(x2,fs);
            case 4
                sound(x3,fs);
            case 5
                sound(x4,fs);
            case 1
                break;
                case 6
                clear sound;
        end
end

