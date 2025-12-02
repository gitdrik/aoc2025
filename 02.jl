open("02.txt") do f
    ids = split(readline(f), ',') .|> s->parse.(Int, split(s, '-'))
    p1, p2 = 0, 0
    for (a, b) ∈ ids, id ∈ a:b
        s = string(id)
        if s[1:end÷2]==s[end÷2+1:end]
            p1 += id
        end
        for n ∈ 1:length(s)÷2
            length(s) % n ≠ 0 && continue
            parts = [s[i:i+n-1] for i ∈ 1:n:length(s)]
            if allequal(parts)
                p2 += id
                break
            end
        end
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end