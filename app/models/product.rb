class Product < ApplicationRecord
  after_commit :unique_serial, :on => :create

  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :user
  has_many_attached :images,  dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true
  validate  :image_type

  def image_type
    if images.attached? == false
      errors.add(:images, "are missing!")
    end
    images.each do |image|
      if !image.content_type.in?(%('image/jpeg' 'image/png' 'image/jpg'))
        errors.add(:images, "needs to be a JPEG,JPG or PNG")
      end
    end

  end


  def unique_serial
    self.update_column(:serial_number, [name, id].join('-'))
  end

  def thumbnail(image)
    return self.images[image].variant(resize: '300x300!').processed
  end

end
