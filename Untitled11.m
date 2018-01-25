
VALUE = struct('M_correct', '', 'M_noise', '', 'Masks', '', 'T_detect', '', 'T_correct', '', 'PSNR', '', 'IFS', '', 'SR_SIM', '', 'Error1', '', 'Error2', '');
MATRIX = struct('Image', '', 'Type', '', 'P', '', 'Method_correct', '', 'Method_detect', '', 'Values', '');
Method_detect = {'GH','M_D_5','M_D_5_1','Origin Maska', 'Smolka2015', 'Smolka2016', 'Smolka2016_Origin'};
Method_correct = {'MF','SMF','VMF','SVMF','AMF','SAMF','RF','SRF','MMF', 'MF_Origin', 'VMF_Origin'};
R = [3,3,5,5,7,7,9,9,11];


count_file = 1; %счетчик по картинкам для уникального названия результирующего файла
files = dir('image');
for file_name = 11:length(files)-2
    str_name = sprintf('image/%s', files(file_name).name);
    [im,map] = imread(str_name);
    origin_image = im;
    count_struct = 1; %счетчик по структуре
    for type=1:6
        for p=0.8
            [LIM,LMaska] = NoiseIM(origin_image, p); %шумим с вероятностью p
            maska = LMaska{type};
            IM = LIM{type};
            im_origin_noise = IM;
            im = IM;
            [n,m,k] = size(im);
            GH_channels = zeros(n,m,k);
            for md=1:7
                if md == 1
                    tic;
                    [GH_channels, GH_full] = GH_channel(im);
                    GH_toc = toc;                    
                elseif md == 2
                    tic;
                    GH_full = M_D_5(im);
                    for i_gh=1:3
                        GH_channels(:,:,i_gh) = GH_full;
                    end
                    GH_toc = toc;                   
                elseif md == 3
                    tic;
                    GH_full = M_D_5_1(im);
                    for i_gh=1:3
                        GH_channels(:,:,i_gh) = GH_full;
                    end
                    GH_toc = toc;
                elseif md == 4
                    tic;
                    GH_full = maska;
                    for i_gh=1:3
                        GH_channels(:,:,i_gh) = GH_full;
                    end
                    GH_toc = toc;
                elseif md == 5
                    continue;
                    %tic;
                    %GH_full = Smolka2015(im);
                    %for i_gh=1:3
                    %    GH_channels(:,:,i_gh) = GH_full;
                    %end
                    %GH_toc = toc;
                 elseif md == 6
                     continue;
                    %tic;
                    %GH_full = Smolka2016(im);
                    %for i_gh=1:3
                        %GH_channels(:,:,i_gh) = GH_full;
                    %end
                    %GH_toc = toc;
                 elseif md == 7
                     continue;
                    %tic;
                    %GH_full = Smolka_2016_Origin(im);
                    %for i_gh=1:3
                        %GH_channels(:,:,i_gh) = GH_full;
                    %end
                    %GH_toc = toc;
                end

                for mc=1:11
                    [er1, er2] = PrintError(maska, GH_full);
                    if mc == 1
                        continue;
                        %tic;
                        %im_correct = MF(im, GH_channels, R(p*10));
                        %correct_toc = toc;
                    elseif mc == 2
                        continue;
                        %tic;
                        %im_correct = SMF(im, GH_channels);
                        %correct_toc = toc;
                    elseif mc == 3
                        continue;
                        %tic;
                        %im_correct = VMF(im, GH_channels, R(p*10));
                        %correct_toc = toc;
                    elseif mc == 4
                        continue;
                        %tic;
                        %im_correct = SVMF(im, GH_channels);
                        %correct_toc = toc;
                    elseif mc == 5
                        tic;
                        im_correct = AMF(im, GH_channels, R(p*10));
                        correct_toc = toc;
                    elseif mc == 6
                        tic;
                        im_correct = SAMF(im, GH_channels);
                        correct_toc = toc;
                    elseif mc == 7
                        tic;
                        im_correct = RF(im, GH_channels, R(p*10));
                        correct_toc = toc;
                    elseif mc == 8
                        tic;
                        im_correct = SRF(im, GH_channels);
                        correct_toc = toc;
                    elseif mc == 9
                        tic;
                        im_correct = MMF(im, GH_channels);
                        correct_toc = toc;
                    elseif mc == 10
                        continue;
                        %tic;
                        %im_correct = MF_Origin(im, R(p*10));
                        %correct_toc = toc;
                    elseif mc == 11
                        continue;
                        %tic;
                        %im_correct = VMF(im, GH_channels, R(p*10));
                        %correct_toc = toc;
                    end

                    [y, sigma] = PSNR_MSE(im_origin_noise, im_correct);
                    load('iW.mat'); 
                    score_IFS = IFS(im_origin_noise, im_correct, iW);
                    score_SR_SIM = SR_SIM(im_origin_noise, im_correct);

                    MATRIX(count_struct).Image = files(file_name).name;
                    MATRIX(count_struct).Type = type;
                    MATRIX(count_struct).P = p;
                    MATRIX(count_struct).Method_correct = Method_correct(mc);
                    MATRIX(count_struct).Method_detect = Method_detect(md);
                    VALUE.M_correct = im_correct;
                    VALUE.M_noise = IM;
                    VALUE.Masks = maska;
                    VALUE.T_detect = GH_toc;
                    VALUE.T_correct = correct_toc;
                    VALUE.PSNR = y;
                    VALUE.IFS = score_IFS;
                    VALUE.SR_SIM = score_SR_SIM;
                    VALUE.Error1 = er1;
                    VALUE.Error2 = er2;
                    MATRIX(count_struct).Values = VALUE;
                    count_struct = count_struct + 1;
                end
            end
        end
    end
    save(strcat('result/im_',int2str(count_file),'_',int2str(p*10),'.mat'),'MATRIX'); 
    clear MATRIX
    clear VALUE
    count_file = count_file + 1;
end
