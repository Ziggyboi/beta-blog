class CategoriesController < ApplicationController
    before_action :require_admin, except: [:index, :show]
    before_action :set_category, only: [:show, :edit, :update]

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
        @pagy, @category_articles = pagy(@category.articles, items: 10)
    end

    def edit

    end

    def update
        if @category.update(categories_params)
            flash[:success] = "Category name was successfully updated"
            redirect_to category_path(@category)
        else
            render 'edit'
        end

    end

    private

    def set_category
        @category = Category.find(params[:id])
    end
    def categories_params
        params.require(:category).permit(:name)
    end

    def require_admin
        if !logged_in? || (logged_in? and !current_user.admin?)
            flash[:danger]="Only admins can perform that action"
            redirect_to categories_path
        end
    end
end