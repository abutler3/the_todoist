class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %w[admin moderator author banned]

  has_many :todos
  belongs_to :role

  def is?(admin)
    roles.include?(role.to_s)
    # or just admin
  end
end
