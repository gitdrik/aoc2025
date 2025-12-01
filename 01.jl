open("01.txt") do f
    n, p1, p2 = 50, 0, 0
    for l ∈ eachline(f)
        dn = parse(Int, l[2:end])
        if l[1]=='R'
            p2 += (n+dn) ÷ 100
            n = mod(n+dn, 100)
        else
            p2 += (mod(-n, 100)+dn) ÷ 100
            n = mod(n-dn, 100)
        end
        p1 += n == 0
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end