class Item < ActiveRecord::Base
  validates :todo, presence: true, uniqueness: true
  validates_presence_of :list_id

  belongs_to :user
  belongs_to :list
end