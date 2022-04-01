GLException: X11GLXDrawableFactory
A:
    shell:
        matlab -softwareopengl
    in matlab command window:
        opengl('save', 'software')
    however, does not work, work method is followed,
    ----------------------------------------------------
     also ran into this issue on my Dell XPS 13 9360 which neither has a NVIDIA or AMD card, but an on-board intel graphics card.
I filed a bug report with MATHWORKS and they proposed two solutions:
Create a file with the name 'java.opts' in the directory where MATLAB is executed (for me this is in '/usr/local/MATLAB/R2020a/bin/glnxa64') with the following line: -Djogl.disable.openglarbcontext=1
If this does not work, then the above solution using export MESA_LOADER_DRIVER_OVERRIDE=i965 is working.
For me both solve my issue.
    https://www.mathworks.com/matlabcentral/answers/392743-r2018a-glexception-error-on-linux
    https://www.cnblogs.com/zbqhc/p/13935817.html

Update to bullseye
    cannot plot,
    + downgrade NVIDIA-DRIVER into 390xx by
    add following line,
        #deb http://mirrors.huaweicloud.com/debian/ sid  main contrib non-free
    into apt/source.list
        # apt update
        # apt-get install nvidia-legacy-390xx-driver firmware-misc-nonfree
        # restart
    + refer problem above by add file "java.opts", and export "MESA_LOADER_DRIVER_OVERRIDE"

path::
    path(path, 'D:\application\Matlab 2018a\bin')

gif animation::
    matquafig_load;
    axis tight manual % this ensures that getframe() returns a consistent size
    filename = 'testAnimated.gif';
    load ieecas_voltage;
    N=100; % 100 segment
    len=16000; % length per segment
    fs=16000;
    st=0;
    overlap=100;
    for n = 0:1:N
        % Draw plot for y = x.^n
        index=n*len+1:(n+1)*len+overlap;
        t = time_vector(index, fs,st);
        y = x(index);
        plot(t,y,'b','linewidth',lw);
        box on;
        xlabel('Time(s)');
        ylabel('Voltage(V)');
        set(gca,'ylim',[-6,6]*1e-3,'xlim',[t(1),t(end)],'xtick',floor(1+t(1)-eps*2):0.2:floor(1+t(end-overlap)-eps*2)+0.1);
        drawnow 
          % Capture the plot as an image 
        frame = getframe(hf); 
        im = frame2im(frame); 
        [imind,cm] = rgb2ind(im,256); 
          % Write to the GIF File 
        if n == 0 
            imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
        else 
            imwrite(imind,cm,filename,'gif','WriteMode','append'); 
        end 
        st=t(end-overlap);
     end
