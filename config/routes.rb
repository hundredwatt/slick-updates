Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  resources :public_update_forms, path: 'updates', param: :token, only: [:show, :update]

  resources :update_forms, only: [:new, :create] do
    resources :questions
  end
end
