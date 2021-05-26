Rails
	.application
	.routes
	.draw do
		root 'home#index'
		resources :teachers
		resources :courses do
			resources :lectures, only: %i[create new edit update show destory]
		end
	end
