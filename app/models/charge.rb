class Charge < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  has_one :theme
end
