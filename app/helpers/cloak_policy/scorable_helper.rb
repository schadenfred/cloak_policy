module ScorableHelper

  def scorable_score_path(scorable, vector_id)
    case scorable.class.name.to_s

    when "Recommendation"
      recommendation_score_path(id: vector_id)
    end
  end

  def scorable_path(scorable)
    case scorable.class.name.to_s

    when "Recommendation"
      scorable
    end
  end

  def update_scorable_path(scorable)
    case scorable.class.name.to_s

    when "Recommendation"
      update_scorable_path(scorable)
    end
  end

  def scorable_parent(scorable)
    case scorable.class.name.to_s
    when "Recommendation"
      scorable.recommendations_services
    end
  end

  def total_weight(service=nil, vector=nil)
    vector = vector || @vector
    service = service || @scorable
    total_weight = @scorable.weights_for(@vector.name).sum
    total_weight
  end
end

