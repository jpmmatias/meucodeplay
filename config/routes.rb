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
			resources :categories, only: %i[index new create edit update destroy]
			resources :enrollments, only: [:index]
		end

		resources :teachers

		resources :courses, only: %i[show index] do
			resources :lectures, only: [:show]
			post 'enroll', on: :member
			get 'my_courses', on: :collection
			#get 'search', on: :collection
			#post 'favorite', on: member
		end

		resources :categories, only: [:show]

		resources :lectures, only: [] do
			resources :comments, only: [:create]
		end

		namespace :api do
			namespace :v1 do
				resources :courses,
				          only: %i[index show create update destroy],
				          param: :code
			end
		end
	end
