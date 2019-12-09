Rails.application.routes.draw do
  root to: 'home#new_period_accuracy'

  get '/period_accuracy'  => 'home#new_period_accuracy'
  post '/period_accuracy'  => 'home#show_period_accuracy'
  get '/weekly_rankings'  => 'home#new_weekly_rankings'
  post '/weekly_rankings'  => 'home#show_weekly_rankings'

end
