require 'active_support/concern'

module CloakPolicy

  extend ActiveSupport::Concern

  class Configurable 

  
    def initialize(recommendation=nil, children=nil)
      @recommendation = recommendation
    end

    def flare 
      {
        name: 'flare', 
        children: descendants
      }
    end
    
    def descendants(children=nil, descendants=nil)
      descendants = descendants || []
      children = children || CloakPolicy::Vector.top_level
      children.each do |child| 
        hash = {}
        case
        when child.respond_to?(:subvectors) && child.subvectors.size > 0
          hash[:name] = child.name
          hash[:child_type] = 'vector'
          hash[:intent] = 'least' 
          array = []
          intent_options(child).each do |io| 
            array << { name: io, children: descendants(child.subvectors) }
          end 
          hash[:children] = array
        when child.respond_to?(:scored_settings) && child.scored_settings.size > 0
          array = []
          intent_options(child).each do |io| 
            array << { name: io, children: descendants(child.scored_settings) }
          end 
          hash[:name] = child.name 
          hash[:children] = array
        when child.respond_to?(:choices) && child.choices.size > 0
          hash[:name] = child.name.truncate(20) 
          hash[:children] = descendants(child.choices)
        when 
          hash[:name] = child.name.truncate(20)
          hash[:size] = 100
        end
        descendants << hash
      end
      descendants
    end
      
    def intent_options(vector, counts=nil)
      counts = counts || []
      vector.scored_settings.each { |s| counts << s.choices.count } 
      vector.subvectors.each { |sv| intent_options(sv, counts) } 
      case counts.max_by { |ic| ic}
      when 2 
        %w(off on)
      when 3 
        %w(least middle most)
      when 4 
        %w(least lower more most)
      when 5
        %w(least lower middle more most)
      end
    end
  end
end