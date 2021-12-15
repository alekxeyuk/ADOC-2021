from queue import PriorityQueue
from typing import List, Set, Tuple


board: List[List[int]] = []

with open('input.txt', 'r') as inp_f:
    for line in inp_f.readlines():
        board.append(list(map(int, line.strip())))

rows = len(board)
cols = len(board[0])
moves = ((-1, 0), (1, 0), (0, -1), (0, 1))

def cell_legit(cell: Tuple[int, int]) -> bool:
    return cols > cell[0] >= 0 and rows > cell[1] >= 0

def cell_neighbours(cell: Tuple[int, int]) -> List[Tuple[int, int]]:
    return [n_c for x, y in moves if cell_legit(n_c := (cell[0] + x, cell[1] + y))]

def ucs(graph: List[List[int]], start: Tuple[int, int], goal: Tuple[int, int]) -> int:
    visited: Set[Tuple[int, int]] = set()
    queue: PriorityQueue[Tuple[int, Tuple[int, int]]] = PriorityQueue()
    queue.put((0, start))

    while queue:
        cost, node = queue.get()
        if node not in visited:
            visited.add(node)

            if node == goal:
                return cost

            for i in cell_neighbours(node):
                if i not in visited:
                    queue.put((cost + graph[i[0]][i[1]], i))
    return -1


# Part 1
print(ucs(board, (0, 0), (rows - 1, cols - 1)))

def expand_matrix(matrix: List[List[int]], mag = 5) -> List[List[int]]:
    width: int = len(matrix[0])
    height: int = len(matrix)
    output = [[0 for _x in range(width*mag)] for _y in range(height*mag)]

    for y in range(mag):
        for x in range(mag):
            for b in range(height):
                for a in range(width):
                    output[(y*height) + b][(x*width) + a] = (matrix[b][a] + y + x - 1) % 9 + 1

    return output

# Part 2
board = expand_matrix(board)

rows = len(board)
cols = len(board[0])

print(ucs(board, (0, 0), (rows - 1, cols - 1)))
