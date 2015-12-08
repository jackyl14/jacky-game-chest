require "rails_helper"

RSpec.describe TicTacToe::Strategy do
  let!(:player_key) { TicTacToe::Player::COMPUTER_KEY }
  let!(:opponent_key) { TicTacToe::Player::HUMAN_KEY }

  describe "#look_for_tic_tac_toe" do

    context "with an empty board" do
      it "returns nil" do
        board = TicTacToe::Board.new([[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]])
        strategy = TicTacToe::Strategy.new
        strategy.look_for_tic_tac_toe(board, player_key, opponent_key)
        expect(strategy.dead_end_moves).to be_empty
        expect(strategy.defense_moves).to be_empty
        expect(strategy.victory_moves).to be_empty
      end
    end

    context "with one tic-tac-toe-ready row" do
      it "returns one victory move and all other moves empty" do
        board = TicTacToe::Board.new([[nil, nil, nil],[0, 0, nil],[nil, nil, nil]])
        strategy = TicTacToe::Strategy.new
        strategy.look_for_tic_tac_toe(board, player_key, opponent_key)
        expect(strategy.dead_end_moves).to be_empty
        expect(strategy.defense_moves).to be_empty
        expect(strategy.victory_moves).not_to be_empty
        expect(strategy.victory_moves.length).to eql(1)
        expect(strategy.victory_moves.first).to eq(TicTacToe::Board::Position.new([1,2]))
      end
    end

    context "with one tic-tac-toe-ready column" do
      it "returns one victory move and all other moves empty" do
        board = TicTacToe::Board.new([[nil, nil, nil],[nil, 0, nil],[nil, 0, nil]])
        strategy = TicTacToe::Strategy.new
        strategy.look_for_tic_tac_toe(board, player_key, opponent_key)
        expect(strategy.dead_end_moves).to be_empty
        expect(strategy.defense_moves).to be_empty
        expect(strategy.victory_moves).not_to be_empty
        expect(strategy.victory_moves.length).to eql(1)
        expect(strategy.victory_moves.first).to eq(TicTacToe::Board::Position.new([0,1]))
      end
    end

    context "with one tic-tac-toe-ready diagonal" do
      it "returns one victory move and all other moves empty" do
        board = TicTacToe::Board.new([[nil, nil, nil],[nil, 0, nil],[0, nil, nil]])
        strategy = TicTacToe::Strategy.new
        strategy.look_for_tic_tac_toe(board, player_key, opponent_key)
        expect(strategy.dead_end_moves).to be_empty
        expect(strategy.defense_moves).to be_empty
        expect(strategy.victory_moves).not_to be_empty
        expect(strategy.victory_moves.length).to eql(1)
        expect(strategy.victory_moves.first).to eq(TicTacToe::Board::Position.new([0,2]))
      end
    end

    context "with one dead end move" do
      it "returns one dead end move and all other moves empty" do
        board = TicTacToe::Board.new([[1, 0, 1],[0, 1, nil],[0, 1, 0]])
        strategy = TicTacToe::Strategy.new
        strategy.look_for_tic_tac_toe(board, player_key, opponent_key)
        expect(strategy.dead_end_moves).not_to be_empty
        expect(strategy.defense_moves).to be_empty
        expect(strategy.victory_moves).to be_empty
        expect(strategy.dead_end_moves.length).to eql(1)
        expect(strategy.dead_end_moves.first.x).to eql(1)
        expect(strategy.dead_end_moves.first.y).to eql(2)
        expect(strategy.dead_end_moves.first).to eq(TicTacToe::Board::Position.new([1,2]))
      end
    end
  end

  describe "#look_for_two_way_moves" do

    context "with fake corner_two_way_move on the board" do
      it "returns a corner that is not taken" do
        board = TicTacToe::Board.new([[1, nil, nil],[1, 0, nil],[nil, nil, nil]])
        strategy = TicTacToe::Strategy.new
        strategy.look_for_two_way_moves(board, player_key, opponent_key)
        expect(strategy.dead_end_moves).to be_empty
        expect(strategy.defense_moves).to be_empty
        expect(strategy.victory_moves).to be_empty
        expect(strategy.two_way_guard_moves).to be_empty
      end
    end

    context "with corner_two_way_move on the board" do
      it "returns a corner that is not taken" do
        board = TicTacToe::Board.new([[1, nil, nil],[nil, 0, nil],[nil, nil, 1]])
        strategy = TicTacToe::Strategy.new
        strategy.look_for_two_way_moves(board, player_key, opponent_key)
        expect(strategy.dead_end_moves).to be_empty
        expect(strategy.defense_moves).to be_empty
        expect(strategy.victory_moves).to be_empty
        expect(strategy.two_way_guard_moves).not_to be_empty
        expect(strategy.two_way_guard_moves.length).to eql(1)
        expect(TicTacToe::Board::Position.middles).to include(strategy.two_way_guard_moves.first)
      end
    end

    context "with corner_two_way_move on the board" do
      it "returns a middle that is not taken" do
        board = TicTacToe::Board.new([[0, nil, nil],[nil, 1, nil],[nil, nil, 1]])
        strategy = TicTacToe::Strategy.new
        strategy.look_for_two_way_moves(board, player_key, opponent_key)
        expect(strategy.dead_end_moves).to be_empty
        expect(strategy.defense_moves).to be_empty
        expect(strategy.victory_moves).to be_empty
        expect(strategy.two_way_guard_moves).not_to be_empty
        expect(strategy.two_way_guard_moves.length).to eql(1)
        expect(TicTacToe::Board::Position.corners).to include(strategy.two_way_guard_moves.first)
      end
    end

    context "with fake corner_middle_two_way_move on the board" do
      it "returns a corner that is not taken" do
        board = TicTacToe::Board.new([[nil, nil, nil],[nil, 0, nil],[1, 1, nil]])
        strategy = TicTacToe::Strategy.new
        strategy.look_for_two_way_moves(board, player_key, opponent_key)
        expect(strategy.dead_end_moves).to be_empty
        expect(strategy.defense_moves).to be_empty
        expect(strategy.victory_moves).to be_empty
        expect(strategy.two_way_guard_moves).to be_empty
      end
    end

    context "with corner_middle_two_way_move on the board" do
      it "checks vertically and returns the correct blocking move" do
        board = TicTacToe::Board.new([[1, nil, nil],[nil, 0, nil],[nil, 1, nil]])
        strategy = TicTacToe::Strategy.new
        strategy.look_for_two_way_moves(board, player_key, opponent_key)
        expect(strategy.dead_end_moves).to be_empty
        expect(strategy.defense_moves).to be_empty
        expect(strategy.victory_moves).to be_empty
        expect(strategy.two_way_guard_moves).not_to be_empty
        expect(strategy.two_way_guard_moves.length).to eql(1)
        expect(strategy.two_way_guard_moves.first).to eq(TicTacToe::Board::Position.new([1,0]))
      end
    end

    context "with corner_middle_two_way_move on the board" do
      it "checks horizontally and returns a blocking move" do
        board = TicTacToe::Board.new([[1, nil, nil],[nil, 0, 1],[nil, nil, nil]])
        strategy = TicTacToe::Strategy.new
        strategy.look_for_two_way_moves(board, player_key, opponent_key)
        expect(strategy.dead_end_moves).to be_empty
        expect(strategy.defense_moves).to be_empty
        expect(strategy.victory_moves).to be_empty
        expect(strategy.two_way_guard_moves).not_to be_empty
        expect(strategy.two_way_guard_moves.length).to eql(1)
        expect(strategy.two_way_guard_moves.first).to eq(TicTacToe::Board::Position.new([0,1]))
      end
    end
  end

end
