class User < ActiveRecord::Base
  acts_as_authentic
  has_many :categories
  has_many :tasks, through: :categories
end
