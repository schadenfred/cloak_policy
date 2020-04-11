module CloakPolicy

  class Vector < ApplicationRecord

    include Scorable

    belongs_to :parent, class_name: "Vector", optional: true

    has_many :scored, class_name: 'Score', foreign_key: :vector_id, dependent: :destroy
    has_many :scored_subvectors, through: :scored, source: :scorable, source_type: 'Vector'
    has_many :settings, through: :scored, source: :scorable, source_type: 'Setting'
    has_many :subvectors, class_name: "Vector", foreign_key: :parent_id

    validates :name, presence: true
    validates :name, uniqueness: { scope: :parent_id }

    scope :top_level, -> { where(parent_id: nil) }
    after_create :create_score

    before_destroy { |record| Vector.where(parent_id: record.id).update_all(parent_id: nil )   }

    def full_name
      parent_id.nil? ? self["name"] : [parent.full_name, self["name"]].join(" >> ")
    end

    def all_settings(subsettings=nil)
      scored_subvectors.each {|sv| settings << sv.all_settings }
      self.settings
    end

    private

    def create_score
      scores.create(vector_id: parent_id.nil? ? self['id'] : self['parent_id'])
    end
  end

end