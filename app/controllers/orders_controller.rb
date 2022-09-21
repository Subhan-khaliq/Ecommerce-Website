# frozen_string_literal: true

class OrdersController < ApplicationController
  attr_accessor :code

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @cart = @current_cart
  end

  def create
    @order = Order.new
    @order.update(user_id: current_user.id)
    add_line_items_to_order
    @order.sub_total = @current_cart.sub_total
    @order.save!
    reset_sessions_cart
    redirect_to order_path(@order)
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_path }
      format.json { head :no_content }
      flash[:info] = 'Order was successfully destroyed.'
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to orders_path
  end

  def apply_coupons
    @coupon = Coupon.find_by(code: params[:code])
    @order = Order.find(params[:id])
    after_discount = @order.sub_total - percent_of(@coupon.discount, @order.sub_total)
    @order.update(sub_total: after_discount)
    redirect_back(fallback_location: @order)
  end

  private

  def add_line_items_to_order
    @current_cart.line_items.each do |item|
      item.cart_id = nil
      item.order_id = @order.id
      item.save
      @order.line_items << item
    end
  end

  def percent_of(percent, number)
    percentage = percent * 100.0
    percentage.to_d / 100.0 * number
  end

  def reset_sessions_cart
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
  end

  def order_params
    params.require(:order).permit(:user_id, :sub_total, :code)
  end
end
