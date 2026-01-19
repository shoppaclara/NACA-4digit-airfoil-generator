%% MATLAB 4-digit NACA airfoil to CVC file

%% Function input variables (Change these to match desired values)

C = 16.54;                % Chord Length
four_digstring = '1412';  % NACA 4-digit airfoil
N = 100;                  % Number of Points to generate along the chord


function [fileName] = NACA_airfoil_gen(C, four_digstring, N, K)					  
   t=str2num(four_digstring(3:4))/100;      % Thickness divided by 100 (XX=12, thickness is 12% of chord)
   m=str2num(four_digstring(1))/100;        % Maximum camber divided by 100 (if M = 2 , chamber is 2% of chord)
   p=str2num(four_digstring(2))/10;         % Position of maximum camber divided by 10 (P=4, max chmaber is at 40% of chord)
   a0 = 0.2969; a1 = -0.126;  a2 = -0.3516; a3 = 0.2843; % Thickness distribution constants
   a4 = -0.1036; % For a closed trailing edge
   % Create x-spacing, using half cosine based spacing
   beta = linspace(0,pi,N);
   x=C*(0.5*(1-cos(beta)));  % Generate x from 0 to 1
   % Calculate the thickness distribution
   yt = (t/0.2) * C * (a0 * sqrt(x/C) + a1 * (x/C) + a2 * (x/C).^2 + a3 * (x/C).^3 + a4 * (x/C).^4);
  
   % Calulate Camber Line (yc)
   yc = zeros(size(x));
   dyc_dx=zeros(size(x));
   for i = 1:length(x)
       xc_norm = x(i)/C;      % Normalize for chord length
       if p == 0              % Account for no camber - Symmetric airfoil
           xu=xc_norm;
           yu=yt;
           xl=xc_norm;
           yl=-yt;
       else
           if xc_norm <= p     % Leading side
               if p>0
                   yc(i) = m/p^2 * (2*p*xc_norm - xc_norm^2) * C;
                   dyc_dx(i) = (2*m / p^2) * (p-xc_norm);
               end
           elseif xc_norm>p  % Trailing side            
               yc(i) = m/(1-p)^2 * ((1-2*p)+2*p*xc_norm - xc_norm^2) * C;
               dyc_dx(i) = (2*m/(1-p)^2) * (p- xc_norm);
           end
       end
   end
   theta =atan(dyc_dx);
   xu= x - yt .* sin(theta);
   yu = yc + yt .* cos(theta);
   xl = x + yt .*sin(theta);
   yl = yc - yt .* cos(theta);
   X = [fliplr(xu), xl(2:end)];
   Y = [fliplr(yu), yl(2:end)];
   Z = zeros(size(X));
   [maxY, maxY_index] = max(Y);
   [minY, minY_index] = min(Y);
   T_check = (maxY - minY)/C;
  
   close all;
   plot(X,Y)
   axis equal; grid on;
   title_text = "NACA "+string(four_digstring)+" Airfoil with Chord length: "+string(C);
   subtitle_text = "Maximum Y value: "+string(maxY)+ "  Minimum Y value: "+string(minY);
   title(title_text)
   subtitle(subtitle_text)
  
   % Save as a CVC file for exporting
   fileName = 'NACA_' + string(four_digstring) + '.csv'; % Define the output file name
   T = table(X', Y', Z');
   writetable(T, fileName, 'WriteVariableNames', false);
   fprintf('File saved as %s\n', fileName);
end
NACA_airfoil_gen(C, four_digstring, N)

