module CloakPolicy

  class Vector < ApplicationRecord

    include Scorable

    belongs_to :parent, class_name: "Vector", optional: true

    has_many :scored, class_name: 'Score', foreign_key: :vector_id, dependent: :destroy
    has_many :scored_settings,   through: :scored, source: :scorable, source_type: 'CloakPolicy::Setting'
    has_many :scored_subvectors, through: :scored, source: :scorable, source_type: 'CloakPolicy::Vector'
    has_many :subvectors, class_name: "CloakPolicy::Vector", foreign_key: :parent_id

    validates :name, presence: true
    validates :name, uniqueness: { scope: :parent_id }

    scope :top_level, -> { where(parent_id: nil) }
    scope :bottom_level, -> { where.not(id: pluck(:parent_id)) }

    after_create :create_score

    before_destroy { |record| Vector.where(parent_id: record.id).update_all(parent_id: nil )   }

    def self.bottom_level
      where.not(id: pluck(:parent_id))
    end

    def bottom_level?
      subvectors.empty? ? true : false
    end

    def full_name
      parent_id.nil? ? self["name"] : [parent.full_name, self["name"]].join(" >> ")
    end

    def child_settings(array=nil)
      array = array || []      
      subvectors.each { |sv| sv.child_settings(array) } 
      scored_settings.each { |s| array << s } 
      array
    end

    private

    def create_score
      scores.create(vector_id: parent_id.nil? ? self['id'] : self['parent_id'] )
    end
  end
end