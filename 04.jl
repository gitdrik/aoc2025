open("04.txt") do f
    D = stack(readlines(f)) .== '@'
    rows, cols = size(D)
    M = falses(rows+2, cols+2)
    M[2:rows+1, 2:cols+1] = D
    
    p1, p2, done1, done2 = 0, 0, false, false
    while !done2
        done2 = true
        for r ∈ 2:rows+1, c ∈ 2:cols+1
            if M[r,c] && sum(M[r-1:r+1, c-1:c+1]) < 5
                done2 = false
                if done1
                    M[r,c] = false
                    p2 += 1
                else
                    p1 += 1
                end
            end
        end
        done1 = true
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end