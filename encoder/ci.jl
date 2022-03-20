module CI
    export channel_interleaver

    function channel_interleaver(e, E)
        if typeof(e) == typeof([1 2])
            e = vec(e)
        end

        T = ceil(Int, (((8 * E + 1) ^ (0.5)) - 1) / 2)
        V = fill(-1, (T, T))
        
        for i = 1:T
            for j = 1:T
                r = floor(Int, i*(2*T-i+1)/2)
                if (i + j >= T) || (r + j >= E)
                    continue
                else
                    V[i, j] = e[r + j]
                end
            end
        end

        f = fill(0, E)
        count = 1

        for j = 1:T
            for i = 1:T
                if V[i, j] != -1
                    f[count] = V[i, j]
                    count += 1
                end
            end
        end

        return f
    end
end