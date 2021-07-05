%% Find_Shift_Simplex: function description
function [eta, idx] = Find_Shift_Simplex(z, lambd, vec, p)
	N = length(z);
	if p(end) >= z(end) / lambd
		eta = 0;
		idx = N;
	end

	low_ind = 1;
	high_ind = N;

	while low_ind ~= high_ind
		ii = floor((high_ind + low_ind) / 2);
		left_sum = (ii * z(ii) - vec(ii)) / lambd;
        right_sum = ((ii + 1) * z(ii + 1) - vec(ii+1)) / lambd;
        if right_sum >= 1 && left_sum < 1
            eta = p(ii) - 1 / ii - vec(ii) / (lambd * ii);
            idx = ii;
            return
        elseif left_sum >= 1
            % Need to decrease index, left sum is too large
        	high_ind = ii - 1;
        else
            %Increase index, because right sum is too low
            low_ind = ii + 1;
        end
	end
    idx = low_ind;
    eta = p(ii) - 1 / ii - vec(ii) / (lambd * ii);
end