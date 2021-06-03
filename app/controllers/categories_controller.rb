class CategoriesController < ApplicationController
	def show
		@categorie = Categorie.friendly.find(params[:id])
		@categories = Categorie.all
		@courses = @categorie.courses
	end
end
