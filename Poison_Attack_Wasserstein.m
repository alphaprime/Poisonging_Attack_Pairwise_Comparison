%% Static_Attack: function description
function [theta, dual, poison_dist] = Static_Attack(A, y, w, rho, T)

	theta = Worst_Theta(A, y, w, rho, T);

	dual = Dual_Var(A, theta, y, rho);

	poison_dist = Worst_Distribution(A, theta, y, p, dual);

end