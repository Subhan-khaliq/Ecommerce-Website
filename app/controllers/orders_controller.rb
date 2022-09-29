# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy apply_coupons]

  def index
    @orders = current_user.orders
  end

  def show; end

  def new
    @order = Order.new
    @cart = @current_cart
  end

  def create
    @order = Order.new
    # authorize @order
    @order.update(user_id: current_user.id)
    @order.sub_total = @current_cart.total_amount
    add_line_items_to_order
    @order.save!
    reset_sessions_cart
    redirect_to order_path(@order)
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_path }
      format.json { head :no_content }
    end
  end

  def edit; end

  def update
    @order.update(order_params)
    redirect_to orders_path
  end

  def apply_coupons
    result = OrdersManager::ApplyCoupons.new(
      promo_code: params[:promo_code],
      order: @order
    ).call

    if result.success?
      redirect_back(fallback_location: @order)
    else
      render error: result.errors
    end
  end

  private

  def add_line_items_to_order
    @current_cart.line_items.each do |item|
      @product = Product.find(item.product_id)
      @product.update(quantity: @product.quantity - item.quantity)
      if @product.quantity.zero?
        @product.destroy
      end
    end
    @current_cart.line_items.update_all(order_id: @order.id, cart_id: nil)
  end

  def reset_sessions_cart
    session[:cart_id] = nil
  end

  def order_params
    params.require(:order).permit(:user_id, :sub_total)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
