class User < ApplicationRecord
	

	has_many :shoes
	has_secure_password

 	enum role: [:admin, :user]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

end
