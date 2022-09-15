# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update]
  before_action :set_product, only: %i[create destroy edit update]

  def create
    @comment = @product.comments.create(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.js
        format.html { redirect_to @product }
      end
    end
  end

  def destroy
    @comment = @product.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { render notice: 'Comment was successfully destroyed.' }
      format.js
    end
  end

  def edit; end

  def update
    @comment.update(comment_params)
    redirect_to @product
  end

  private

  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

  def set_comment
    @comment = @product.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
