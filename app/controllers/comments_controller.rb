class CommentsController < ApplicationController
  def create
    @comment = @product.comments.create(comment_params)
    @comment.save
    redirect_to @product
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
