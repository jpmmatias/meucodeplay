Rails
	.application
	.routes
	.draw do
		root 'home#index'
		devise_for :users
		resources :teachers
		resources :courses do
			resources :lectures
		end
		resources :lectures, only: [] do
			resources :comments, only: [:create]
		end
	end
