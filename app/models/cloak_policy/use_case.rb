module CloakPolicy
  class UseCase < Category

    belongs_to :profile, foreign_key: :parent_id, class_name: 'Profile'

    has_one :recommendations_use_case, dependent: :destroy
    has_one :default_recommendation, through: :recommendations_use_case, source: :recommendation

    has_many :preferences_use_cases
    has_many :preferences, through: :preferences_use_cases

    accepts_nested_attributes_for :recommendations_use_case

    def self.use_case_types

      {
        personal: "Keep in touch with friends and family.",
        business: "Network and stay intouch with people important for my job.",
        broadcast: "Broadcast my interests and messages to the world."
      }
    end

  end

end
