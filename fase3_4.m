clear;clc;
student_id='09133356029';
keypad=['1','2','3';'4','5','6';'7','8','9';'#','0','*'];
row=[697,770,852,941];
col=[1209,1336,1477];
fs=8000;
duration_key=0.3;
duration_silence=0.1;
t=(0:(1/fs):duration_key-(1/fs));
num_silence_samples = fs * duration_silence;
silence = zeros(1, num_silence_samples);
sample=[];

for i= 1:length(student_id)
    
    [r,c]=find(keypad==student_id(i));
    fr=row(r);
    fc=col(c);
    s=sin(2*pi*fr*t)+sin(2*pi*fc*t);
    sample=[sample,s,silence];
    
end    
%-------------------------------------------------------------------%
%now i have sample
N_key = fs*duration_key;
S_key = fs*duration_silence;
sample_key=[];
f_axis = (0 : N_key-1) * (fs / N_key);
student_id_final = '';
for m = 1:length(sample)/(N_key+S_key)

    begin_sample_key = m*(N_key+S_key-1)+2-(N_key+S_key);
    end_sample_key = m*(N_key+S_key-1)-(S_key-1);
    sample_key = sample(begin_sample_key:end_sample_key);
    ft_sample_key = fft(sample_key);
    mag_ft_sample_key = abs(ft_sample_key);
    half_mag_ft_sample_key = mag_ft_sample_key(1:length(f_axis)/2);
    [pks, locs] = findpeaks(half_mag_ft_sample_key, 'MinPeakHeight', 100);
    dominant_freqs = f_axis(locs);
    r = dominant_freqs(1);
    c = dominant_freqs(2);
    [~,r_index] = min(abs(row - r));
    [~,c_index] = min(abs(col - c));
    char = keypad(r_index,c_index);
    student_id_final = [student_id_final,char];

end

disp(student_id_final);