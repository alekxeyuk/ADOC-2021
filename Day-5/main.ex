function parse_line(sequence line)
    return apply(split(match_replace(" -> ", line, ",", 0), ","), to_integer)
end function

function check_point(integer x, integer y)
    string key = sprintf("%03d%03d", {x, y})
    int point_c = getdd(key, 0)
    setd(key, point_c + 1)
    return point_c == 1
end function

procedure main(bool part_2 = false)
    object f = get_text("input.txt", GT_LF_STRIPPED)
    if f=-1 then
        puts(1, "Can't find input.txt file")
        abort(1)
    end if
    
    int counter = 0
    
    for i=1 to length(f) do
        int {x1, y1, x2, y2} = parse_line(f[i])
        if y1 == y2 then
            {x1, x2} = iff(x1 > x2 ? {x2, x1} : {x1, x2})
            for x=x1 to x2 do
                if check_point(x, y1) then counter += 1 end if
            end for
        elsif x1 == x2 then
            {y1, y2} = iff(y1 > y2 ? {y2, y1} : {y1, y2})
            for y=y1 to y2 do
                if check_point(x1, y) then counter += 1 end if
            end for
        elsif part_2 then
            {x1, x2, y1, y2} = iff(x1 > x2 ? {x2, x1, y2, y1} : {x1, x2, y1, y2})
            int {t_x, t_y} = {x1, y1}
            int y_s = iff(y2 > y1 ? 1 : -1)
            while t_x <= x2 do
                if check_point(t_x, t_y) then counter += 1 end if
                t_x += 1
                t_y += y_s
            end while
        end if
    end for
    
    printf(1, "Answer is: %d\n", counter)
    destroy_dict(1)
end procedure

main()
main(true)

