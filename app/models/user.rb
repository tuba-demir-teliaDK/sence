class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token,:apple_id
  
  has_many :questions
  has_many :answers
  has_one  :profile
  
  accepts_nested_attributes_for :profile
  
  def ensure_authentication_token!   
    reset_authentication_token! if authentication_token.blank?   
  end 

  before_save :ensure_authentication_token! 
  after_create :create_profile
  
   #authorizations
  ROLES = %w[admin moderator author banned]
  
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end
  
  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end
  
  def is?(role)
    roles.include?(role.to_s)
  end
  
end
