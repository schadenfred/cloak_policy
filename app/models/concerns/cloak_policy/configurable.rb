require 'active_support/concern'

module CloakPolicy

  extend ActiveSupport::Concern

  class Configurable 
  
    def initialize(children=nil)
      @children = children
    end

    def flare 
      {
        name: 'Cloaking Spindle', 
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
              intents << { id: intent.id, name: intent.name, icon: intent.icon, description: intent.description, weight: intent.weight, child_type: "intent", size: (ring_size ),  selected:  false}
            end
            array << { name: child.name, icon: child.icon, description: child.description, size: ring_size, description: child.description, children: descendants(child.scored_settings), intents: intents }         
            # array << { name: child.name, icon: child.icon, description: child.description, children: intents}
          end
        when child.class.name.eql?('CloakPolicy::Vector')
          intents = []
          child.intents.each do |intent| 
            intents << { id: intent.id, name: intent.name, icon: intent.icon, weight: intent.weight, description: intent.description, child_type: "intent", size: ring_size, selected: false }
          end    
          array << { name: child.name, icon: child.icon, description: child.description, children: descendants(child.subvectors), intents: intents }         
          # array << { name: child.name, icon: child.icon, description: child.description, children: intents }
        when child.class.name.eql?('CloakPolicy::Setting')
          array << { name: child.name, icon: child.icon, description: child.we_say, children: descendants(child.choices) }
        when child.class.name.eql?('CloakPolicy::Choice')
          array << { name: child.name, icon: child.setting.icon, weight: child.weight, child_type: 'choice',  size: 100, selected: false }
        end
      end
      array
    end
  end
end