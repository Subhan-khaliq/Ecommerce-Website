# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates_presence_of :content
  validates_presence_of :id
  validates_presence_of :product_id
  validates_presence_of :user_id

  def is_writer?
    current_user.comment.exists?
  end
end
