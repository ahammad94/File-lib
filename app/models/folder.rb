class Folder < ApplicationRecord
  belongs_to :parent, class_name: "Aggregate", foreign_key: "id"
  has_many :content, class_name: "Aggregate", foreign_key: "id"
end

