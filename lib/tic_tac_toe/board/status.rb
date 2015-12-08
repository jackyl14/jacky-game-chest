module TicTacToe
  class Board
    class Status

      attr_accessor :winner_key, :tic_tac_toe_array

      def initialize
        @winner_key = nil
        @tic_tac_toe_array = []
      end

      def game_over?
        winner_key.present?
      end

      def opponent_wins?
        winner_key == TicTacToe::Player::HUMAN_KEY
      end

      def report
        (game_over?) ? { game_over: true, winner_key: winner_key, tic_tac_toe_array: tic_tac_toe_array} : { game_over: false }
      end

      def record_winner(type, board, winner_key, row, i)
        @winner_key = winner_key
        case type
        when :row
          row.each_with_index { |position, j| @tic_tac_toe_array << [i, j] }
        when :column
          row.each_with_index { |position, j| @tic_tac_toe_array << [j, i] }
        when :diagonal
          record_diagonal_tic_tac_toe(board, row, i)
        end
      end

      private

      def record_diagonal_tic_tac_toe(board, row, index)
        case index
        when TicTacToe::Board::LR_DIAGONAL_INDEX
          @tic_tac_toe_array = TicTacToe::Board::LR_DIAGONAL
        when TicTacToe::Board::RL_DIAGONAL_INDEX
          @tic_tac_toe_array = TicTacToe::Board::RL_DIAGONAL
        end
      end
    end
  end
end
