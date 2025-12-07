open("07.txt") do f
    M = readlines(f)
    sc = findfirst(==('S'), M[1])
    rows = length(M)
    
    p1 = 0
    MEM::Dict{Tuple{Int,Int},Int} = Dict()
    function timelines(r, c)
        r==rows && return 1
        (r,c) ∈ keys(MEM) && return MEM[(r,c)]
        if M[r+1][c]=='^'
            p1 += 1
            MEM[(r,c)] = timelines(r+2, c-1) + timelines(r+2, c+1)
        else
            MEM[(r,c)] = timelines(r+2, c)
        end
        return MEM[(r,c)]
    end
    p2 = timelines(2, sc)
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end