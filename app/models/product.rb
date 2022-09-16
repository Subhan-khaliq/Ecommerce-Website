# frozen_string_literal: true

class Product < ApplicationRecord
  after_commit :set_serial, on: :create

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user, dependent: :destroy

  has_many :comments
  has_many :line_items
  has_many_attached :images, dependent: :destroy

  validates :name, :price, presence: true

  validate  :image_type

  scope :with_high_price, ->(price) { where('price > ?',price) }

  def image_type
    errors.add(:images, 'are missing!') if images.attached? == false
    images.each do |image|
      unless image.content_type.in?(%('image/jpeg' 'image/png' 'image/jpg'))
        errors.add(:images, 'needs to be a JPEG,JPG or PNG')
      end
    end
  end

  def set_serial
    update_column(:serial_number, [name, id].join('-'))
  end

  def thumbnail(image)
    images[image].variant(resize: '300x300!').processed
  end
end
