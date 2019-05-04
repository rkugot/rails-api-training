class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true, presence: true

  before_validation :generate_names, if: proc { |user| user.first_name.blank? && user.last_name.blank? }
  before_save :downcase_email, :capitalize_names, :generate_api_key

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def generate_names
    self.first_name = Faker::Name.first_name
    self.last_name = Faker::Name.last_name
  end

  def downcase_email
    email.downcase!
  end

  def capitalize_names
    first_name.capitalize!
    last_name.capitalize!
  end

  def generate_api_key
    self.api_key = SecureRandom.hex
  end
end
