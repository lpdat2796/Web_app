class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true,
  length: { 
    minimum: 3,
    maximum: 30,
    too_short: " must have at least %{count} characters.",
    too_long: "must have no more than %{count} characters."
  }
  validates :email, presence: true
  validates :password, length: { minimum: 6 }, presence: true

  has_many :books_users

  def is_admin?
    self.role == 1
  end

end
