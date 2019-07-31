class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :username, presence: true,
  length: { 
    minimum: 5,
    maximum: 30,
    too_short: "The user name must have at least %{count} characters.",
    too_long: "The user name must have no more than %{count} characters."
  }
  validates :email, presence: true
  validates :password, length: { minimum: 6 }, presence: true

  has_many :books_users

  def is_admin?
    self.role == 1
  end

end
