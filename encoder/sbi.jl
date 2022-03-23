module SBI
    export sub_block_interleaver, P

    P = [0, 1, 2, 4, 3, 5, 6, 7, 8, 10, 12, 14, 16, 18, 20, 22, 9, 11, 13, 15, 17, 19, 21, 23, 24, 25, 26, 28, 27, 29, 30, 31]

    function sub_block_interleaver(d, N)
        if typeof(d) == typeof([1 2])
            d = vec(d)
        end

        y = fill(0, N)
        B = floor(Int, N / 32)

        for j = 1:N
            idx = B*P[ceil(Int, j / B)] + mod(j-1, B)
            y[idx+1] = d[j]
        end
        
        return y
    end
end