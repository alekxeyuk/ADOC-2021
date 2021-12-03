procedure main()
    object f = get_text("input.txt", GT_LF_STRIPPED)
    if f=-1 then
        puts(1, "Can't find input.txt file")
        abort(1)
    end if
    
    integer answer = 0
    integer prev   = -1
    
    for i=1 to length(f) do
        integer c = to_integer(f[i])
        answer += iff(prev >= 0 and c > prev ? 1 : 0)
        prev = c
    end for
    
    printf(1, "Answer is: %d\n", answer)
end procedure

main()
