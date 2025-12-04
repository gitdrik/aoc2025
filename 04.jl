open("04.txt") do f
    D = stack(readlines(f)) .== '@'
    rows, cols = size(D)
    M = falses(rows+2, cols+2)
    M[2:rows+1, 2:cols+1] = D

    p1 = 0
    for r ∈ 2:rows+1, c ∈ 2:cols+1
        p1 += M[r,c] && sum(M[r-1:r+1, c-1:c+1]) < 5
    end
    println("Part 1: ", p1)

    p2, done = 0, false
    while !done
        done = true
        for r ∈ 2:rows+1, c ∈ 2:cols+1
            if M[r,c] && sum(M[r-1:r+1, c-1:c+1]) < 5
                done = false
                M[r,c] = false
                p2 += 1
            end
        end
    end
    println("Part 2: ", p2)
end