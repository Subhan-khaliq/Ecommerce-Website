# frozen_string_literal: true

class Product < ApplicationRecord
  DEFAULT_SIZE = '300x300!'

  extend FriendlyId

  resourcify

  belongs_to :user, dependent: :destroy

  has_many :comments

  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_items

  has_many_attached :images, dependent: :destroy

  friendly_id :name, use: :slugged

  validates :name, :price, presence: true

  validate  :image_type

  scope :with_high_price, ->(price) { where('price > ?', price) }

  after_commit :set_serial, on: :create

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
    images[image].variant(resize: DEFAULT_SIZE).processed
  end
end
