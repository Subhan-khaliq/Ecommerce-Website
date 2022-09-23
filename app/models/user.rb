# frozen_string_literal: true

class User < ApplicationRecord
  rolify

  attr_accessor :first_name, :last_name

  validate :must_have_a_role, on: :destroy

  has_many :comments
  has_many :orders, dependent: :destroy
  has_many :products

  # belongs_to :resource, polymorphic: true

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

  def must_have_a_role
    errors.add(:roles, 'must have at least 1 role') unless roles.any?
  end
end
