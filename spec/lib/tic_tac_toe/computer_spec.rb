require "rails_helper"

RSpec.describe TicTacToe::Computer do
  describe "#initialize" do
    context "with an invalid argument" do
      it "raises an error" do
        board = [[0,1,0],[nil,0,1],[0,nil,1]]
        expect{ TicTacToe::Computer.new(board) }.to raise_error(SyntaxError)
      end
    end

    context "with a valid TicTacToe::Board" do
      it "is an instance of a TicTacToe::Player::Computer" do
        board = TicTacToe::Board.new([[0,1,0],[nil,0,1],[0,nil,1]])
        expect(TicTacToe::Computer.new(board)).to be_an_instance_of(TicTacToe::Computer)
      end
    end
  end

  describe "#make_move" do
    context "as first player" do
      it "picks a corner position" do
        board = TicTacToe::Board.new([[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]])
        cpu = TicTacToe::Computer.new(board)
        move = cpu.make_move
        expect(TicTacToe::Board::Position.corners).to include(move)
      end
    end

    context "as second player" do
      it "picks the center position" do
        board = TicTacToe::Board.new([[1, nil, nil],[nil, nil, nil],[nil, nil, nil]])
        cpu = TicTacToe::Computer.new(board)
        move = cpu.make_move
        expect(move).to eq(TicTacToe::Board::Position.center)
      end
    end

    context "when computer sees its tic-tac-toe" do
      it "makes the tic-tac-toe move" do
        board = TicTacToe::Board.new([[1, 0, 1],[1, 0, nil],[nil, nil, nil]])
        cpu = TicTacToe::Computer.new(board)
        move = cpu.make_move
        expect(move).to eq(TicTacToe::Board::Position.new([2,1]))
      end
    end

    context "when computer sees its opponent's tic-tac-toe" do
      it "blocks the opponent's the tic-tac-toe" do
        board = TicTacToe::Board.new([[1, 0, 0],[1, nil, nil],[nil, nil, nil]])
        cpu = TicTacToe::Computer.new(board)
        move = cpu.make_move
        expect(move).to eq(TicTacToe::Board::Position.new([2,0]))
      end
    end
  end
end
