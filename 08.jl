open("08.txt") do f
    B = [Tuple(parse.(Int, split(l,','))) for l ∈ eachline(f)]
    boxes = length(B)

    pairs::Array{Tuple{Int, NTuple{3, Int}, NTuple{3, Int}}} = []
    for i ∈ 1:length(B)-1, j ∈ i+1:length(B)
        distsq = sum((B[i].-B[j]).^2)
        push!(pairs, (distsq, B[i], B[j]))
    end
    sort!(pairs)

    G::Array{Set{NTuple{3, Int}}} = []
    for i ∈ Iterators.countfrom(1)
        p1, p2 = pairs[i][2], pairs[i][3]
        hits::Array{Int} = []
        for j ∈ eachindex(G)
            if p1∈G[j] || p2∈G[j]
                push!(hits, j)
            end
        end
        if length(hits)==0
            push!(G, Set([p1, p2]))
        elseif length(hits)==1
            push!(G[hits[1]], p1, p2)
        else
            @assert length(hits)==2
            push!(G[hits[1]], G[hits[2]]...)
            deleteat!(G, hits[2])
        end
        if i==1000
            sizes = sort(length.(G), rev=true)
            println("Part 1: ", prod(sizes[1:3]))
        end
        if length(G[1])==boxes
            println("Part 2: ", p1[1]*p2[1])
            break
        end
    end
end