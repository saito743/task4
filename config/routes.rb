Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about'
  resources :users, only: [:show,:index,:edit,:update]do
    resources :relationships, only:[:create, :destroy]
    get 'follows' => 'relationships#follows'
    get 'followers' => 'relationships#followers'
  end
  resources :books do
  	resource :favorites, only:[:create,:destroy]
  	resources :comments, only: [:create, :destroy]
  end
end