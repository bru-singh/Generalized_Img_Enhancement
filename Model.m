
for N=1:5
    
    Input_image =sprintf('imgs/%d.jpg',N);
    img=imread(Input_image);

    d=0; % always be 0 for GEM to run fast
    n=2; % always be 2 or inf
    WB=inf; % For max RGB
    strength=0.25; % Optimal value for n=2

    [output, C_ori,C_out, NL, Ratio]=GeneralizedEqu(img, 'RGB', n, strength, WB, d);

    Output_image =sprintf('final_img/finalGEM_%d.jpg',N);
    imwrite(uint8(output),Output_image);
end

