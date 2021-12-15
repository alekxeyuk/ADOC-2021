function cell_legit(integer x, integer y, integer cols, integer rows)
    if x >= 1 and x <= cols and y >= 1 and y <= rows then
        return true
    end if
    return false
end function


procedure main()
    object f = get_text("input.txt", GT_LF_STRIPPED)
    if f=-1 then
        puts(1, "Can't find input.txt file")
        abort(1)
    end if

    seq inp = {}
    for i=1 to length(f) do
        inp = append(inp, apply(split_by(f[i], 1), to_integer))
    end for

    int {rows, cols} @= length(inp)
    seq moves = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    
    seq visited = repeat(repeat(0, rows), rows)
    pq_add({{1, 1}, 0})

    seq node
    int cost
    int {x, y} @= 0
    
    while pq_size() do
        {node, cost} = pq_pop()
        {x, y} = node
        if visited[x][y] != 1 then
            visited[x][y] = 1
            
            if x == rows and y == rows then
                printf(1, "Answer is: %d\n", cost)
                exit
            end if
            
            for i=1 to 4 do
                int {n_x, n_y} = {x + moves[i][1], y + moves[i][2]}
                if cell_legit(n_x, n_y, rows, rows) == true then
                    if visited[n_x][n_y] != 1 then
                        pq_add({{n_x, n_y}, cost + inp[n_x][n_y]})
                    end if
                end if
            end for
        end if
    end while
end procedure

main()
