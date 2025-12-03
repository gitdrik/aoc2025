open("03.txt") do f
    p1, p2 = 0, 0
    for l ∈ eachline(f)
        joltage, p = 0, 1
        for digit ∈ 1:12
            c, dp = findmax(l[p:end-12+digit])
            joltage, p  = joltage*10+parse(Int, c), p+dp
            digit==2 && (p1 += joltage)
        end
        p2 += joltage
    end
    println(p1)
    println(p2)
end