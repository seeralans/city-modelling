function cen = loadData()

% For consistency sake keep the current directory structure

	% change this line to load different data
	fileList = dir('Data/Data/Reduced_Census/Census/ks*');


	for i = 1:length(fileList)
	    file = strcat('Data/Data/Reduced_Census/Census/', fileList(i).name);
	    cen{i} = importdata(file);
	end

end
