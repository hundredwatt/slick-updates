Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  resources :update_forms do
    resources :questions
  end
end
