require "rails_helper"

RSpec.describe Api::BoardGames::TicTacToeController, :type => :controller do
  describe "POST #cpu_makes_move" do
    context "with no params passed" do
      it "responds successfully with an error message" do
        post :cpu_makes_move, format: :js
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(response).to render_template("response")
      end
    end

    context "with params passed" do
      it "responds successfully with a new board matrix" do
        post :cpu_makes_move, :board_field => [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]].to_json, format: :js
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(response).to render_template("response")
      end
    end
  end
end
