class User < ApplicationRecord
	

	has_many :shoes
	has_secure_password
  has_many :authentications, :dependent => :destroy

 	enum role: [:admin, :user]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

    def self.create_with_auth_and_hash(authentication, auth_hash)
      user = User.create!(name: auth_hash["name"], email: auth_hash["extra"]["raw_info"]["email"], password: auth_hash)
      user.authentications << (authentication)      
      return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end
  

end
