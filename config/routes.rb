Rails.application.routes.draw do

  namespace :api, { format: 'json' } do
    get '/news' => 'news#index'
  end

end
