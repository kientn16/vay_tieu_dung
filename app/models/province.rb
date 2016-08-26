class Province < ActiveRecord::Base
  belongs_to :parent_location, class_name: Province
  has_many :child_locations, class_name: Province, foreign_key: "parent_id"
end
