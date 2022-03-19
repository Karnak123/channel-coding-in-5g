module RateMatching
    export rate_matching

    function rate_matching(y, N, E, K)
        if (typeof(y) == typeof([1 2]))
            y = vec(y)
        end

        if N == E
            return y
        elseif N < E
            # repetition
            while length(y) < E
                append!(y, y)
            end
            return y[1:E]
        elseif K/E <= 7/16
            # puncturing
            return y[N-E+1:N]
        else
            # shortening
            return y[1:E]
        end
    end
end