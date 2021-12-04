procedure main()
    object f = get_text("input.txt", GT_LF_STRIPPED)
    if f=-1 then
        puts(1, "Can't find input.txt file")
        abort(1)
    end if
    
    integer {aim, hor, dep, x} @= 0
    
    for i=1 to length(f) do
        seq s = split(f[i])
        x = to_integer(s[2])
        switch s[1] do
            case "forward":
                hor += x
                dep += aim * x
            case "down": aim += x
            case "up": aim -= x
        end switch
    end for
    
    printf(1, "Answer is: %d\n", hor * dep)
end procedure

main()
