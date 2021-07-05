%% Random_Attack: function description
function w_pert = Random_Attack(A, w, ratio_add, ratio_delete)
	N = length(w);
	w_ind = find(w);
	N_w = sum(w);
	N_add = ceil(ratio_add * N);
	N_delete = ceil(ratio_delete * N);
	Id_add = randperm(N, N_add);
	Id_delete = randperm(N, N_delete);

	add_min = min(w);
	add_max = max(w);

	addon = randi([add_min, add_max], length(Id_add), 1);
	w_add = zeros(N, 1);
	w_add(Id_add) = addon;

	delete_min = -min(w);
	delete_max = 0;
	deleteon = randi([delete_min, delete_max], length(Id_delete), 1);
	w_delete = zeros(N, 1);
	w_delete(Id_delete) = deleteon;		

	w_pert = w + w_add + w_delete;

	index = find(w_pert < 0);
	w_pert(index) = 0;
	Id_random = find(w_pert > 0);
	N_random = length(Id_random);	

	% Test Connection
	sample_pair_random = zeros(N_random, 2);
	for c = 1 : N_random
		sample_pair_random(c, 1) = find(A(Id_random(c), :) == 1);
		sample_pair_random(c, 2) = find(A(Id_random(c), :) == -1);
	end	

	% Test Connection
	candi = [unique(sample_pair_random(:, 1)); unique(sample_pair_random(:, 2))];
	candi = unique(candi);
	unsel_id = true(1, N);
	unsel_id(candi) = false;
	candi_num = length(candi);
	unsel_id = find(unsel_id == 1);

	for c = 1:N
		i = find(A(c, :) == 1);
		j = find(A(c, :) == -1);
		clean_pair(c, 1) = i;
		clean_pair(c, 2) = j;
	end

	% Keep Connection
	if ~isempty(unsel_id)
	    for n = 1:length(unsel_id)
	        ss = find(candi ~= unsel_id(n));
	        tt = randperm(length(ss), 1);
	        idx = find(clean_pair(:, 1) == unsel_id(n) & clean_pair(:, 2) == candi(ss(tt)));
	        sample_pair_random = [sample_pair_random; clean_pair(idx, :)];
	        Id_random = [Id_random, idx];
	    end
		% Generation the new data with sample_pair
		mul_min = min(w);
		mul_max = max(w);
		multi = randi([mul_min, mul_max], length(Id_random), 1);
		w_pert = zeros(N, 1);
		w_pert(Id_random) = multi;
	end
end
