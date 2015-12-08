JackyGameChest::Application.routes.draw do

  root 'application#home'

  namespace :board_games do
    get 'tic_tac_toe' => 'tic_tac_toes#play'
  end

  namespace :api do
    namespace :board_games do
      namespace :tic_tac_toe do
        post 'cpu_makes_move'
      end
    end
  end
end
