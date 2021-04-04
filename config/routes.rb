Rails.application.routes.draw do
  devise_for :members,controllers: {
    sessions: "members/sessions"
  }

  resources :ideas
  root "ideas#top"
  get "about" => "ideas#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
