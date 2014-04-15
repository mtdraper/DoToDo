class Category < ActiveRecord::Base
  validates :category_id, presence: true
  has_many :tasks
  belongs_to :user
end
