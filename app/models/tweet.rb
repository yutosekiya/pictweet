class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many  :comments
  validates :image, presence: true
  validates :text, presence: true
end
