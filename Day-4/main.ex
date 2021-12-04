function process_card(sequence card)
    return apply(split(card, no_empty:=true), to_integer)
end function

function matrix_row(sequence card, integer row_n)
    seq row = {}
    for y=1 to 5 do
        row = append(row, card[y + (row_n - 1) * 5])
    end for
    return row
end function

function matrix_col(sequence card, integer col_n)
    seq col = {}
    for i=1 to 5 do
        col = append(col, card[col_n + (i - 1) * 5])
    end for
    return col
end function

function pos_to_crds(integer pos)
    int x = mod(pos, 5)
    return {iff(x == 0 ? 5 : x), ceil(pos / 5)}
end function

procedure main(bool part_2 = false)
    object f = get_text("input.txt", GT_LF_STRIPPED)
    if f=-1 then
        puts(1, "Can't find input.txt file")
        abort(1)
    end if
    
    seq numbers = apply(split(f[1], ","), to_integer)
    seq cards = {}
    int answer = 0
    
    for i=0 to (length(f) - 1) / 6 - 1 do
        seq card = flatten(apply(f[3+6*i..3+4+6*i], process_card))
        cards = append(cards, card)
    end for
    
    seq won = {}
    bool done = false
    for N=1 to length(numbers) do
        if done and not part_2 then exit end if
        if length(cards) == length(won) then exit end if
        for C_N=1 to length(cards) do
            if part_2 and find(C_N, won) then continue end if
            if part_2 and length(won) == length(cards) then exit end if
            int pos = find(numbers[N], cards[C_N])
            if pos then
                cards[C_N][pos] = 0
                int {x, y}  = pos_to_crds(pos)
                int r_s = sum(matrix_row(cards[C_N], y))
                int c_s = sum(matrix_col(cards[C_N], x))
                if not (r_s and c_s) then
                    answer = sum(cards[C_N]) * numbers[N]
                    won = append(won, C_N)
                    done = iff(part_2 ? false : true)
                    if not part_2 then exit end if
                end if
            end if
        end for
    end for
    
    printf(1, "Answer is: %d\n", answer)
end procedure

main()
main(true)
