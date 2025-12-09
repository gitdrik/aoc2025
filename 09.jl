open("09.txt") do f
    RED = [parse.(Int, split(l,',')) for l∈eachline(f)]
    REDl = length(RED)
    
    p1 = 0
    for i∈1:REDl-1, j∈i+1:REDl
        delta = abs.(RED[i].-RED[j]).+1
        p1 = max(p1, delta[1]*delta[2])
    end
    println("Part 1: ", p1)

    borders::Array{NTuple{2, UnitRange{Int}}} = []
    # Make a border outside of the line, which is left* in the example.
    # A rectangle should not intersects this outside border.
    # Outside corners are ignored, does not matter anyway.
    # This only works if there is at least 1 empty row around the outside.
    # *) Apparently it was right in my data.
    for i ∈ 1:REDl
        j = mod1(i-1, REDl) # Had to reverse to right of line (-1) here.
        if RED[i][1]==RED[j][1]
            if RED[i][2] < RED[j][2] #right
                lr = RED[i][1]-1:RED[i][1]-1
                lc = RED[i][2]+1:RED[j][2]-1
            elseif RED[i][2] > RED[j][2] #left
                lr = RED[i][1]+1:RED[i][1]+1
                lc = RED[j][2]+1:RED[i][2]-1
            end
        elseif RED[i][2]==RED[j][2]
            if RED[i][1] < RED[j][1] #down
                lc = RED[i][2]+1:RED[i][2]+1
                lr = RED[i][1]+1:RED[j][1]-1
            elseif RED[i][1] > RED[j][1] #up
                lc = RED[i][2]-1:RED[i][2]-1
                lr = RED[j][1]+1:RED[i][1]-1
            end
        end
        push!(borders, (lc, lr))
    end

    function isinside(c1, c2)
        sr = min(c1[1], c2[1]):max(c1[1], c2[1])
        sc = min(c1[2], c2[2]):max(c1[2], c2[2])
        for (lc, lr) ∈ borders
            # Check that borderline is outside square
            !(lc.start > sc.stop ||
              lc.stop < sc.start ||
              lr.start > sr.stop ||
              lr.stop < sr.start) && return false
        end
        return true
    end

    p2 = 0
    for i∈1:REDl-1, j∈i+1:REDl
        if isinside(RED[i], RED[j])
            delta = abs.(RED[i].-RED[j]).+1
            p2 = max(p2, delta[1]*delta[2])
        end
    end
    println("Part 2: ", p2)
end