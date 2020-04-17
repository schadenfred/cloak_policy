module CloakPolicy
  class Score < ApplicationRecord

    belongs_to :scorable, polymorphic: true
    belongs_to :vector

    validates :scorable, :vector, presence: true
    validates :vector_id, uniqueness: { scope: :scorable }

    default_scope { order(weight: :desc) }

    after_create :create_child_scores
    after_destroy :destroy_child_scores

    private

    def create_child_scores

      if self.scorable_type.eql?("Setting")
        self.scorable.choices.each do |c|
          c.scores.create(vector_id: self.vector_id)
        end
      end
    end

    def destroy_child_scores

      if self.scorable_type.eql?("Setting")
        self.scorable.choices.each do |c|
          c.scores.where(vector_id: self.vector_id).destroy_all
        end
      end
    end
  end
end
