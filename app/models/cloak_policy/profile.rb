module CloakPolicy
  class Profile < Category


    has_many :use_cases, foreign_key: :parent_id, dependent: :destroy

    accepts_nested_attributes_for :use_cases
  end
end
