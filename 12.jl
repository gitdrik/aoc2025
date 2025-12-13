open("12.txt") do f
    ans = 0
    for (i, l) ∈ enumerate(eachline(f))
        i < 31 && continue
        rows, cols, ns... = parse.(Int, split(l, r"x|: | "))
        if rows÷3 * cols÷3 ≥ sum(ns)
            # Yes, will work.
            ans +=1
        elseif sum(ns[1:4])*7 + ns[5]*5 + ns[6]*6 > rows*cols
            # No, will not work.
            nothing
        else
            println("$i: TBD, maybe next year.")
            exit()
        end
    end
    println("Answer: ", ans)
end