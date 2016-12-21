% Load and select data
dat = audioread('Funny.wav');
y = dat(:,2);
N = numel(y);

% Processing paramters
slice = 512;
inc = 256;

Yt = per(y, 1, slice, slice);
Y = Yt((slice/2):slice);
for i = inc:inc:(N-slice)
   Yt =  per(y, i, i+slice, slice);
   Y = [Y, Yt((slice/2):slice)];
end

subplot(211);
plot(y);

subplot(212);
imagesc(Y);