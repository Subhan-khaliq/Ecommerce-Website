# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_product, only: %i[create destroy edit update]
  before_action :set_comment, only: %i[edit destroy update]

  def create
    # authorize @comment
    @comment = @product.comments.create(comment_params.merge(user_id: current_user.id))
    if @comment.persisted?
      respond_to do |format|
        format.js
        format.html { redirect_to @product }
      end
    else
      @comment.errors.full_messasges.join('/n')
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @product }
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to @product }
        format.js
      end
    else
      redirect_to @product, notice: 'Something went wrong.'
    end
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
