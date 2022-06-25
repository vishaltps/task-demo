# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :task, except: :create

      def create
        task = Task.create!(task_params)
        json_response({
                        success: true,
                        message: 'Task created successfully',
                        data: array_serializer.new(task, serializer: Api::V1::TasksSerializer)
                      }, :created)
      end

      def update
        task.update!(task_params)
        json_response({
                        success: true,
                        message: 'Task updated successfully',
                        data: task
                      })
      end

      def destroy
        task.destroy

        json_response({
                        success: true,
                        message: 'Task deleted successfully'
                      })
      end

      private

      def task_params
        params.require(:task).permit(:title, tags_attributes: [:name])
        # ALLOWED_SUBSCRIPTION_PARAMS = [:notes, :subscription_type, :subscription_plan_id, :external_id, :coupon_code, :campaign_id, :trial_period, :trial_period_length, :trial_period_unit, :access_type, :user_limit, allowed_ips: [], payment: ALLOWED_PAYMENT_PARAMS, metadata: {}, dynamic_assets: [:id, :title, :slug, collection_id: []], additional_data: {}].freeze
      end

      def task
        @task ||= Task.find(params[:id])
      end
    end
  end
end
