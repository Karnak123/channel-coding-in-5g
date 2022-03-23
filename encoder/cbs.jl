module CBS
    export code_block_segmentor

    function code_block_segmentor(a, A, G)
        if (A >= 1013 || (A >= 360 && G >= 1088))
            if (A % 2 == 1)
                msg1 = [0]
                append!(msg1, a[1:floor(Int, A/2)])
                msg2 = a[floor(Int, A/2) + 1:A]
                return [msg1, msg2]
            else
                msg1 = a[1:floor(Int, A/2)]
                msg2 = a[floor(Int, A/2) + 1:A]
                return [msg1, msg2]
            end
        end
        return [a]
    end
end