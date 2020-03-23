class Document < ApplicationRecord
  belongs_to :org, polymorphic: true
  belongs_to :regulator, foreign_key: :org_id, class_name: "Org"
  belongs_to :service, foreign_key: :org_id, class_name: "Org"

  has_many_attached :documents_versions
end
