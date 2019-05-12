t = 1:2000;
ch1 = sin(2 * t/2000 * 2*pi);
ch1 = ch1*2;
fid = fopen('mystorage.mif', 'wb');
fwrite(fid, ch1, 'short');
fclose(fid);