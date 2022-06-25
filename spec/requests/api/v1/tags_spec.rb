# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Tags', type: :request do
  describe 'GET popular_tags' do
    before do
      3.times do |i|
        create(:task, title: "task_no_#{i}")
      end
      @tag_1 = create(:tag, name: 'facebook')
      @tag_2 = create(:tag, name: 'twitter')
      Task.second.tags << @tag_1
      Task.second.tags << @tag_2
      Task.first.tags << @tag_2
    end

    it 'should fetch popular tags' do
      get '/api/v1/tags/popular'
      expect(response.status).to eq 200
      parsed_response = JSON.parse(response.body)

      expect(parsed_response['success']).to eq true
      expect(parsed_response['data'].length).to eq 2
      expect(parsed_response.dig('data', 0, 'id')).to eq @tag_2.id
      expect(parsed_response.dig('data', 1, 'id')).to eq @tag_1.id
    end
  end
end
