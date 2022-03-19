module CBC
    export code_block_concatenator

    function code_block_concatenator(a, b, E)
        if typeof(a) == typeof([1 2])
            a = vec(a)
        end
        if typeof(b) == typeof([1 2])
            b = vec(b)
        end

        append!(a, b)
        if length(a) == 2 * E + 1 
            append!(a, 0)
        end

        return a
    end
end