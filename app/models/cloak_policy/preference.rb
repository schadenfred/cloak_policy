module CloakPolicy

  class Preference < Category
    include Scorable

    has_many :preferences_recommendations
    has_many :recommendations, through: :preferences_recommendations
    has_many :preferences_use_cases
    has_many :use_cases, through: :preferences_use_cases

    def chart_data
      array = []
      Vector.all.each do |v|
        array << (scores.where(vector_id: v.id).first.try(:points) || "null")
      end
      array
    end
  end

end