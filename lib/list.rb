class List < ActiveRecord::Base
  validates :list_name, presence: true, uniqueness: true

  has_many :items
end
