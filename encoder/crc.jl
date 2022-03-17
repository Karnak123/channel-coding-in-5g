module CRC
    export CRC_encoder, g_6, g_11, g_24

    g_6 = [1 1 0 0 0 0 1]
    g_11 = [1 1 1 0 0 0 1 0 0 0 0 1]
    g_24 = [1 1 0 1 1 0 0 1 0 1 0 1 1 0 0 0 1 0 0 0 1 0 1 1 1]

    function CRC_encoder(a_prime, A_prime, g)
        # convert to vector if of Matrix type
        if typeof(a_prime) == typeof([1 2])
            a_prime = vec(a_prime)
        end

        # generate number from array of bits
        a = 0
        append!(a_prime, zeros(length(g) - 1))
        
        # generate number from array of bits
        a = bin2dec(a_prime)
        c = bin2dec(g)

        # generate crc
        crc = mod(a, c)

        # generate array of bits from number
        crc = dec2bin(crc)
        crc_prime = append!(zeros(length(g) - 1 - length(crc)), crc)
        for i = 1:length(crc_prime)
            a_prime[A_prime+i] = crc_prime[i]
        end
        return a_prime
    end

    function bin2dec(n)
        # convert binary number to decimal
        pow = 2^(length(n) - 1)
        sum = 0
        for i = 1:length(n)
            sum = sum + n[i] * pow
            pow = pow / 2
        end
        return sum
    end

    function dec2bin(n)
        # convert decimal number to binary
        bin = []
        while n > 0
            append!(bin, mod(n, 2))
            n = floor(n / 2)
        end
        return bin
    end

end