# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'

  resources :tasks
  resources :recurring_tasks

  match '/users',   to: 'users#index',   via: 'get'
  devise_for :users

  resources :chatrooms do
    resource :chatroom_users
    resources :messages
  end

  resources :direct_messages

end
