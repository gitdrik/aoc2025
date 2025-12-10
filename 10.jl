using DataStructures

open("10.txt") do f
    p1, p2 = 0, 0
    for (i, l) ∈ enumerate(eachline(f))
        ss = split(l)
        goal = collect(ss[1][2:end-1]) .== '#'
        buttons::Array{BitArray} = []
        for s ∈ ss[2:end-1]
            b = falses(length(goal))
            for i ∈ parse.(Int, split(s[2:end-1], ','))
                b[i+1] = true
            end
            push!(buttons, b)
        end
        
        seen::Set{typeof(goal)} = Set()
        Q = [(0, falses(length(goal)))]
        while true
            presses, state = popfirst!(Q)
            state ∈ seen && continue
            push!(seen, state)
            if state == goal
                p1 += presses
                break
            end
            for b ∈ buttons
                nstate = state .⊻ b
                push!(Q, (presses+1, nstate))
            end
        end

        joltages = parse.(Int, split(ss[end][2:end-1], ','))
        goal == zeros(Int, length(joltages))
        seen2::Set{typeof(joltages)} = Set()
        Q = SortedSet([(maximum(joltages), 0, joltages)])
        while true
            _e, presses, state = popfirst!(Q)
#            @show _e, presses, state
            state ∈ seen2 && continue
            any(state .< 0) && continue
            push!(seen2, state)
            if state == goal
                println(presses)
                p2 += presses
                break
            end
            for b ∈ buttons
                nstate = state .- b
                push!(Q, (maximum(nstate)+presses+1, presses+1, nstate))
            end
        end
        @show p2, i, l
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)

end
            
            

#[.##.##] (4,5) (0,5) (2,3) (1,3,5) (0,3,5) (0,2,3,5) (0,1,4) (0,2,4,5) {198,181,22,50,173,65}
