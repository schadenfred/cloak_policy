class Account < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :users
  has_many :domains, as: :domainable
  has_many :subscriptions, dependent: :destroy

  accepts_nested_attributes_for :domains

  def suggested_users
    User.where("email ilike any (array[?])", domains.pluck(:fqdn).map { |domain| "%#{domain}%" })
  end
end
