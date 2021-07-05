%% Worst_Distribution: function description
function q = Worst_Distribution(A, theta, y, p, dual)

	residual = A * theta - y;
	q =  residual.^2 / dual  + p;
	tmp = SimplexProj(q');
	q = tmp';
	% q = q/sum(q);

end