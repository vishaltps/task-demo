# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Tasks', type: :request do
  describe 'POST create' do
    it 'should create the task' do
      post '/api/v1/tasks', params: { task: { title: 'do this task', tags_attributes: [{ name: 'twitter' }] } }
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)

      expect(parsed_response['success']).to eq true
      expect(parsed_response['message']).to eq 'Task created successfully'
      expect(parsed_response.dig('data', 'title')).to eq 'do this task'
      expect(parsed_response.dig('data', 'tags', 0, 'name')).to eq 'twitter'
    end

    it 'should throw error when title is not present' do
      post '/api/v1/tasks', params: { task: { title: '' } }
      expect(response.status).to eq 500
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['success']).to eq false
      expect(parsed_response.dig('errors', 'title', 0)).to eq "can't be blank"
    end
  end

  describe 'PUT update' do
    it 'should update the task' do
      task = create(:task)
      put "/api/v1/tasks/#{task.id}", params: { task: { title: 'task has changed' } }
      expect(response.status).to eq 200
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['success']).to eq true
      expect(parsed_response['message']).to eq 'Task updated successfully'
      expect(parsed_response.dig('data', 'title')).to eq 'task has changed'
    end
  end

  describe 'DELETE destroy' do
    it 'should delete the record' do
      task = create(:task)
      delete "/api/v1/tasks/#{task.id}"
      expect(response.status).to eq 200
      expect(Task.exists?(task.id)).to be false
    end
  end
end
