require 'active_support/concern'

module CloakPolicy

  extend ActiveSupport::Concern

  class Configurable 
  
    def initialize(children=nil)
      @children = children
    end

    def flare 
      {
        name: 'Cloak', 
        children: descendants(@children)
      }
    end
    
    def descendants(children=nil, descendants=nil)
      ring_size = 300 
      array = descendants || []
      children = children || CloakPolicy::Vector.top_level
      children.each do |child| 
        case
        when (child.class.name.eql?('CloakPolicy::Vector') && child.bottom_level?)
          unless child.scored_settings.empty?
            intents = []
            child.intents.each do |intent| 
              intents << { name: intent.name, description: intent.description, weight: intent.weight, child_type: "intent", size: (ring_size / child.scored_settings.count),  selected:  false}
            end
            intents << { name: child.name, description: child.description, size: ring_size, description: child.description, children: descendants(child.scored_settings) }         
            array << { name: child.name, description: child.description, children: intents}
          end
        when child.class.name.eql?('CloakPolicy::Vector')
          intents = []
          child.intents.each do |intent| 
            intents << { name: intent.name, weight: intent.weight, description: intent.description, child_type: "intent", size: ring_size, selected: false }
          end    
          intents << { name: child.name, description: child.description, children: descendants(child.subvectors) }         
          array << { name: child.name, description: child.description, children: intents }
          # array << { name: child.name, child_type: 'vector', children: intents }
        when child.class.name.eql?('CloakPolicy::Setting')
          array << { name: child.name, description: child.we_say, children: descendants(child.choices) }
        when 
          array << { name: child.name, weight: child.weight, child_type: 'choice',  size: 100, selected: false }
        end
      end
      array
    end
  end
end