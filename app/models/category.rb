class Category < ApplicationRecord
  has_many :subcategories
  has_and_belongs_to_many :aggregates
end
