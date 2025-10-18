Rails.application.routes.draw do
  scope :api do
    resources :users, except: [:create] do
      post :sign_up, on: :collection
      post :auth,    on: :collection
    end
  end
end
