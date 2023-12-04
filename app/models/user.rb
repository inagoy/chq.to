class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true, length: { minimun: 3, maximum: 50 } do
    validates :username, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\z/ }
    validates :first_name, :last_name, format: { with: /\A[a-zA-ZñáéíóúÁÉÍÓÚüÜ]+\z/ }
  end

  has_many :links, dependent: :destroy

end
