class User < ApplicationRecord
  acts_as_token_authenticatable

  ## for Devise. Include default devise modules. Others available are:
  ## :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :invitable, :recoverable,
         :registerable, :rememberable, :validatable

  ROLES = %w[admin owner site_admin]

  INSTALLATION_STEPS = %w[initial]

  ROLES.each do |r|
    role_name = r.parameterize separator: '_'
    define_method("#{role_name}?") { role_name == role }
    scope role_name, -> { where(role: r) }
  end

  belongs_to :use_case, optional: true, class_name: 'Category'
  belongs_to :account, optional: true

  has_one :account_owned, foreign_key: :owner_id, class_name: 'Account'

  has_many :subscriptions, dependent: :destroy
  has_many :invitations, class_name: 'User', as: :invited_by
  has_many :preferences_users
  has_many :preferences, through: :preferences_users, class_name: "Preference"

  has_many :subscriptions

  def profile
    case
    when use_case.nil?
      'None selected'
    when use_case.profile.nil?
      'None selected'
    when use_case.profile
      use_case.profile.name
    end
  end

  def accept_use_case(use_case)
    skip_confirmation!
    update_attribute(:use_case_id, use_case.id)
    ucp = use_case.preferences
    ucp.each { |p| preferences_users.create(preference_id: p.id)}
  end

  before_create :set_refresh_token
  def set_refresh_token
    self.refresh_token = Devise.friendly_token
  end

  before_create :set_installation_step
  def set_installation_step
    self.installation_step = "initial"
  end

  after_commit :set_authenticated_at, on: [:create, :update]
  def set_authenticated_at
    before, after = previous_changes[:authentication_token]
    if before != after
      update authenticated_at: Time.now
    end
  end

  protected

  def password_required?
    confirmed? ? super : false
  end
end
