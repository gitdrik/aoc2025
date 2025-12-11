open("11.txt") do f
    G::Dict{String,Array{String}} = Dict()
    for l ∈ eachline(f)
        s, ss... = split(l, r": | ")
        G[s] = ss
    end

    MEM::Dict{Tuple{Bool, Bool, String}, Int} = Dict()
    function paths(fft, dac, s)
        s == "out" && return fft && dac
        (fft, dac, s) ∈ keys(MEM) && return MEM[(fft, dac, s)]
        fft |= s=="fft"
        dac |= s=="dac"
        MEM[(fft, dac, s)] = sum(paths(fft, dac, ss) for ss ∈ G[s])
        return MEM[(fft, dac, s)]
    end
    println("Part 1: ", paths(true, true, "you"))
    println("Part 2: ", paths(false, false, "svr"))
end