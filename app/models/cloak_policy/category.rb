class Category < ApplicationRecord

  include RankedModel
  ranks :row_order

  belongs_to :parent, class_name: "Category", optional: true

  has_many :settings

  scope :sorted, -> { order( row_order: :asc) }
  scope :for_settings, -> { where(type: "Category") }


  validates :name, presence: true

  def self.top_level
    where(parent_id: nil)
  end

  def icon
    self["icon"] || default_icon
  end

  def default_icon
    parent.nil? ? "rss" : parent.icon
  end
end
