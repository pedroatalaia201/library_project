# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    resources :users, except: [:create] do
      post :sign_up, on: :collection
      post :login,   on: :collection
    end
  end
end
