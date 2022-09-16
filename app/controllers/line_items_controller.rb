# frozen_string_literal: true

class LineItemsController < ApplicationController
  def create
    @line_item = current_order.line_items.new(order_params)
    current_order.save
    session[:order_id] = @order.id
  end

  def update
    @order = current_order
    @line_item = @order.line_items.find(params[:id])
    @line_item.update_attributes(order_params)
    @line_items = current_order.line_items
  end

  def destroy
    @order = current_order
    @line_item = @order.line_items.find(params[:id])
    @line_item.destroy
    @line_items = current_order.line_items
  end

  private

  def order_params
    params.require(:line_item).permit(:product_id, :quantity)
  end
end
