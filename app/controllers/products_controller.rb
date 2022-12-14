# frozen_string_literal: true

class ProductsController < ApplicationController
  require 'thinking_sphinx'

  before_action :set_product, only: %i[show edit update destroy]

  def index
    # @products = Product.search(params[:search], field_weights: { name: 20, content: 10 })
    @products = Product.all
  end

  def show
    @comments = @product.comments
    @comment = Comment.new
  end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = current_user.products.build(product_params)
    @product.save
  rescue StandardError
    render :new
  else
    redirect_to @product
  end

  def update
    # authorize @product
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
  rescue StandardError
    flash[:alert] = 'Something worng, try again'
  else
    redirect_to products_path
  end

  private

  def set_product
    @product = Product.friendly.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :user_id, :serial_number, :quantity, images: [])
  end
end
