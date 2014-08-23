class Role < ActiveRecord::Base

  has_many :user_roles

  def admin?
    self.admin.present
    # or just admin
  end

end
