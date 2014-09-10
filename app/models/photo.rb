class Photo < ActiveRecord::Base
  belongs_to :album
  validates :album, presence: true
  has_attached_file :image,:styles=>{ :large=>"300*300>"}
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
