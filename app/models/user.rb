class User < ActiveRecord::Base
	has_many :ideas
	has_many :likes

attr_accessor :password, :confirm_password
  

email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	validates :name, presence: true, length: { maximum: 30 }

	validates :alias, presence: true, length: { maximum: 30 }

	validates :email, presence: true, format: { with: email_regex }, uniqueness: { case_sensitive: false }

	#this validates the form input password

	validates :password, :confirm_password, presence: true, length: { within: 4..10 }

before_save :encrypt_password

  def has_password?(submitted_password)
  	encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
  	user = find_by_email(email)

   	return nil if user.nil?
   	return user if user.has_password?(submitted_password)
  end

  private
  	def encrypt_password
  		self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{password}") 
  		self.encrypted_password = encrypt(password)
  	end
  	def encrypt(pass)
  		Digest::SHA2.hexdigest("#{self.salt}--#{pass}")
  	end

end
