class Recipe < ApplicationRecord

  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :ingredients, dependent: :destro
  has_many :steps, dependent: :destroy
  has_one_attached :image

end
