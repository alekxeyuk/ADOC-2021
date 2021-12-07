function part1(integer x, integer median, integer _)
    return abs(x - median)
end function

function part2(integer x, integer _, integer average)   
    int d = part1(x, average, _)
    return (power(d, 2) + d) / 2
end function

function seq_call(integer x, integer rid, integer median, integer average)
    return call_func(rid, {x, median, average})
end function

procedure main(integer rid)
    object f = get_text("input.txt", GT_LF_STRIPPED)
    if f=-1 then
        puts(1, "Can't find input.txt file")
        abort(1)
    end if

    seq inp     = sort(apply(split(f[1], ","), to_integer))
    int len     = length(inp)
    int median  = inp[len / 2]
    int average = floor(sum(inp) / len)
    int answer  = sum(apply(true, seq_call, {inp, rid, median, average}))

    printf(1, "Answer is: %d\n", answer)
end procedure

main(part1)
main(part2)
