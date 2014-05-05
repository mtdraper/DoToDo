class Task < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  validates :category_id, presence: true
end
