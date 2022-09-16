# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_product, only: %i[create destroy edit update]
  before_action :set_comment, only: %i[edit destroy]

  def create
    # @comment = @product.comments.create(comment_params.merge(user: current_user))
    @comment = @product.comments.create(comment_params.merge(user_id: current_user.id))
    # @comment = current_user.comments.create()
    # @comment = Comment.create(user_id: current_user.id)
    # @comment = Comment.create(user: current_user)
    # @comment.user_id = current_user.id

    if @comment.persisted?

      if @comment.persisted?
      respond_to do |format|
        format.js
        format.html { redirect_to @product }
      end

      else
        @comment.errors.full_messasges.join("/n")
      end

    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @product }
      format.js
    end
  end

  def edit; end

  def update
    @comment = @product.comments.find(params[:id])
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
