Rails
	.application
	.routes
	.draw do
		root 'home#index'
		devise_for :users
		devise_for :students

		namespace :admin do
			resources :courses do
				resources :lectures
			end
		end

		resources :teachers
		resources :courses, only: [:show] do
			resources :lectures, only: [:show]
			post 'enroll', on: :member
			get 'my_courses', on: :collection
			#get 'search', on: :collection
			#post 'favorite', on: member
		end
		resources :lectures, only: [] do
			resources :comments, only: [:create]
		end
	end
