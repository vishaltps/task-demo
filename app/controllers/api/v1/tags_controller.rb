class Api::V1::TagsController < ApplicationController
  def popular
    tags = Tag.joins(:tasks).group('tags.id').order('COUNT(tasks.id) desc')
    json_response({
                    success: true,
                    data: array_serializer.new(tags, each_serializer: Api::V1::TagsSerializer)
                  }, 200)
  end
end
