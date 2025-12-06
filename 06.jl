open("06.txt") do f
    H = stack(readlines(f))
    rows, cols = size(H)

    p1 = 0
    ops = split(join(H[:,cols]))
    ns = [parse.(Int, split(join(H[:,i]))) for i ∈ 1:cols-1]
    for i ∈ eachindex(ops)
        if ops[i]=="*"
            p1 += prod(ns[j][i] for j ∈ 1:cols-1)
        else
            p1 += sum(ns[j][i] for j ∈ 1:cols-1)
        end
    end
    println("Part 1: ", p1)

    p2 = 0
    ns2::Vector{Int} = []
    for i ∈ rows:-1:1
        all(H[i, :].==' ') && continue
        push!(ns2, parse(Int, join(H[i, 1:cols-1])))
        if H[i, cols]=='*'
            p2 += prod(ns2)
            ns2 = []
        elseif H[i, cols]=='+'
            p2 += sum(ns2)
            ns2 = []
        end
    end
    println("Part 2: ", p2)
end