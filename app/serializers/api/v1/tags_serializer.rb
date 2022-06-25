# frozen_string_literal: true

module Api
  module V1
    class TagsSerializer < ActiveModel::Serializer
      attributes(*Tag.column_names)
    end
  end
end
