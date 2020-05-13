require 'active_support/concern'

module CloakPolicy

  extend ActiveSupport::Concern

  class Configurable 

  
    def initialize(recommendation=nil, children=nil)
      @recommendation = recommendation
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
        hash = {}
        case
        when (child.class.name.eql?('CloakPolicy::Vector') && child.bottom_level?)
          intent_options(child).each do |io| 
            # array << { name: intent_cta(child, io), child_type: 'intent',  children: descendants(child.scored_settings) }
            array << { name: intent_cta(child, io), size: 300 }
          end
          array << { name: child.name, children: descendants(child.scored_settings) }
        when child.class.name.eql?('CloakPolicy::Vector')
          array << { name: child.name, children: descendants(child.subvectors) }
          intent_options(child).each do |io| 
            array << { name: intent_cta(child, io), size: 300 }
          end 
        when child.class.name.eql?('CloakPolicy::Setting')
          array << { name: child.name.truncate(20), child_type: 'intent', children: descendants(child.choices) }
        when 
          array << { name: child.name, size: 100 }
        end
      end
      array
    end

    def intent_cta(vector, io)
      # fullname = vector.name
      "Choose #{io} #{fullname(vector)}"
    end

    def fullname(vector, parent=nil)
      if vector.parent.nil?
        fullname = vector.name
      else 
        fullname = "#{vector.name} #{vector.parent.name}" 
      end
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