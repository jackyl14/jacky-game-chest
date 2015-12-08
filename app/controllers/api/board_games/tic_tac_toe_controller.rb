module Api
  module BoardGames
    class TicTacToeController < ApplicationController

      def cpu_makes_move
        respond_to do |format|
          format.js do
            begin
              board = TicTacToe::Board.new(JSON.parse(params[:board_field]))
              cpu = TicTacToe::Computer.new(board)
              cpu.make_move
              @message = { data: { board: cpu.board.grid, status: cpu.board.status.report }, success: true }
            rescue => e
              @message = { data: { error: e.to_s }, success: false }
            end
            render "response"
          end
        end
      end

    end
  end
end
