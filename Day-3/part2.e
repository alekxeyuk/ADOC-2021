function current_bit(sequence strs, integer j)
    int x = 0
    for i=1 to length(strs) do
        x += iff(strs[i][j] == '1' ? 1 : -1)
    end for
    return iff(x == 0 ? 2 : iff(x > 0 ? 1 : 0))
end function

function bstr_to_int(string str)
    return bits_to_int(apply(split_by(reverse(str), 1), to_integer))
end function

procedure main()
    object f = get_text("input.txt", GT_LF_STRIPPED)
    if f=-1 then
        puts(1, "Can't find input.txt file")
        abort(1)
    end if

    seq {f_oxy, f_co2} @= f
    seq {oxygen, co2} @= {}
    
    -- Oxygen rating
    int j = 1
    while length(f_oxy) != 1 do
        seq found = {}
        int bit = current_bit(f_oxy, j)
        bit = iff(bit == 2 ? '1' : bit + '0')

        for i=1 to length(f_oxy) do
            if f_oxy[i][j] == bit then
                found = append(found, f_oxy[i])
            end if
        end for
        f_oxy = found
        j += 1
    end while
    
    -- Co2 rating
    j = 1
    while length(f_co2) != 1 do
        seq found = {}
        int bit = current_bit(f_co2, j)
        bit = iff(bit == 2 ? '1' : bit + '0')
        bit = iff(bit == '1' ? '0' : '1')

        for i=1 to length(f_co2) do
            if f_co2[i][j] == bit then
                found = append(found, f_co2[i])
            end if
        end for
        f_co2 = found
        j += 1
    end while
    
    printf(1, "Answer is: %d\n", bstr_to_int(f_oxy[1]) * bstr_to_int(f_co2[1]))
end procedure

main()
