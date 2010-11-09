class User < ActiveRecord::Base
  include ActiveModel::Validations
  acts_as_authentic do |c|
    c.login_field= :username
  end

  attr_accessible :username, :email, :password, :password_confirmation

  has_many :memberships, :class_name => "Project::Membership"
  has_many :projects, :through => :memberships
  has_one :profile
  has_many :owned_projects, :class_name => "Project"

  validates :username, :presence => true, :uniqueness => true
  
  # This should not be validated! crypted_password should be!
  #validates :password, :presence => true
  #validates :password_confirmation, :presence => true
  validates :crypted_password, :presence => true

  def activate!
    self.active = true
    save
  end

  def email
    self.profile.email
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end

  def deliver_welcome!
    reset_perishable_token!
    Notifier.deliver_welcome(self)
  end
end
