Rails.application.routes.draw do

  namespace :api, { format: 'json' } do
    resource :news
  end

end
