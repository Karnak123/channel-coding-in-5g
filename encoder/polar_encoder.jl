using Kronecker

module PolarEncoder
    export polar_encoder

    function polar_encoder(u, N)
        G = [1 0; 1 1]
        temp = N
        while temp>2
            G = Kronecker.kronecker(G, G)
            temp = temp/2
        end

        return u*G
    end
end