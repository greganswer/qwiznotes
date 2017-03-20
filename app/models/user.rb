class User < ApplicationRecord
  ## VALIDATIONS

  validates :email, :name, uniqueness: { case_sensitive: false }, presence: true
  validates :name, format: { with: /\A[-\w]+\z/ }

  ## CALLBACKS

  before_validation :create_unique_name_from_email, on: :create

  ## DEVISE

  # add :omniauthable

  devise *%i(
    database_authenticatable
    lockable
    recoverable
    registerable
    rememberable
    timeoutable
    trackable
    validatable
  )

  def to_s
    name
  end

  private

  # Example: john_76@mail.com -> john_76
  def create_unique_name_from_email
    name = email.to_s.split("@").first
    last_user = User.where("name LIKE ?", "#{name}%").order(:name).last
    if last_user
      number = 2
      last_part = last_user.name.split('-').last
      number = last_part.to_i + 1 if last_part && last_part.to_i.to_s == last_part
      name = "#{name}-#{number}"
    end
    self.name = name
  end
end
