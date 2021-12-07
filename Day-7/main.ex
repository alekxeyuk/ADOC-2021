function part_2_dist(integer x)
    return (power(x, 2) + x) / 2
end function

procedure main(bool part_2 = false)
    object f = get_text("input.txt", GT_LF_STRIPPED)
    if f=-1 then
        puts(1, "Can't find input.txt file")
        abort(1)
    end if

    seq inp     = sort(apply(split(f[1], ","), to_integer))
    int len     = length(inp)
    int median  = inp[len / 2]
    int average = floor(sum(inp) / len)
    int answer  = 0
    
    for i=1 to len do
        if part_2 then
            answer += part_2_dist(abs(inp[i] - average))
        else
            answer += abs(inp[i] - median)
        end if
    end for
    
    printf(1, "Answer is: %d\n", answer)
end procedure

main()
main(true)

