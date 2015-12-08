require "rails_helper"

RSpec.describe TicTacToe::Board::Position do
  describe "#initialize" do
    context "with invalid array" do
      it "raises a SyntaxError" do
        array = [5,5]
        expect { TicTacToe::Board::Position.new(array) }.to raise_error(SyntaxError)
      end
    end

    context "with valid array" do
      it "is a new TicTacToe::Board::Position object" do
        array = [1,1]
        expect(TicTacToe::Board::Position.new(array)).to be_an_instance_of(TicTacToe::Board::Position)
      end
    end
  end

end
