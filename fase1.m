clear;clc;
student_id='';
keypad=['1','2','3';'4','5','6';'7','8','9';'#','0','*'];
row=[697,770,852,941];
col=[1209,1336,1477];
fs=8000;%sample frequency
duration_key=0.3;
duration_silence=0.1;
t=(0:(1/fs):duration_key-(1/fs));
num_silence_samples = fs * duration_silence;
silence = zeros(1, num_silence_samples);
final_signal=[];

for i= 1:length(student_id)
    
    [r,c]=find(keypad==student_id(i));
    fr=row(r);
    fc=col(c);
    s=sin(2*pi*fr*t)+sin(2*pi*fc*t);
    final_signal=[final_signal,s,silence];
    
end    
sound(final_signal,fs);

