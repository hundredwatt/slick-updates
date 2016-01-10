Rails.application.routes.draw do
  root to: 'high_voltage/pages#show', id: 'home'

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  match '/auth/:provider/callback', to: 'omniauth_callbacks#callback', via: [:get, :post]

  resources :public_update_forms, path: 'updates', param: :token, only: [:show, :update]

  resources :update_forms, only: [:new, :create] do
    resources :questions, only: [:index, :create, :destroy]
  end
end
