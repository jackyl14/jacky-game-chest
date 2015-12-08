module TicTacToe
  class Computer < Player

    def initialize(board)
      super(board, TicTacToe::Player::COMPUTER_KEY, TicTacToe::Player::HUMAN_KEY)
    end

    def make_move
      case board.total_moves
      when 0
        move = pick_random_position(:corner)
      when 1
        move = pick_center_position || pick_random_position(:corner)
      when 2
        move = pick_center_position || randomize_second_move
      when 3
        strategy.look_for_two_way_moves(board, player_key, opponent_key)
        move = strategy.two_way_guard_moves.first
        if move.nil?
          strategy.look_for_tic_tac_toe(board, player_key, opponent_key)
          move = solidify_win || guard_against_win || make_offensive_move
        end
      else
        strategy.look_for_tic_tac_toe(board, player_key, opponent_key)
        move = solidify_win || guard_against_win || make_offensive_move
      end
      board[move.x, move.y] = player_key unless board.status.opponent_wins?
      return move
    end

    private

    def randomize_second_move
      x = rand()
      if x > 0.6
        strategy.look_for_tic_tac_toe(board, player_key, opponent_key)
        move = strategy.dead_end_moves.first
      elsif (x > 0.3 && x <= 0.6)
        move = pick_random_position(:middle)
      else
        move = pick_random_position(:corner)
      end
      return move
    end

    def solidify_win
      (strategy.victory_moves.present?) ? strategy.victory_moves.first : nil
    end

    def guard_against_win
      (strategy.defense_moves.present?) ? strategy.defense_moves.first : nil
    end

    def make_offensive_move
      position = pick_random_position(:corner) || pick_random_position(:middle)
      (position.nil?) ? strategy.dead_end_moves.first : position
    end
  end
end
