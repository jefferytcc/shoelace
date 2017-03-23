class User < ApplicationRecord
  before_validation :downcase_email
  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password_digest, length: { minimum: 6 }


	has_many :shoes
	has_secure_password
  has_many :authentications, :dependent => :destroy

  has_many :purchases, foreign_key: :buyer_id
  has_many :shoes, through: :purchases

 	enum role: [:admin, :user]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

    def self.create_with_auth_and_hash(authentication, auth_hash)
     create! do |u|
      u.username = auth_hash[:info]["name"]
      u.password = "PLACEHOLDER"
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end



  #downcase email
  def downcase_email
    self.email = email.downcase if email.present?
  end

  #cart method
  def cart_count
    $redis.scard "cart#{id}"
  end
  
  def cart_total_price
    total_price = 0
    get_cart_shoes.each { |shoe| total_price+= shoe.price }
    total_price
  end

  def get_cart_shoes
    cart_ids = $redis.smembers "cart#{id}"
    Shoe.find(cart_ids)
  end

 # Purchasing methods
  def purchase_cart_shoes!
    get_cart_shoes.each { |shoe| purchase(shoe) }
    $redis.del "cart#{id}"
  end

  def purchase?(shoe)
    shoes.include?(shoe)
  end

  def purchase(shoe)
    shoes << shoe unless purchase?(shoe)
  end

end
