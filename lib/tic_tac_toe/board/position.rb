module TicTacToe
  class Board
    class Position

      attr_accessor :x, :y

      def initialize(array)
        if valid_argument?(array)
          @x = array.first
          @y = array.last
        end
      end

      def ==(position)
        (x == position.x && y == position.y)
      end

      def to_a
        [x, y]
      end

      def left?
        y == 0
      end

      def right?
        y == 2
      end

      def self.center
        self.new(TicTacToe::Board::CENTER)
      end

      def self.corners
        corner_positions = []
        TicTacToe::Board::CORNERS.each do |corner|
          corner_positions << self.new(corner)
        end
        return corner_positions
      end

      def self.middles
        middle_positions = []
        TicTacToe::Board::MIDDLES.each do |middle|
          middle_positions << self.new(middle)
        end
        return middle_positions
      end


      def self.left_right_diagonal
        left_right_diagonal_positions = []
        TicTacToe::Board::LR_DIAGONAL.each do |pos|
          left_right_diagonal_positions << self.new(pos)
        end
        return left_right_diagonal_positions
      end

      def self.right_left_diagonal
        right_left_diagonal_positions = []
        TicTacToe::Board::RL_DIAGONAL.each do |pos|
          right_left_diagonal_positions << self.new(pos)
        end
        return right_left_diagonal_positions
      end

      private

      def valid_argument?(array)
        if !array.is_a?(Array)
          raise SyntaxError, "Invalid arguments: must be an array"
        elsif array.length != 2
          raise SyntaxError, "Invalid arguments: must have two values"
        elsif (array.first > TicTacToe::Board::M_DIMENSIONS &&
          array.last > TicTacToe::Board::N_DIMENSIONS)
          raise SyntaxError, "Invalid arguments: must be within the board boundaries"
        else
          return true
        end
      end

    end
  end
end
