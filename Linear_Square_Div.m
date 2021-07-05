%% Linear_Square_Div: function description
function q = Linear_Square_Div(z, p, rho)
    N = length(z);
    z = z - mean(z);
    [z_sort, sort_idx] = sort(z);
    [~, inverse_sort_idx] = sort(sort_idx);
    if isempty(find(z_sort, 1))
        q = ones(N, 1) / N;
        return
    end

    lambda_min = 0;
    lambda_init_max = max(N * max(abs(z_sort)), sqrt(N / (2 * rho) * norm(z_sort)));
    lambda_max = lambda_init_max;
    sum_vec = cumsum(z_sort);
    sum_squared_vec = cumsum(z_sort.^2);
    sum_squared_p = cumsum(p.^2);

    tol = 1e-13;

    while abs(lambda_max - lambda_min) > tol * lambda_init_max
        lambd = (lambda_max + lambda_min) / 2;
        [eta, ind] = Find_Shift_Simplex(z_sort, lambd, sum_vec, p);
        term_1 = sum_squared_vec(ind) / lambd^2;
        term_2 = ind * eta^2;
        term_3 = 2 * sum_vec(ind) * eta / lambd;
        term_4 = 2 * sum_squared_p(end) - 2 * sum_squared_p(ind);
        square_sum = term_1 + term_2 + term_3 + term_4;
        if square_sum / 2 > rho
            lambda_min = lambd;
        else
            lambda_max = lambd;
        end
    end
    lambd = (lambda_max + lambda_min) / 2;
    [eta, ~] = Find_Shift_Simplex(z_sort, lambd, sum_vec, p);
    q = p - z_sort/lambd - eta;
    q(q<0) = 0;
    q = q(inverse_sort_idx);
end