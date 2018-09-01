Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :create]

  resources :transactions, only: [:index] do
    collection do
      post 'buy', to: 'transactions#buy'
      post 'sell', to: 'transactions#sell'
      post 'withdraw', to: 'transactions#withdraw'
      post 'top_up', to: 'transactions#top_up'
    end
  end
end
