json.(@message, :success)
json.data do
  if @message[:data][:board].present?
    json.board @message[:data][:board]
  elsif @message[:data][:error].present?
    json.error @message[:data][:error]
  end

  if @message[:data][:status].present?
    json.status do
      json.game_over @message[:data][:status][:game_over]

      if @message[:data][:status][:game_over]
        json.winner_key @message[:data][:status][:winner_key]
        json.tic_tac_toe_array @message[:data][:status][:tic_tac_toe_array]
      end

    end
  end

end
