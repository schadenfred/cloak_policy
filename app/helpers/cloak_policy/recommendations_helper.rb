module RecommendationsHelper

  def advice_for(recommendation, choice)
    chosen = recommendation.chosens.find_by(choice_id: choice.id)
    chosen.nil? ? "nothing to say" : chosen.advice
  end

  def setting_status(recommendation, setting)
    if recommendation.chosens.pluck(:setting_id).include? setting.id
      "card-full-success"
    else
      "card-full-warning"
    end
  end
end
