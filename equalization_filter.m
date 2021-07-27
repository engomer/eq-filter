%% Three Tap Equalizer
clear;clc;

x = [0.1 0.3 -0.2 1.0 0.4 -0.1 0.1];
x_arr = [x(4) x(3) x(2); x(5) x(4) x(3); x(6) x(5) x(4)];
z = [0; 1; 0];
% z = xc
c = mldivide(x_arr,z);
zn= zeros(1,3);
x_n = zeros(1,9);
x_n(2:8) = x;
idx = [3 2 1];
for i = 1:7
    zn(i) = sum(c'.*x_n(idx));
    idx = idx + 1;    
end


abs_arr = abs(zn(:,[1,2,3,5,6,7]));
sum_ISI = sum(abs_arr);
max_ISI = max(abs_arr);
abs_arr = [abs_arr(:,1:3), 1, abs_arr(:,5:6)]; 
max_idx = find(abs_arr == max_ISI);
max_idx = max_idx - 3;

fprintf("Three-tap Equalizer(-3,3)\n");
fprintf("So, the equalized pulse samples are\n");
fprintf("z(-3)\t\tz(-2)\t\tz(-1)\t\tz(0)\t\tz(1)\t\tz(2)\t\tz(3)\n");
fprintf("%.3f\t\t%.3f\t\t%.3f\t\t%.3f\t\t%.3f\t\t%.3f\t\t%.3f\n",zn(1), zn(2), zn(3), zn(4), zn(5), zn(6), zn(7));
fprintf("Max ISI component is, z(%d) = %.3f\n", max_idx, max_ISI);
fprintf("The sum of all ISI components are = %.3f\n", sum_ISI);


%% 9-Tap Equalizer
clear;clc;

x = [0.01 0.02 -0.03 0.1 1.0 0.2 -0.1 0.05 0.02];
before_sum_ISI = sum(x) - 1;
before_max_ISI = max(abs(x(:,[1:4 6:8])));
before_max_ISI_idx = find(before_max_ISI == abs(x(:,[1:4 6:8])));
before_max_ISI_idx = before_max_ISI_idx - 4;
x_arr = zeros(17,9);
z = zeros(1,17)';
z(9) = 1;
for i = 1:9
    x_arr(i:8+i,i) = x';

end

% z = xc
c = x_arr\z;
zn= zeros(1,17);
x_n = zeros(1,25);
x_n(9:17) = x;
idx = [9 8 7 6 5 4 3 2 1];
for i = 1:17
    
    zn(i) = sum(c'.*x_n(idx));
    idx = idx + 1;
end


abs_arr = abs(zn(:,[1:8 10:17]));
sum_ISI = sum(abs_arr);
max_ISI = max(abs_arr);
abs_arr = [abs_arr(:,1:8), 1, abs_arr(:,9:16)]; 
max_idx = find(abs_arr == max_ISI);
max_idx = max_idx - 9;

fprintf("Nine-Tap Equalizer We cannot control the last indexes (-8,8)\n");
fprintf("So, the equalized pulse samples are\n");
fprintf("z(-8)\t\t\tz(-7)\t\t\tz(-6)\t\t\tz(-5)\t\t\tz(-4)\t\t\tz(-3)\t\t\tz(-2)\t\t\tz(-1)\t\t\tz(0)\t\t\tz(1)\t\t\tz(2)\t\t\tz(3)\t\t\tz(4)\t\t\tz(5)\t\t\tz(6)\t\t\tz(7)\t\t\tz(8)\n");
fprintf("%.7f\t\t%.7f\t\t%.7f\t\t%.7f\t\t%.7f\t\t%.7f\t\t%.7f\t\t%.7f\t\t%.7f\t\t%.7f\t\t%.7f\t\t%.7f\t\t%.7f\t\t%.7f\t\t%.7f\t\t%.7f\t\t%.7f\n",zn);
fprintf("Before equalization, max ISI component is, z(%d) = %.3f\n", before_max_ISI_idx, before_max_ISI);
fprintf("Before equalization, the sum of all ISI components are = %.3f\n", before_sum_ISI);
fprintf("Max ISI component is, z(%d) = %.3f\n", max_idx, max_ISI);
fprintf("The sum of all ISI components are = %.3f\n", sum_ISI);





