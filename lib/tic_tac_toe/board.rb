module TicTacToe
  class Board

    attr_accessor :grid, :status

    M_DIMENSIONS = 3
    N_DIMENSIONS = 3

    CENTER = [1,1]
    CORNERS = [[0,0], [0,2], [2,0], [2,2]]
    MIDDLES = [[0,1], [1,0], [0,1], [2,1]]

    LR_DIAGONAL_INDEX = 0
    RL_DIAGONAL_INDEX = 1

    LR_DIAGONAL = [[0,0], [1,1], [2,2]]
    RL_DIAGONAL = [[0,2], [1,1], [2,0]]

    def initialize(grid)
      if valid_argument?(grid)
        @grid = grid
        @status = TicTacToe::Board::Status.new
      end
    end

    def [](i,j)
      grid[i][j]
    end

    def []=(i, j, value)
      grid[i][j] = value
    end

    def position(position)
      grid[position.x][position.y]
    end

    def total_moves
      grid.flatten.compact.length
    end

    def transpose
      t_board = [[],[],[]]
      grid.each_with_index do |row, m|
        row.each_with_index do |value, n|
          t_board[n][m] = value
        end
      end
      return t_board
    end

    def transpose_diagonals
      d_board = []
      d_board[LR_DIAGONAL_INDEX] = [grid[0][0], grid[1][1], grid[2][2]]
      d_board[RL_DIAGONAL_INDEX] = [grid[2][0], grid[1][1], grid[0][2]]
      return d_board
    end

    private

    def valid_argument?(grid)
      if !grid.is_a? Array
        raise SyntaxError, "Invalid arguments for TicTacToe::Board"
      elsif grid.length != M_DIMENSIONS
        raise SyntaxError, "Invalid n_dimensions for TicTacToe::Board"
      elsif (grid.flatten.compact - [TicTacToe::Player::COMPUTER_KEY, TicTacToe::Player::HUMAN_KEY]).present?
        raise SyntaxError, "Invalid values for TicTacToe::Board"
      else
        grid.each { |rows| raise SyntaxError, "Invalid m_dimensions for TicTacToe::Board" unless rows.length == N_DIMENSIONS }
      end
    end

  end
end
