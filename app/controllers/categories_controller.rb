class CategoriesController < ApplicationController
    
    def new
        @category = Category.new
    end

    def index
        @pagy, @categories = pagy(Category.all, items: 10)
    end

    def create
        @category = Category.new(categories_params)
        if @category.save
            flash[:success] = "You have successfully created a category"
            redirect_to categories_path
        else
            render 'new'
        end
    end

    def show

    end

    private

    def categories_params
        params.require(:category).permit(:name)
    end

end