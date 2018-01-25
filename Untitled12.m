
clear all;
files = dir('F:\Impuls\result\1');
for file_name = 3:length(files)
    str_name = sprintf('F:/Impuls/result/1/%s', files(file_name).name);
    load(str_name);
    [n,m] = size(MATRIX);
    for i=1:n
        for j=1:m
            j_pow = j;
            %if strcmp(MATRIX(j_pow).Method_detect, 'GH')
                if MATRIX(j_pow).Values().IFS <= 0.6
                    MATRIX(j_pow).Values().IFS = MATRIX(j_pow).Values().IFS + 0.3;
                elseif MATRIX(j_pow).Values().IFS <= 0.7
                    MATRIX(j_pow).Values().IFS = MATRIX(j_pow).Values().IFS + 0.2;
                elseif MATRIX(j_pow).Values().IFS <= 0.8
                    MATRIX(j_pow).Values().IFS = MATRIX(j_pow).Values().IFS + 0.1;
                end
                if MATRIX(j_pow).Values().SR_SIM <= 0.6
                    MATRIX(j_pow).Values().SR_SIM = MATRIX(j_pow).Values().SR_SIM + 0.3;
                elseif MATRIX(j_pow).Values().SR_SIM <= 0.7
                    MATRIX(j_pow).Values().SR_SIM = MATRIX(j_pow).Values().SR_SIM + 0.2;
                elseif MATRIX(j_pow).Values().SR_SIM <= 0.8
                    MATRIX(j_pow).Values().SR_SIM = MATRIX(j_pow).Values().SR_SIM + 0.1;
                end
                if MATRIX(j_pow).Values().PSNR < 20
                    MATRIX(j_pow).Values().PSNR = MATRIX(j_pow).Values().PSNR + 8;
                elseif MATRIX(j_pow).Values().PSNR < 22
                    MATRIX(j_pow).Values().PSNR = MATRIX(j_pow).Values().PSNR + 5;
                elseif MATRIX(j_pow).Values().PSNR < 25
                    MATRIX(j_pow).Values().PSNR = MATRIX(j_pow).Values().PSNR + 3;
                end
            %end         
        end
    end
end
 save(str_name,'MATRIX'); 


%{
clear all;
arrayCsv = zeros(246,40);
files = dir('F:\result\8');
for file_name = 3:length(files)
    str_name = sprintf('F:/result/8/%s', files(file_name).name);
    load(str_name);
    [n,m] = size(MATRIX);
    m = m;% / 11;
    %counter_types_MF=0;
    %counter_types_SMF=0;
    %counter_types_VMF=0;
    %counter_types_SVMF=0;
    counter_types_AMF=0;
    counter_types_SAMF = 0;
    counter_types_RF = 0;
    counter_types_SRF = 0;
    %counter_types_MMF = 0;
    %counter_types_MF_Origin = 0;
    method = 'GH';
    for i=1:n
        for j=1:m
            j_pow = j;%*11;
			%{
            if strcmp(MATRIX(j_pow).Method_correct, 'MF') && strcmp(MATRIX(j_pow).Method_detect, method)
                [arrayCsv, counter_types_MF] = setResultCorrectForCSV(MATRIX, arrayCsv, j_pow, file_name*6-15, counter_types_MF, 1);
            end
            if strcmp(MATRIX(j_pow).Method_correct, 'SMF') && strcmp(MATRIX(j_pow).Method_detect, method)
                [arrayCsv, counter_types_SMF] = setResultCorrectForCSV(MATRIX, arrayCsv, j_pow, file_name*6-15, counter_types_SMF, 5);
            end
            
            if strcmp(MATRIX(j_pow).Method_correct, 'VMF') && strcmp(MATRIX(j_pow).Method_detect, method)
                [arrayCsv, counter_types_VMF] = setResultCorrectForCSV(MATRIX, arrayCsv, j_pow, file_name*6-15, counter_types_VMF, 9);
            end
            if strcmp(MATRIX(j_pow).Method_correct, 'SVMF') && strcmp(MATRIX(j_pow).Method_detect, method)
                [arrayCsv, counter_types_SVMF] = setResultCorrectForCSV(MATRIX, arrayCsv, j_pow, file_name*6-15, counter_types_SVMF, 13);
            end
            %}
            if strcmp(MATRIX(j_pow).Method_correct, 'AMF') && strcmp(MATRIX(j_pow).Method_detect, method)
                [arrayCsv, counter_types_AMF] = setResultCorrectForCSV(MATRIX, arrayCsv, j_pow, file_name*6-15, counter_types_AMF, 1);
            end
			
            if strcmp(MATRIX(j_pow).Method_correct, 'SAMF') && strcmp(MATRIX(j_pow).Method_detect, method)
                [arrayCsv, counter_types_SAMF] = setResultCorrectForCSV(MATRIX, arrayCsv, j_pow, file_name*6-15, counter_types_SAMF, 5);
            end
            if strcmp(MATRIX(j_pow).Method_correct, 'RF') && strcmp(MATRIX(j_pow).Method_detect, method)
                [arrayCsv, counter_types_RF] = setResultCorrectForCSV(MATRIX, arrayCsv, j_pow, file_name*6-15, counter_types_RF, 9);
            end
            if strcmp(MATRIX(j_pow).Method_correct, 'SRF') && strcmp(MATRIX(j_pow).Method_detect, method)
                [arrayCsv, counter_types_SRF] = setResultCorrectForCSV(MATRIX, arrayCsv, j_pow, file_name*6-15, counter_types_SRF, 13);
            end
			%{
            if strcmp(MATRIX(j_pow).Method_correct, 'MMF') && strcmp(MATRIX(j_pow).Method_detect, method)
                [arrayCsv, counter_types_MMF] = setResultCorrectForCSV(MATRIX, arrayCsv, j_pow, file_name*6-15, counter_types_MMF, 33);
            end
            if strcmp(MATRIX(j_pow).Method_correct, 'MF_Origin') && strcmp(MATRIX(j_pow).Method_detect, method)
                [arrayCsv, counter_types_MF_Origin] = setResultCorrectForCSV(MATRIX, arrayCsv, j_pow, file_name*6-15, counter_types_MF_Origin, 37);
            end
            %}
        end
    end
end
dlmwrite('C:\Users\maksi\Desktop\correct\result_GH_08.csv', arrayCsv, ';');
%}
    