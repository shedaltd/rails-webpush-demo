Rails.application.routes.draw do
  get "/" => "content#index"
  post "/sendkeys" => "content#getJSON", :as => :getJSON
  post "/sendNo" => "content#sendPush", :as => :sendPush

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
