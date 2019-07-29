class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :books_users
  scope :unowned, -> { left_joins(:books_users).where(books_users: { book_id: nil }) }

  def is_admin?
    self.role == 1
  end

end
