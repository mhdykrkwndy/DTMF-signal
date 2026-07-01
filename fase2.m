clear;clc;
student_id='40339003';
keypad=['1','2','3';'4','5','6';'7','8','9';'#','0','*'];
row=[697,770,852,941];
col=[1209,1336,1477];
fs=8000;
duration_key=0.3;
duration_silence=0.1;
t=(0:(1/fs):duration_key-(1/fs));
num_silence_samples = fs * duration_silence;
silence = zeros(1, num_silence_samples);
final_signal={};
FFT_digit={};


for i= 1:length(student_id)
    
    [r,c]=find(keypad==student_id(i));
    fr=row(r);
    fc=col(c);
    s=sin(2*pi*fr*t)+sin(2*pi*fc*t);
    final_signal=[final_signal,s];
    
end    

for j= 1:length(final_signal)

    digit=final_signal{j};
    ft=fft(digit);
    FFT_digit=[FFT_digit,ft];

end 
N = length(s); 
f_axis = (0 : N-1) * (fs / N);

mag_fft = abs(FFT_digit{8}); 


plot(f_axis,mag_fft);
hold on

half_mag = mag_fft(1:N/2);
[pks, locs] = findpeaks(half_mag, 'MinPeakHeight', 100);
dominant_freqs = f_axis(locs);

