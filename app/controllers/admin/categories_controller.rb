class Admin::CategoriesController < Admin::AdminController
	before_action :authenticate_user!,
	              only: %i[index edit update create new destroy]
	before_action :set_category, only: %i[edit update]
	def index
		@categories = Categorie.all
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

	def edit; end

	def update
		if @category.update(category_params)
			redirect_to admin_categories_path, notice: 'Categoria editada com sucesso'
		else
			render :edit
		end
	end

	def destroy
		if Categorie.friendly.find(params[:id]).destroy
			redirect_to admin_categories_path,
			            notice: 'Categoria deletada com sucesso'
		else
			redirect_to admin_categories_path, alert: 'Erro ao excluir categoria'
		end
	end

	private

	def set_category
		@category = Categorie.friendly.find(params[:id])
	end

	def category_params
		params.require(:categorie).permit(%i[name])
	end
end
