Rails.application.routes.draw do

  devise_for :admins,controllers: {
    sessions: "admins/sessions",
    passwords: "admins/passwords",
    registrations: "admins/registrations"
  }

  devise_for :members,controllers: {
    sessions: "members/sessions",
    passwords: "members/passwords",
    registrations: "members/registrations"
  }

  scope module: :members do #URLを変えずにルーティング設定[Railsのroutingにおけるscope/namespace/moduleの違い]参照
    resources :members
    resources :ideas do
      resources :idea_comments, only: [:create,:destroy]
      resource :favorites, only: [:create,:destroy]
    end
    root "ideas#top"
    get "about" => "ideas#about"
    get "genre" => "ideas#genre_index"
  end

  namespace :admins do
    resources :ideas, only: [:index]
    resources :members, only: [:index,:show]
    resources :genres, only: [:index,:create,:edit,:update,:destroy]
    get "company" => "members#company"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
