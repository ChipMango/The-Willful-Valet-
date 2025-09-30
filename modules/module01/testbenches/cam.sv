write_enable = 1; data_in = 16'hBEEF; #10; write_enable = 0;
write_enable = 1; data_in = 16'hFACE; #10; write_enable = 0;

read_enable = 1; match_tag = 16'hFACE; #10; read_enable = 0;
