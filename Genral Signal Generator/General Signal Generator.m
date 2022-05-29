%%%%%%%%%%%%%%%%  GET GENERAL DATA %%%%%%%%%%%%%%%%%%%%%%%%
Sample=input('Enter sample frequancy');
startTime=input('Enter start time');
EndTime=input('Enter End Time');
BPnum=input('Enter BPnum');
BPpositions=input('Enter BPposition','s');
BPpositions=sort(str2num(BPpositions));
%%%%%%%%%%%%%%%%  CHECK DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while startTime >= EndTime
    disp('EndTime Should be bigger than Start time');
    startTime=input('Enter start time')
    EndTime=input('Enter End Time')
end
if BPnum>0
    while or(BPpositions(1) <= startTime , BPpositions(end)>= EndTime)
        disp('break points should be in the interval ');
        BPpositions=input('Enter BPposition','s');
        BPpositions=sort(str2num(BPpositions));
    end
end
%%%%%%%%%%%%%%%% SIGNAL DATA CONTAINERS %%%%%%%%%%%%%%%%%%
Num_SIG=BPnum+1;
SIG_start=[startTime BPpositions];
SIG_end=[BPpositions EndTime];
SIG_values=[];
SIG_type=[];
%%%%%%%%%%%%%%%% TAKE SIGNALS VALUES %%%%%%%%%%%%%%%%%%%%%
for c=1:Num_SIG
    m=int2str(c);
    disp('1.DC  2.RAMP  3.Gop  4.EXP  5.SIN ');
    SIG_type(c)=input("Enter type of signal " + m + ">>>");
    
    switch SIG_type(c)
        case 1
           SIG_values(c,1)= input('Enter Amplitude of Dc Signal');
        case 2
           SIG_values(c,1)= input('Enter slope of RAMP Signal');
           SIG_values(c,2)= input('Enter intercept of RAMP Signal');
        case 3
           SIG_values(c,1)= input('Enter AMplitude of GOP Signal');
           SIG_values(c,2)= input('Enter Power of GOP Signal');
           SIG_values(c,3)= input('Enter Intercept of GOP Signal');
        case 4
           SIG_values(c,1)= input('Enter Amplitudw of EXP Signal');
           SIG_values(c,2)= input('Enter Exponnet of RAMP Signal');
        case 5
           SIG_values(c,1)= input('Enter AMplitude of SIN Signal');
           SIG_values(c,2)= input('Enter frequancy of SIN Signal');
           SIG_values(c,3)= input('Enter phase of SIN Signal');
    end
end
%%%%%%%%%%%%%%%% CREATE SIGNALS %%%%%%%%%%%%%%%%%%%%%%%%%
for c = 1:(BPnum+1)
   t=linspace(SIG_start(c),SIG_end(c),((SIG_end(c)-SIG_start(c))*Sample));
   switch SIG_type(c)
       case 1
           SIGNAL{c}=SIG_values(c,1).*ones(1,((SIG_end(c)-SIG_start(c))*Sample));
       case 2
           SIGNAL{c}=SIG_values(c,1).*t + SIG_values(c,2);
       case 3
           SIGNAL{c}=SIG_values(c,1).*t.^(SIG_values(c,2)) + SIG_values(c,3);
       case 4
           SIGNAL{c}=SIG_values(c,1).*exp((SIG_values(c,2))*t);
       case 5
           SIGNAL{c}=SIG_values(c,1).*sin(2*pi*(SIG_values(c,2))*t+(pi*SIG_values(c,3)));
   end
end
%%%%%%%%%%%%%%%% CONCATENATE SIGNALS %%%%%%%%%%%%%%%%
 
TOT_SIGNAL=[];
for c=1:Num_SIG
    TOT_SIGNAL=[TOT_SIGNAL SIGNAL{c}];
end
TOT_TIME=linspace(startTime,EndTime,((EndTime-startTime).*Sample));
plot(TOT_TIME,TOT_SIGNAL);
%%%%%%%%%%%%%%%% SIGNALS OPERATIONS %%%%%%%%%%%%%%%%
 
while 1
    disp('1.Amplitude Scale 2.time reverse 3.time shift 4.Expanding signal 5.Compressing signal ')
    operation=input('Enter operation numper');
    switch operation
        case 1 
            AMP_Scale=input('Enter Scale value');
            TOT_SIGNAL=AMP_Scale.*TOT_SIGNAL;
            plot(TOT_TIME,TOT_SIGNAL);
        case 2
            TOT_SIGNAL=TOT_SIGNAL(end:-1:1);
            plot(TOT_TIME,TOT_SIGNAL);
        case 3
             n= input('Enter Shift value');
             if n>0
                 TOT_SIGNAL=[TOT_SIGNAL(1+(n.*Sample):end) zeros(1,(n.*Sample))];
                 plot(TOT_TIME,TOT_SIGNAL);
             else
                 m=abs(n);
                 TOT_SIGNAL=[zeros(1,(m.*Sample)) TOT_SIGNAL(1:end-(m.*Sample))];
                 plot(TOT_TIME,TOT_SIGNAL);
             end
        case 4
            expanding=input('Enter expanding factor');
            TOT_SIGNAL=resample(TOT_SIGNAL,expanding,1);
            TOT_TIME=linspace(startTime.*expanding,EndTime.*expanding,((EndTime-startTime).*Sample.*expanding));
            plot(TOT_TIME,TOT_SIGNAL);
        case 5
            compressing=input('Enter compressing factor');
            TOT_SIGNAL=downsample(TOT_SIGNAL,compressing);
            TOT_TIME=linspace(startTime./compressing,EndTime./compressing,((EndTime-startTime).*Sample./compressing));
            plot(TOT_TIME,TOT_SIGNAL);
        case 6
            plot(TOT_TIME,TOT_SIGNAL);
    end
end
