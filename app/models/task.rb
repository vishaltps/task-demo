class Task < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  accepts_nested_attributes_for :tags
end
