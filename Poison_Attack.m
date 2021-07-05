%% Poison_Attack: function description
function [theta, W] = Poison_Attack(A, y, q, kappa, M)
	W = ceil(q * (1 + kappa) * M);
	theta = HodgeRank(A, y, W);
end