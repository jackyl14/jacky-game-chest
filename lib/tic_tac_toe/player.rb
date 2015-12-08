module TicTacToe
  class Player

    attr_accessor :board, :player_key, :opponent_key, :strategy

    COMPUTER_KEY = 0
    HUMAN_KEY = 1

    def initialize(board, player_key, opponent_key)
      if board.is_a? TicTacToe::Board
        @board = board
        @player_key = player_key
        @opponent_key = opponent_key
        @strategy = TicTacToe::Strategy.new
      else
        raise SyntaxError, "must be initialized with a TicTacToe::Board"
      end
    end

    def pick_random_position(type)
      available_positions = all_positions(type).select do |pos|
        (board.position(pos).nil? && !strategy.dead_end_moves.include?(pos))
      end
      rand_gen = rand(0..available_positions.length - 1)
      (available_positions.present?) ? available_positions[rand_gen] : nil
    end

    def pick_center_position
      center_pos = TicTacToe::Board::Position.center
      return (board.position(center_pos).nil?) ? center_pos : nil
    end

    private

    def all_positions(type)
      case type
      when :corner
        return TicTacToe::Board::Position.corners
      when :middle
        return TicTacToe::Board::Position.middles
      else
        raise SyntaxError, "Invalid position type"
      end
    end
  end
end
