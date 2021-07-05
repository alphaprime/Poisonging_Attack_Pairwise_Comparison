%% Worst_Theta: function description
function [theta, loss, regular] = Worst_Theta(A, y, p, rho, T)
	[N, n] = size(A);
	Theta = ones(n, T);
	Loss = zeros(T, 1);
	Regular = zeros(T, 1);
	P = diag(sqrt(p));
	grad_old = zeros(n, 1);
	step_size = 0.0001 * ones(T, 1);

	for t = 1:T
		residual = A * Theta(:, t) - y;
		grad_loss = A' * P * residual;
		grad_reg = A' * residual / norm(residual);
		grad_new = grad_loss + sqrt(rho/4) * grad_reg;
		Loss(t) = 0.5 * norm(P * residual)^2;
		Regular(t) = sqrt(rho) * norm(residual) / 2;	

		if norm(grad_new) > 1e-6
			if t > 1
				delta_theta = Theta(:, t) - Theta(:, t-1);
				delta_grad = grad_new - grad_old;
				step_size(t) = norm(delta_theta)^2 / (delta_theta' * delta_grad);
			end	

			if t < T
				Theta(:, t+1) = Theta(:, t) - step_size(t) * grad_new;
			end

			grad_old = grad_new;
		else
			break;
		end
	end
	theta = Theta(:, t);
	loss = Loss(t);
	regular = Regular(t);
end