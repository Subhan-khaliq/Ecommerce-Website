# frozen_string_literal: true

class User < ApplicationRecord
  IMAGE_SIZE = '150x150!'

  rolify

  attr_accessor :first_name, :last_name

  belongs_to :resource, polymorphic: true

  has_one_attached :avatar

  has_many :comments
  has_many :orders, dependent: :destroy
  has_many :products

  validate :must_have_a_role, on: :destroy

  before_validation :set_names

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: IMAGE_SIZE).processed

    else
      '/default_image.jpg'
    end
  end

  def is_writer?(user_id, owner_id)
    return true if user_id == owner_id
  end

  private

  def set_names
    self.full_name = [first_name, last_name].join(' ')
  end

  def must_have_a_role
    errors.add(:roles, 'must have at least 1 role') unless roles.any?
  end
end
