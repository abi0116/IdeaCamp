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
    resources :members do
      get "adopt_idea" => "members#adopt_idea"
    end

    get   'inquiry'         => 'inquiries#index'     # 問い合わせ入力画面
    post  'inquiry/confirm' => 'inquiries#confirm'   # 問い合わせ確認画面
    post  'inquiry/thanks'  => 'inquiries#thanks'    # 問い合わせ送信完了画面

    resources :ideas do
      get 'get_tag_search', on: :collection, defaults: { format: 'json' }
      get 'get_tag_search', on: :member, defaults: { format: 'json' }
      patch "status_update" => "ideas#status_update"
      resources :idea_comments, only: [:create,:destroy]
      resource :favorites, only: [:create,:destroy]
    end
    root "ideas#top"
    get "about" => "ideas#about"
    get "genre" => "ideas#genre_index"
    resources :companies,only: [:new,:create]
    resources :notifications, only: :index
  end

  namespace :admins do
    resources :ideas, only: [:index]
    resources :members, only: [:index,:show]
    resources :genres, only: [:index,:create,:edit,:update,:destroy]
    resources :companies,only: [:index,:update]
    get "complete" => "companies#complete"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
