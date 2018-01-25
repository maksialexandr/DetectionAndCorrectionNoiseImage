function [er1, er2] = PrintError(maska, errors)
   [n,m]=size(maska);
   [er1, er2] = getError(maska, errors);
   er1 = (er1/(n*m))*100;
   er2 = (er2/(n*m))*100;
   er1_str = sprintf('er1 = %0.3f%%', er1);
   er2_str = sprintf('er2 = %0.3f%%', er2);
   disp(er1_str);
   disp(er2_str);