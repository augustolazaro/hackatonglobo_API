Rails.application.routes.draw do

  namespace :api, { format: 'json' } do
    get '/news' => 'news#index'
    get '/graph' => 'news#graph'
    post '/create_news' => 'news#create'
  end

end
