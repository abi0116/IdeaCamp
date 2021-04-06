Rails.application.routes.draw do

  devise_for :members,controllers: {
    sessions: "members/sessions"
  }

  scope module: :members do #URLを変えずにルーティング設定[Railsのroutingにおけるscope/namespace/moduleの違い]参照
    resources :members
    resources :ideas do
    resources :idea_comments, only: [:create,:destroy]
    resource :favorites, only: [:create,:destroy]
  end
  root "ideas#top"
  get "about" => "ideas#about"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
