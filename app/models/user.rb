class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  before_destroy :do_not_destroy_last_admin
  before_update :change_admin

  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  private
  def do_not_destroy_last_admin
    if self.admin? && User.where(admin: :true).count < 2
      throw :abort
    end
  end

  def change_admin
    if User.where(admin: true).count == 1 && self.will_save_change_to_admin?(from: true, to: false)
      errors.add :base, "管理者が一人も居ない状態にはできません！"
      throw(:abort)
    end
  end
end
