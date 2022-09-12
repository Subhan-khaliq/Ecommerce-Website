# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :first_name
  attr_accessor :last_name
  has_one_attached :avatar

  before_validation :set_names

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "150x150!").processed
    else
      "/default_image.jpg"
    end
  end

  private

  def set_names
    self.full_name = [first_name, last_name].join(' ')
  end

  # def first_name
  #   split = full_name.split(' ', 2)
  #   self.first_name = split.first
  # end

  # def last_name
  #   split = full_name.split(' ', 2)
  #   self.last_name = split.last
  # end

  # # Setter
  # def first_name=(name)
  #   self.full_name = name
  # end

  # def last_name=(name)
  #   self.full_name = " ",name
  # end

end
