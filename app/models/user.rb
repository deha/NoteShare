class User < ActiveRecord::Base
  has_many :permission_for_notes, :dependent => :destroy
  has_many :notes, :through => :permission_for_notes
  has_many :permission_for_folders, :dependent => :destroy
  has_many :folders, :through => :permission_for_folders

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :first_name, :last_name

end
