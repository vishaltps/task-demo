# frozen_string_literal: true

module Api
  module V1
    class TasksSerializer < ActiveModel::Serializer
      attributes(*Task.column_names)
      has_many :tags
    end
  end
end
