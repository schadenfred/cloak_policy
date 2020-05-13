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
            # hash[:name] = "#{io}: #{child.name}" 
            # hash[:child_type] = 'vector'
            # hash[:intent] = 'least' 
            array << { name: "#{io}: #{child.name}", children: descendants(child.scored_settings) }
          end
        when child.class.name.eql?('CloakPolicy::Vector')
          intent_options(child).each do |io| 
            # hash[:name] = "#{io}: #{child.name}" 
            # hash[:child_type] = 'vector'
            # hash[:intent] = 'least' 
            array << { name: "#{io}: #{child.name}", children: descendants(child.subvectors) }
          end 
        when child.class.name.eql?('CloakPolicy::Setting')
          # array = []
          array << { name: child.name.truncate(20), children: descendants(child.choices) }
          # child.choices.each do |choice| 
          #   array << { name: choice.name, size: 100 }
          # end 
          # hash[:child_type] = 'bottom_level'
          # hash[:name] = child.name 
          # hash[:children] = array
        # when child.respond_to?(:choices) && child.choices.size > 0
        #   hash[:child_type] = 'setting'
        #   hash[:name] = child.name.truncate(20) 
        #   hash[:children] = descendants(child.choices)
        when 
          # hash[:name] = child.name.truncate(20)
          # hash[:child_type] = 'choice'
          # hash[:size] = 100
          array << { name: child.name, size: 100 }
        end
        # array << hash
      end
      array
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