class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Relations with other models
  has_many :vacations

  attr_accessor :login

  # Validations
  validates_presence_of :username, :first_name, :last_name
  validates :username,
  :uniqueness => {
    :case_sensitive => false
  }

  # overrides devise's default 'sign in by email only' authentication method
  def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
      else
        where(conditions).first
      end
  end
end
