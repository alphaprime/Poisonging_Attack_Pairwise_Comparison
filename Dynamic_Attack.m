%% Dynamic_Attack: function description
function q = Dynamic_Attack(A, y, w, rho)
	
	theta = HodgeRank(A, y, w);

	z = 0.5 * (A * theta - y).^2;

	p = w / sum(w);

	q = Linear_Square_Div(z, p, rho);

end