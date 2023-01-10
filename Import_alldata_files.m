% This script searches for all the files with the same extension (created as cell arrays) within a
% folder and its subfolders, load them and merge them within a struct. 
% The matlab current directory should be the folder where the .mat files you want to import are located (even in subfolders)
% This script uses the function subdir
clear all
a = subdir ('*IEIs.mat'); % change the name according to the variable of interest
for i = 1:length(a)
    IEI(i)=load(a(i).name)
end

% Q = struct2cell(IEI); %if you want to work on cell array instead of struct

m = IEI(1).IEIs{1,1}; % move data from one single experiment to a vector array containing all values of a group
for ii = 1:(length(IEI)-1)
for k = 1:(size(IEI(ii+1).IEIs,2)-1)
    merge = vertcat(m, IEI(ii+1).IEIs{1,k+1}); 
    m = merge;
end
end



str = pwd;
[~,pname] = fileparts(str);
fname = sprintf('%s_IEIs.mat',pname);  % to save the final vector with the name of the folder; change the nme of the varioable accordingly

assignin('base',pname, merge )
save (fname, pname)


