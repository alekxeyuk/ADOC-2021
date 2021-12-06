procedure main(integer days)
    object f = get_text("input.txt", GT_LF_STRIPPED)
    if f=-1 then
        puts(1, "Can't find input.txt file")
        abort(1)
    end if

    seq state = repeat(0, 9)
    seq inp = apply(split(f[1], ","), to_integer)
    for i=1 to length(inp) do
        state[inp[i] + 1] += 1
    end for
    
    for d=1 to days do
        state[mod((d + 7), 9) + 1] += state[mod(d, 9) + 1]
    end for
    
    printf(1, "Answer is: %d\n", sum(state))
end procedure

main(79)
main(255)
