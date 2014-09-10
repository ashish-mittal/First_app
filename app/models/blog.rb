class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :description, presence: :true
  validates :title, presence: :true
end
