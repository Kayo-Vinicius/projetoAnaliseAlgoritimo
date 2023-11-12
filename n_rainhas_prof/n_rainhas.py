import copy

class Node:
    def __init__(self, board, queens, n):
        self.board = board
        self.queens = queens
        self.n = n
        self.children = []

    def is_valid(self, row, col, n):
        # Rainha na mesma coluna
        for i in range(row):
            if self.board[i][col] == "Q":
                return False

        # Rainha na diagonal superior esquerda
        for i, j in zip(range(row, -1, -1), range(col, -1, -1)):
            if self.board[i][j] == "Q":
                return False

        # Rainha na diagonal superior direita
        for i, j in zip(range(row, -1, -1), range(col, n)):
            if self.board[i][j] == "Q":
                return False

        return True
    def generate_children(self):
        if self.queens == self.n:
            print_board(self.board)
            return  # N-rainhas já estão no tabuleiro

        row = self.queens

        for col in range(self.n):
            if self.is_valid(row, col, self.n):
                child_board = copy.deepcopy(self.board)
                child_board[row][col] = "Q"
                self.children.append(Node(child_board, self.queens+1, self.n))
        
        for child in self.children:
            child.generate_children()

def print_board(board):
    for row in board:
        print(" ".join(row))
    print('- '*len(row))

def solve_n_queens_tree(n):
    root = Node([["X" for _ in range(n)] for _ in range(n)], 0, n)
    root.generate_children()

solve_n_queens_tree(4)