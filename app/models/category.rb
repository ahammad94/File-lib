class Category < ApplicationRecord
  has_many :subcategories, :dependent => :delete_all
  has_and_belongs_to_many :aggregates
end
