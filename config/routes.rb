Rails
	.application
	.routes
	.draw do
		root 'home#index'
		resources :teachers
		resources :courses do
			resources :lectures
		end
		resources :lectures, only: [] do
			resources :comments, only: [:create]
		end
	end
