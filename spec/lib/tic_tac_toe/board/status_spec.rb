require "rails_helper"

RSpec.describe TicTacToe::Board::Status do
  let!(:status) { TicTacToe::Board::Status.new }
  let!(:player_key) { TicTacToe::Player::COMPUTER_KEY }

  describe "#record_winner" do
    context "when the player wins horizontally" do
      it "properly sets the player as the winner & returns the correct array" do
        board = TicTacToe::Board.new([[0, nil, 0],[nil, 1, 1],[nil, nil, nil]])
        status.record_winner(:row, board, player_key, [0, nil, 0], 0)
        expect(status.winner_key).to eql(player_key)
        expect(status.tic_tac_toe_array).to eql([[0,0],[0,1],[0,2]])
      end
    end

    context "when the player wins vertically" do
      it "properly sets the player as the winner & returns the correct array" do
        board = TicTacToe::Board.new([[0, nil, nil],[0, 1, 1],[nil, nil, nil]])
        status.record_winner(:column, board, player_key, [0, 0, nil], 0)
        expect(status.winner_key).to eql(player_key)
        expect(status.tic_tac_toe_array).to eql([[0,0],[1,0],[2,0]])
      end
    end

    context "when the player wins diagonally" do
      it "properly sets the player as the winner & returns the correct array" do
        board = TicTacToe::Board.new([[0, nil, nil],[1, 0, 1],[nil, nil, nil]])
        status.record_winner(:diagonal, board, player_key, [0, 0, nil], 0)
        expect(status.winner_key).to eql(player_key)
        expect(status.tic_tac_toe_array).to eql([[0,0],[1,1],[2,2]])
      end
    end
  end

end
