module CI
    export channel_interleaver

    function channel_interleaver(e, E)
        if typeof(e) == typeof([1 2])
            e = vec(e)
        end

        T = ceil((((8 * E + 1) ^ (0.5)) - 1) / 2)
        V = fill(-1, (T, T))
        
        for i = 1:T
            for j = 1:T
                if (i + j >= T) || ((n * (2 * T - i + 1) / 2) + j >= E)
                    continue
                else
                    V[i, j] = e[(n * (2 * T - i + 1) / 2) + j]
                end
            end
        end

        f = fill(0, E)

        for j = 1:T
            for i = 1:T
                if V[i, j] != -1
                    append!(f, V[i, j])
                end
            end
        end

        return f
    end
end