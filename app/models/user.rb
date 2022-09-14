# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :first_name, :last_name

  has_many :products

  has_one_attached :avatar

  before_validation :set_names

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: '150x150!').processed

    else
      '/default_image.jpg'
    end
  end

  private

  def set_names
    self.full_name = [first_name, last_name].join(' ')
  end
end
