class User < ApplicationRecord
  has_many :notes, dependent: :destroy

  validates :email, :name, uniqueness: { case_sensitive: false }, presence: true
  validates :name, format: { with: /\A[-\w]+\z/ }

  before_validation :create_unique_name_from_email, on: :create

  # TODO: add :omniauthable
  devise :database_authenticatable,
    :confirmable,
    :lockable,
    :recoverable,
    :registerable,
    :rememberable,
    :timeoutable,
    :trackable,
    :validatable

  def to_s
    name
  end

  def owns?(model)
    id == model.try(:user_id)
  end


  private

  # Creates a unique name based on the user's email address
  #
  #   @user = User.create(email: "john-76@mail.com")
  #   @other_user = User.create(email: "john-76@example.com")
  #   @user.name           # => "john-76"
  #   @other_user.name # => "john-76-2"

  def create_unique_name_from_email
    return if name.present?
    name = email.to_s.split("@").first&.gsub('.', '-')
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
