class Aggregate < ApplicationRecord
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :subcategories
  has_many :contents, :class_name => "folder"
end
