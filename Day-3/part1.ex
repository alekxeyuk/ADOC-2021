procedure main()
    object f = get_text("input.txt", GT_LF_STRIPPED)
    if f=-1 then
        puts(1, "Can't find input.txt file")
        abort(1)
    end if

    int x
    seq bits = {}
    
    for j=1 to 12 do
        x = 0
        for i=1 to length(f) do
            x += iff(f[i][j] == '1' ? 1 : -1)
        end for
        bits = prepend(bits, iff(x > 0 ? 1 : 0))
    end for

    int answer = bits_to_int(bits)
    printf(1, "Answer is: %d\n", answer * xor_bits(answer, 4095))
end procedure

main()
