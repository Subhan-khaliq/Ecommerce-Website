# frozen_string_literal: true

class CommentPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def create?
    @user.has_role?
  end
end
