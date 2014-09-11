class MyValidator < ActiveModel::Validator
  def validate(record)
    age = Date.today.year - record.dob.year
    age -= 1 if Date.today < record.dob + age.years
    if age<17
      record.errors[:dob] << 'should be at least 17 Years old'
    end
  end
   
end

class User < ActiveRecord::Base

  has_secure_password
  has_many :albums,dependent: :destroy
  has_many :blogs, dependent: :destroy
  has_many :comments
	validates :email, presence: true, uniqueness: true, 
						format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , 
						message: "Please enter valid email address."}
	validates :username, presence: true, uniqueness: true
	validates  :dob, presence: true
    validates_with MyValidator
    has_attached_file :picture,:styles=>{ :medium=>"300*300>"}
    validates_attachment :picture, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end
