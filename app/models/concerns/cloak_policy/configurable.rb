require 'active_support/concern'

module CloakPolicy

  extend ActiveSupport::Concern

  class Configurable 

  
    def initialize(user=nil)
    
    end

    def flare 
      {
        name: 'Cloak', 
        children: descendants
      }
    end
    
    def descendants(children=nil, descendants=nil)
      array = descendants || []
      children = children || CloakPolicy::Vector.top_level
      children.each do |child| 
        case
        when (child.class.name.eql?('CloakPolicy::Vector') && child.bottom_level?)
          unless child.scored_settings.empty?
            intents = []
            child.intents.each do |intent| 
              intents << { name: intent.name, children: descendants(child.scored_settings), selected:  false}
            end
          end
          array << { name: child.name, children: intents }
        when child.class.name.eql?('CloakPolicy::Vector')
          intents = []
          child.intents.each do |intent| 
            intents << { name: intent.name, children: descendants(child.subvectors), selected: false }
          end             
          array << { name: child.name, child_type: 'vector', children: intents }
        when child.class.name.eql?('CloakPolicy::Setting')
          array << { name: child.name, child_type: 'intent', children: descendants(child.choices) }
        when 
          array << { name: child.name, size: 100, selected: false }
        end
      end
      array
    end
  end
end