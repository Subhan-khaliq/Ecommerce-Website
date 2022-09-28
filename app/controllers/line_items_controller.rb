# frozen_string_literal: true

class LineItemsController < ApplicationController
  before_action :set_line_item, only: %i[destroy reduce_quantity]

  def create
    chosen_product = Product.find(params[:product_id])
    add_items_to_cart(chosen_product)
    respond_to do |format|
      if @line_item.save!
        format.html { redirect_back(fallback_location: @current_cart) }
        format.js
      else
        format.html { render :new, notice: 'Error adding product to basket!' }
      end
    end
  end

  def destroy
    @line_item.destroy
    redirect_back(fallback_location: @current_cart)
  end

  def add_quantity
    result = LineItemsManager::LineItemsAddQuantity.new(
      id: params[:id]
    ).call

    if result.success?
      redirect_back(fallback_location: @current_cart)
    else
      render error: result.errors
    end
  end

  def reduce_quantity
    result = LineItemsManager::LineItemsReduceQuantity.new(
      id: params[:id]
    ).call

    if result.success?
      redirect_back(fallback_location: @current_cart)
    else
      render error: result.errors
    end
  end

  private

  def line_item_params
    params.require(:line_item).permit(:quantity, :product_id, :cart_id)
  end

  def add_items_to_cart(chosen_product)
    @line_item = @current_cart.line_items.create(product: chosen_product)
  end

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end
end
