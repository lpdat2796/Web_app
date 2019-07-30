class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :username, length: { minimum: 3 }, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 6 }, presence: true


  has_many :books_users

  def is_admin?
    self.role == 1
  end

end
