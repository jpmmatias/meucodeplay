Rails
	.application
	.routes
	.draw do
		root 'home#index'
		devise_for :users
		resources :teachers
		resources :courses do
			resources :lectures
			post 'enroll', on: :member
			get 'my_courses', on: :collection
			#get 'search', on: :collection
			#post 'favorite', on: member
		end
		resources :lectures, only: [] do
			resources :comments, only: [:create]
		end
	end
