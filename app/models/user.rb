class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :username,  presence: true, length: { maximum: 50 }
	
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


	has_many :shoes
	has_secure_password
  has_many :authentications, :dependent => :destroy

 	enum role: [:admin, :user]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

    def self.create_with_auth_and_hash(authentication, auth_hash)
      user = User.create!(username: auth_hash[:info]["name"], email: auth_hash["extra"]["raw_info"]["email"], password: auth_hash[:info]["password"])
      user.authentications << (authentication)      
      return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def cart_count
    $redis.scard "cart#{id}"
  end
  

end
