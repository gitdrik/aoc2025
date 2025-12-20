open("10.txt") do f
    p1, p2 = 0, 0
    for l ∈ eachline(f)
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

        bn = length(buttons)
        ans = bn
        for n ∈ 1:2^bn-1
            press = digits(n, base=2, pad=bn).==1
            if isodd.(sum(buttons[press])) == goal
                ans = min(ans, sum(press))
            end
        end
        p1 += ans

        # This solution is based on others ideas.
        # My original one was an ugly combination of computing
        # Smiths normal form using NormalForms.jl, and brute force.
        jolts = parse.(Int, split(ss[end][2:end-1], ','))
        MEM::Dict{Array{Int}, Int} = Dict()
        function minpress(jolts)
            all(jolts.==0) && return 0
            jolts ∈ keys(MEM) && return MEM[jolts]
            ans = 100000
            for n ∈ 0:2^bn-1
                press = digits(n, base=2, pad=bn).==1
                nj = n==0 ? jolts : jolts .- sum(buttons[press])
                any(nj .< 0) && continue
                any(isodd.(nj)) && continue
                ans = min(ans, sum(press)+2*minpress(nj.÷2))
            end
            MEM[jolts] = ans
            return ans
        end
        p2 += minpress(jolts)
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end