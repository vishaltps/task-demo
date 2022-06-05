class Api::V1::TagsSerializer < ActiveModel::Serializer
  attributes *Tag.column_names
end
