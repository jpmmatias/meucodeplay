class Admin::CategoriesController < Admin::AdminController
	def index
		@categories = Categorie.all
	end

	def show
		@categorie = Categorie.friendly.find(params[:id])
		@categories = Categorie.all
		@courses = @categorie.courses
	end

	def new
		@category = Categorie.new
	end

	def create
		@category = Categorie.new(category_params)
		if @category.save
			redirect_to admin_categories_path, notice: 'Categoria criada com sucesso'
		else
			render :new
		end
	end

	private

	def category_params
		params.require(:categorie).permit(%i[name])
	end
end
