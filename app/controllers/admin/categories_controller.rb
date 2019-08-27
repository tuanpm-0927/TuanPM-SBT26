# frozen_string_literal: true

class Admin::CategoriesController < ApplicationController
  before_action :load_category, only: %i[show edit destroy update]
  before_action :load_categories, only: %i[index create]

  def index
    @categories = Category.paginate(page: params[:page], per_page: Settings.def_perpage)
  end

  def new
    @category = Category.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @category = Category.new category_params
    if @category.save
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def show; end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @check_update = @category.update_attributes(category_params)
      flash[:success] = t ".category_update_success"
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t ".delete_success"
      redirect_to admin_categories_path
    end
  end

  private

  def load_category
    @category = Category.find_by(id: params[:id])
    unless @category
      flash.now[:danger] = t ".category_notfound"
      redirect_to notfound_path
    end
  end

  def load_categories
    @categories = Category.paginate(page: Settings.def_page, per_page: Settings.def_perpage)
  end

  def category_params
    params.require(:category).permit(:name, :type_post, :image)
  end
end
