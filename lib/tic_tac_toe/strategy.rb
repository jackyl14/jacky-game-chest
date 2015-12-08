module TicTacToe
  class Strategy

    attr_accessor :two_way_guard_moves, :dead_end_moves, :defense_moves, :victory_moves

    def initialize
      @two_way_guard_moves = []
      @dead_end_moves = []
      @defense_moves = []
      @victory_moves = []
    end

    def look_for_two_way_moves(board, player_key, opponent_key)
      corner_two_way_move(board, player_key, opponent_key)
      corner_middle_two_way_move(board, player_key, opponent_key) if two_way_guard_moves.empty?
    end

    def look_for_tic_tac_toe(board, player_key, opponent_key)
      TicTacToe::PATTERNS.each do |type|
        if !board.status.game_over?
          grid = translate_board(type, board)
          grid.each_with_index do |row, index|
            if row.compact.length == 2
              position = find_empty_position(type, board, player_key, opponent_key, row, index)
              evaluate_position(type, board, player_key, opponent_key, row, index, position)
            elsif (row.compact.length == 3 && !row.include?(player_key) && row.include?(opponent_key))
              board.status.record_winner(type, board, opponent_key, row, index)
            end
          end
        end
      end
    end

    private

    def corner_two_way_move(board, player_key, opponent_key)
      grid = board.transpose_diagonals
      grid.each_with_index do |row, index|
        if (row.compact.length == 3 && row.include?(player_key) && row.include?(opponent_key))
          center_pos_val = board.position(TicTacToe::Board::Position.center)
          if center_pos_val == player_key
            available_positions = TicTacToe::Board::Position.middles.select { |pos| board.position(pos).nil? }
            rand_gen = rand(0..available_positions.length - 1)
            (available_positions.present?) ? two_way_guard_moves << available_positions[rand_gen]: nil
          elsif center_pos_val == opponent_key
            available_positions = TicTacToe::Board::Position.corners.select { |pos| board.position(pos).nil? }
            rand_gen = rand(0..available_positions.length - 1)
            (available_positions.present?) ? two_way_guard_moves << available_positions[rand_gen]: nil
          end
        end
      end
    end

    def corner_middle_two_way_move(board, player_key, opponent_key)
      [:row, :column].each do |type|
        grid = translate_board(type, board)
        grid.each_with_index do |row, index|
          if (row.compact.length == 2 && row.include?(player_key) && row.include?(opponent_key))
            position =  TicTacToe::Board::Position.new([index,row.rindex(nil)])
            if grid[position.x - 1][position.y] == opponent_key
              @two_way_guard_moves << find_block_position(type, position.x - 1, position.y - 1) if position.right?
              @two_way_guard_moves << find_block_position(type, position.x - 1, position.y + 1) if position.left?
            elsif grid[position.x + 1][position.y] == opponent_key
              @two_way_guard_moves << find_block_position(type, position.x + 1, position.y - 1) if position.right?
              @two_way_guard_moves << find_block_position(type, position.x + 1, position.y + 1) if position.left?
            end
          end
        end
      end
    end

    def find_block_position(type, x, y)
      case type
      when :row
        return TicTacToe::Board::Position.new([x, y])
      when :column
        return TicTacToe::Board::Position.new([y, x])
      end
    end

    def translate_board(type, board)
      case type
      when :row
        return board.grid
      when :column
        return board.transpose
      when :diagonal
        return board.transpose_diagonals
      end
    end

    def find_empty_position(type, board, player_key, opponent_key, row, index)
      case type
      when :row
        return TicTacToe::Board::Position.new([index,row.rindex(nil)])
      when :column
        return TicTacToe::Board::Position.new([row.rindex(nil), index])
      when :diagonal
        return find_diagonal_position(board, player_key, opponent_key, index)
      end
    end

    def find_diagonal_position(board, player_key, opponent_key, index)
      position = nil
      case index
      when TicTacToe::Board::LR_DIAGONAL_INDEX
        TicTacToe::Board::Position.left_right_diagonal.each do |d_position|
          return d_position if board.position(d_position).nil?
        end
      when TicTacToe::Board::RL_DIAGONAL_INDEX
        TicTacToe::Board::Position.right_left_diagonal.each do |d_position|
          return d_position if board.position(d_position).nil?
        end
      end
    end

    def evaluate_position(type, board, player_key, opponent_key, row, index, position)
      if (row.include?(player_key) && row.include?(opponent_key))
        @dead_end_moves << position unless dead_end_moves.include?(position)
      elsif row.include?(opponent_key)
        @defense_moves << position unless defense_moves.include?(position)
      elsif row.include?(player_key)
        @victory_moves << position unless victory_moves.include?(position)
        board.status.record_winner(type, board, player_key, row, index)
      end
    end
  end
end
