open("05.txt") do f
    a, b = split(read("05.txt", String), "\n\n")
    fresh = [(parse(Int, a), parse(Int, b)) for (a, b) ∈ split.(split(a), '-')]
    ingredients = parse.(Int, split(b))

    p1 = 0
    for i ∈ ingredients
        for (a, b) ∈ fresh
            if a ≤ i ≤ b
                p1 += 1
                break
            end
        end
    end
    println("Part 1: ", p1)

    p2, now = 0, 0
    sort!(fresh)
    for (start, stop) ∈ fresh
        now ≥ stop && continue
        if start ≤ now ≤ stop
            p2 += stop - now
        else
            p2 += stop - start + 1
        end
        now = stop
    end
    println("Part 2: ", p2)
end