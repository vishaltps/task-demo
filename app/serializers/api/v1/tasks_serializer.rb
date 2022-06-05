class Api::V1::TasksSerializer < ActiveModel::Serializer
  attributes *Task.column_names
  has_many :tags
end
