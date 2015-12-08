require "rails_helper"

RSpec.describe TicTacToe::Board do
  describe "#initialize" do
    context "with invalid args" do
      it "raises an error for nil board" do
        board = nil
        expect { TicTacToe::Board.new(board) }.to raise_error(SyntaxError)
      end

      it "raises an error for a string board" do
        board = "[[0,1,0],[0,1,0],[0,1,0]]"
        expect { TicTacToe::Board.new(board) }.to raise_error(SyntaxError)
      end

      it "raises an error for wrong m dimensional board" do
        board = [[0,1,0],[0,1,0]]
        expect { TicTacToe::Board.new(board) }.to raise_error(SyntaxError)
      end

      it "raises an error for wrong n dimensional board" do
        board = [[0,1,0],[0,1,0],[0,1,0],[0,1,0]]
        expect { TicTacToe::Board.new(board) }.to raise_error(SyntaxError)
      end

      it "raises an error for incorrect board values" do
        board = [[3,1,4],[0,1,0],[0,1,2]]
        expect { TicTacToe::Board.new(board) }.to raise_error(SyntaxError)
      end
    end

    context "with valid args" do
      it "is a new TicTacToe::Board object" do
        board = [[0,1,0],[0,1,0],[0,1,0]]
        expect(TicTacToe::Board.new(board)).to be_an_instance_of(TicTacToe::Board)
      end

      it "returns the correct transposed grid" do
        board = TicTacToe::Board.new([[0,1,0],[0,1,0],[0,1,0]])
        expect(board.transpose).to eq([[0,0,0],[1,1,1],[0,0,0]])
      end


      it "returns the correct grid of diagonals" do
        board = TicTacToe::Board.new([[0,1,0],[0,1,0],[0,1,0]])
        expect(board.transpose_diagonals).to eq([[0,1,0],[0,1,0]])
      end
    end
  end
end
