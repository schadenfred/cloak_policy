class Domain < ApplicationRecord

  belongs_to :platform, optional: true
  belongs_to :domainable, polymorphic: true
end
