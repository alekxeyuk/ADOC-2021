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

function rating(sequence f_, bool co2)
    int j = 1
    while length(f_) != 1 do
        seq found = {}
        int bit = current_bit(f_, j)
        bit = iff(bit == 2 ? '1' : bit + '0')
        if co2 then
            bit = iff(bit == '1' ? '0' : '1')
        end if

        for i=1 to length(f_) do
            if f_[i][j] == bit then
                found = append(found, f_[i])
            end if
        end for
        f_ = found
        j += 1
    end while
    return f_
end function

procedure main()
    object f = get_text("input.txt", GT_LF_STRIPPED)
    if f=-1 then
        puts(1, "Can't find input.txt file")
        abort(1)
    end if

    seq {f_oxy, f_co2} = {rating(f, false), rating(f, true)}

    printf(1, "Answer is: %d\n", bstr_to_int(f_oxy[1]) * bstr_to_int(f_co2[1]))
end procedure

main()